#' A fast replacement to dplyr::count()
#'
#' @description
#' Near-identical alternative to `dplyr::count()`.
#'
#' @param data A data frame.
#' @param ... Variables to group by.
#' @param wt Frequency weights.
#'   Can be `NULL` or a variable:
#'
#'   * If `NULL` (the default), counts the number of rows in each group.
#'   * If a variable, computes `sum(wt)` for each group.
#' @param sort If `TRUE`, will show the largest groups at the top.
#' @param order Should the groups be calculated as ordered groups?
#' If `FALSE`, this will return the groups in order of first appearance,
#' and in many cases is faster.
#' If `TRUE` (the default), the groups are returned in sorted order,
#' exactly the same way as `dplyr::count`.
#' @param name The name of the new column in the output.
#'  If there's already a column called `n`,
#'  it will use `nn`.
#'  If there's a column called `n` and `n`n,
#'  it'll use `nnn`, and so on, adding `n`s until it gets a new name.
#' @param .by (Optional). A selection of columns to group by for this operation.
#' Columns are specified using tidy-select.
#' @param .cols (Optional) alternative to `...` that accepts
#' a named character vector or numeric vector.
#' If speed is an expensive resource, it is recommended to use this.
#'
#' @details
#' This is a fast and near-identical alternative to dplyr::count() using the `collapse` package.
#' Unlike `collapse::fcount()`, this works very similarly to `dplyr::count()`.
#' The only main difference is that anything supplied to `wt`
#' is recycled and added as a data variable.
#' Other than that everything works exactly as the dplyr equivalent.
#'
#' `f_count()` and `f_add_count()` can be up to >100x faster than the dplyr equivalents.
#'
#' @returns
#' A `data.frame` of frequency counts by group.
#'
#' @export
f_count <- function(data, ..., wt = NULL, sort = FALSE,
                    order = df_group_by_order_default(data),
                    name = NULL, .by = NULL, .cols = NULL){
  if (dots_length(...) == 0 && rlang::quo_is_null(rlang::enquo(.by)) && is.null(.cols)){
    return(
      count_simple(data, ..., wt = !!rlang::enquo(wt), sort = sort, order = order,
                   name = name, .by = {{ .by }}, .cols = .cols)
    )
  }
  group_vars <- group_vars(data)
  group_info <- tidy_group_info(data, ..., .by = {{ .by }},
                                .cols = .cols,
                                ungroup = TRUE,
                                rename = TRUE)
  data_transformed <- group_info[["data"]]
  all_vars <- group_info[["all_groups"]]
  N <- df_nrow(data_transformed)
  # Weights
  if (!rlang::quo_is_null(rlang::enquo(wt))){
    out_info <- mutate_summary_grouped(data_transformed, !!rlang::enquo(wt))
    wt_var <- out_info[["cols"]]
    data_transformed <- out_info[["data"]]
  } else {
    wt_var <- character()
  }
  if (length(wt_var) > 0L){
    wtv <- data_transformed[[wt_var]]
  }
  use_only_grouped_df_groups <- !group_info[["groups_changed"]] && (
    length(all_vars) == 0L ||
      (order && length(group_vars) > 0L && length(group_vars) == length(all_vars))
  )
  if (use_only_grouped_df_groups){
    g <- df_to_GRP(data, return.order = FALSE, order = order, return.groups = TRUE)
  } else {
    g <- df_to_GRP(data_transformed, .cols = all_vars, return.order = FALSE,
                   order = order, return.groups = TRUE)
  }
  out <- GRP_groups(g)
  if (is.null(out)){
    out <- f_select(data_transformed, .cols = all_vars)
    gstarts <- GRP_starts(g)
    out <- df_row_slice(out, gstarts, reconstruct = FALSE)
  }
  group_sizes <- GRP_group_sizes(g)
  if (length(all_vars) == 0L){
    g <- NULL
  }
  N <- df_nrow(out)
  if (is.null(name)){
    name <- unique_count_col(out)
  }
  # Edge-case, not sure how to fix this
  if (N == 0L && length(all_vars) == 0L){
    out <- df_init(out, 1L)
  }
  if (length(wt_var) == 0){
    nobs <- group_sizes
  } else {
    nobs <- collapse::fsum(as.double(wtv),
                           g = g,
                           na.rm = TRUE,
                           use.g.names = FALSE,
                           fill = FALSE)
    if (isTRUE(all_integerable(nobs))){
      nobs <- as.integer(nobs)
    }
    # Replace NA with 0
    nobs[cheapr::which_na(nobs)] <- 0L
  }
  out[[name]] <- nobs
  if (sort){
    row_order <- order(-nobs)
    out <- df_row_slice(out, row_order)
  }
  reconstruct(data, out)
}
# A basic and very fast count() method
# The above method is faster when there are many groups
# because creating the list of group locations through
# group_by() is unnecessarily expensive
# If the data is already grouped and no variables are supplied
# through ..., then this is very fast
count_simple <- function(data, ..., wt = NULL, sort = FALSE,
                         order = df_group_by_order_default(data),
                         name = NULL, .by = NULL, .cols = NULL){
  out <- f_group_by(data, ..., .add = TRUE,
                    order = order, .cols = .cols,
                    .by = {{ .by }})
  if (!rlang::quo_is_null(rlang::enquo(wt))){
    out_info <- mutate_summary_ungrouped(out, !!rlang::enquo(wt))
    wt_var <- out_info[["cols"]]
    weights <- out_info[["data"]][[wt_var]]
  } else {
    weights <- NULL
  }
  if (is.null(name)){
    name <- unique_count_col(group_vars(out))
  }
  out <- df_count(out, weights = weights, name = name)
  if (sort){
    out <- f_arrange(out, desc(.data[[name]]))
  }
  reconstruct(data, out)
}
add_count_simple <- function(data, ..., wt = NULL, sort = FALSE,
                             order = df_group_by_order_default(data),
                             name = NULL, .by = NULL, .cols = NULL){
  out <- f_group_by(data, ..., .add = TRUE,
                    order = order, .cols = .cols,
                    .by = {{ .by }})
  if (!rlang::quo_is_null(rlang::enquo(wt))){
    out_info <- mutate_summary_ungrouped(out, !!rlang::enquo(wt))
    wt_var <- out_info[["cols"]]
    weights <- out_info[["data"]][[wt_var]]
  } else {
    weights <- NULL
  }
  if (is.null(name)){
    name <- unique_count_col(out)
  }
  out <- df_add_count(out, weights = weights, name = name)
  if (sort){
    out <- f_arrange(out, desc(.data[[name]]))
  }
  reconstruct(data, out)
}

