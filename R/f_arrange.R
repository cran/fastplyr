#' A `collapse` version of `dplyr::arrange()`
#'
#' @description
#' This is a fast and near-identical alternative to `dplyr::arrange()`
#' using the `collapse` package.
#'
#' `desc()` is like `dplyr::desc()` but works faster when
#' called directly on vectors. \cr
#'
#' @param data A data frame.
#' @param ... Variables to arrange by.
#' @param .by (Optional). A selection of columns to group by for this operation.
#' Columns are specified using `tidyselect`.
#' @param .by_group If `TRUE` the sorting will be first done by the group
#' variables.
#' @param .cols (Optional) alternative to `...` that accepts
#' a named character vector or numeric vector.
#' If speed is an expensive resource, it is recommended to use this.
#' @param .descending `[logical(1)]` data frame be arranged in descending order? Default is
#' `FALSE`. In simple cases this can be easily achieved through `desc()` but
#' for a mixture of ascending and descending variables, it's easier to use
#' the `.descending` arg to reverse the order.
#'
#' @returns
#' A sorted `data.frame`.
#'
#' @export
f_arrange <- function(data, ..., .by = NULL, .by_group = FALSE,
                     .cols = NULL, .descending = FALSE){
  group_info <- tidy_dots_info(
    if (.by_group){
      data
    } else {
      cpp_ungroup(data)
    }, ..., .by = {{ .by }},
    .cols = .cols
  )
  data <- group_info[["data"]]
  dot_vars <- group_info[["new_cols"]]
  group_vars <- group_info[["all_groups"]]
  if (length(dot_vars) == 0L){
    return(data)
  }
  if (.by_group){
    order_vars <- c(group_vars, dot_vars)
  } else {
    order_vars <- dot_vars
  }
  out_order <- radixorderv2(
    cheapr::sset_col(
      group_info[["data"]], order_vars
    ),
    decreasing = .descending, na.last = TRUE, starts = FALSE,
    group.sizes = FALSE, sort = TRUE
  )
  sorted <- attr(out_order, "sorted")
  if (isTRUE(sorted)){
    data
  } else {
    cheapr::sset_df(data, out_order)
  }
}
