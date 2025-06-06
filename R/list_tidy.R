#' Alternative to `rlang::list2`
#'
#' @description
#' Evaluates arguments dynamically like `rlang::list2` but objects
#' created in `list_tidy` have precedence over environment objects.
#'
#' @param ... Dynamic name-value pairs.
#' @param .keep_null `[logical(1)]` - Should `NULL` elements be kept?
#' Default is `TRUE`.
#' @param .named `[logical(1)]` - Should all list elements be named?
#' Default is `FALSE`.
#'
#' @export
list_tidy <- function(..., .keep_null = TRUE, .named = FALSE){
  quos <- rlang::quos(..., .ignore_empty = "all")
  if (.named){
    quos <- fix_quo_names(quos)
  }
  if (!.keep_null){
    quos <- cpp_quos_drop_null(quos)
  }
  cpp_list_tidy(quos)
}