#' @rdname f_count
#' @export
f_add_count <- function(data, ..., wt = NULL, sort = FALSE,
                        order = df_group_by_order_default(data),
                        name = NULL, .by = NULL, .cols = NULL){
  if (dots_length(...) == 0 && rlang::quo_is_null(rlang::enquo(.by)) && is.null(.cols)){
    return(
      add_count_simple(data, ..., wt = !!rlang::enquo(wt), sort = sort, order = order,
                       name = name, .by = {{ .by }}, .cols = .cols)
    )
  }
  group_vars <- group_vars(data)
  group_info <- tidy_group_info(data, ..., .by = {{ .by }},
                                .cols = .cols,
                                ungroup = TRUE,
                                rename = TRUE)
  out <- group_info[["data"]]
  all_vars <- group_info[["all_groups"]]
  if (rlang::quo_is_null(rlang::enquo(wt))){
    wt_var <- character()
  } else {
    ncol1 <- df_ncol(out)
    out_info <- mutate_summary_grouped(out, !!rlang::enquo(wt))
    out <- out_info[["data"]]
    ncol2 <- df_ncol(out)
    has_wt <- (ncol2 == ncol1)
    wt_var <- out_info[["cols"]]
    if (length(wt_var) > 0L){
      wtv <- out[[wt_var]]
      if (!has_wt){
        out <- df_rm_cols(out, wt_var)
      }
    }
  }
  use_only_grouped_df_groups <- !group_info[["groups_changed"]] && (
    length(all_vars) == 0L ||
      (order && length(group_vars) > 0L && length(group_vars) == length(all_vars))
  )
  if (use_only_grouped_df_groups){
    g <- df_to_GRP(data, return.order = FALSE, order = order)
  } else {
    g <- df_to_GRP(out, .cols = all_vars, return.order = FALSE, order = order)
  }
  if (is.null(name)){
    name <- unique_count_col(out)
  }
  if (length(wt_var) > 0L){
    if (length(all_vars) == 0L){
      g <- NULL
    }
    nobs <- collapse::fsum(as.double(wtv),
                           g = g,
                           na.rm = TRUE,
                           TRA = "replace_fill")
    # Replace NA with 0
    nobs[cheapr::which_na(nobs)] <- 0
    if (isTRUE(all_integerable(nobs))){
      nobs <- as.integer(nobs)
    }
  } else {
    nobs <- GRP_expanded_group_sizes(g)
  }
  out <- dplyr::dplyr_col_modify(out, cols = add_names(list(nobs),
                                                       name))
  if (sort){
    row_order <- order(-out[[name]])
    out <- df_row_slice(out, row_order)
  }
  reconstruct(data, out)
}
