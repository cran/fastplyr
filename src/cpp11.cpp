// Generated by cpp11: do not edit by hand
// clang-format off


#include "cpp11/declarations.hpp"
#include <R_ext/Visibility.h>

// fastplyr.cpp
SEXP cpp_r_address(SEXP x);
extern "C" SEXP _fastplyr_cpp_r_address(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_r_address(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_frame_addresses_equal(SEXP x, SEXP y);
extern "C" SEXP _fastplyr_cpp_frame_addresses_equal(SEXP x, SEXP y) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_frame_addresses_equal(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<SEXP>>(y)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_frame_dims(SEXP x, bool check_rows_equal, bool check_cols_equal);
extern "C" SEXP _fastplyr_cpp_frame_dims(SEXP x, SEXP check_rows_equal, SEXP check_cols_equal) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_frame_dims(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<bool>>(check_rows_equal), cpp11::as_cpp<cpp11::decay_t<bool>>(check_cols_equal)));
  END_CPP11
}
// fastplyr.cpp
bool cpp_is_exotic(SEXP x);
extern "C" SEXP _fastplyr_cpp_is_exotic(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_is_exotic(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
bool cpp_any_frames(SEXP x);
extern "C" SEXP _fastplyr_cpp_any_frames(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_any_frames(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
bool cpp_any_frames_exotic(SEXP x);
extern "C" SEXP _fastplyr_cpp_any_frames_exotic(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_any_frames_exotic(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_list_subset(SEXP x, SEXP ptype, SEXP i, SEXP default_value);
extern "C" SEXP _fastplyr_cpp_list_subset(SEXP x, SEXP ptype, SEXP i, SEXP default_value) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_list_subset(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<SEXP>>(ptype), cpp11::as_cpp<cpp11::decay_t<SEXP>>(i), cpp11::as_cpp<cpp11::decay_t<SEXP>>(default_value)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_sorted_group_starts(SEXP group_sizes, int init_loc);
extern "C" SEXP _fastplyr_cpp_sorted_group_starts(SEXP group_sizes, SEXP init_loc) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_sorted_group_starts(cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_sizes), cpp11::as_cpp<cpp11::decay_t<int>>(init_loc)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_group_locs(SEXP order, SEXP group_sizes);
extern "C" SEXP _fastplyr_cpp_group_locs(SEXP order, SEXP group_sizes) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_group_locs(cpp11::as_cpp<cpp11::decay_t<SEXP>>(order), cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_sizes)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_row_id(SEXP order, SEXP group_sizes, bool ascending);
extern "C" SEXP _fastplyr_cpp_row_id(SEXP order, SEXP group_sizes, SEXP ascending) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_row_id(cpp11::as_cpp<cpp11::decay_t<SEXP>>(order), cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_sizes), cpp11::as_cpp<cpp11::decay_t<bool>>(ascending)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_which_all(SEXP x);
extern "C" SEXP _fastplyr_cpp_which_all(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_which_all(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_df_group_indices(SEXP rows, int size);
extern "C" SEXP _fastplyr_cpp_df_group_indices(SEXP rows, SEXP size) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_df_group_indices(cpp11::as_cpp<cpp11::decay_t<SEXP>>(rows), cpp11::as_cpp<cpp11::decay_t<int>>(size)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_slice_locs(SEXP group_locs, SEXP locs);
extern "C" SEXP _fastplyr_cpp_slice_locs(SEXP group_locs, SEXP locs) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_slice_locs(cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_locs), cpp11::as_cpp<cpp11::decay_t<SEXP>>(locs)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_consecutive_id(SEXP x);
extern "C" SEXP _fastplyr_cpp_consecutive_id(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_consecutive_id(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_grouped_run_id(SEXP x, SEXP order, SEXP group_sizes);
extern "C" SEXP _fastplyr_cpp_grouped_run_id(SEXP x, SEXP order, SEXP group_sizes) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_grouped_run_id(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<SEXP>>(order), cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_sizes)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_set_list_element(SEXP x, R_xlen_t i, SEXP value);
extern "C" SEXP _fastplyr_cpp_set_list_element(SEXP x, SEXP i, SEXP value) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_set_list_element(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<R_xlen_t>>(i), cpp11::as_cpp<cpp11::decay_t<SEXP>>(value)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_fill_grouped(SEXP x, SEXP order, SEXP group_sizes, double fill_limit);
extern "C" SEXP _fastplyr_cpp_fill_grouped(SEXP x, SEXP order, SEXP group_sizes, SEXP fill_limit) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_fill_grouped(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x), cpp11::as_cpp<cpp11::decay_t<SEXP>>(order), cpp11::as_cpp<cpp11::decay_t<SEXP>>(group_sizes), cpp11::as_cpp<cpp11::decay_t<double>>(fill_limit)));
  END_CPP11
}
// fastplyr.cpp
SEXP cpp_unlist_group_locs(SEXP x);
extern "C" SEXP _fastplyr_cpp_unlist_group_locs(SEXP x) {
  BEGIN_CPP11
    return cpp11::as_sexp(cpp_unlist_group_locs(cpp11::as_cpp<cpp11::decay_t<SEXP>>(x)));
  END_CPP11
}

extern "C" {
static const R_CallMethodDef CallEntries[] = {
    {"_fastplyr_cpp_any_frames",            (DL_FUNC) &_fastplyr_cpp_any_frames,            1},
    {"_fastplyr_cpp_any_frames_exotic",     (DL_FUNC) &_fastplyr_cpp_any_frames_exotic,     1},
    {"_fastplyr_cpp_consecutive_id",        (DL_FUNC) &_fastplyr_cpp_consecutive_id,        1},
    {"_fastplyr_cpp_df_group_indices",      (DL_FUNC) &_fastplyr_cpp_df_group_indices,      2},
    {"_fastplyr_cpp_fill_grouped",          (DL_FUNC) &_fastplyr_cpp_fill_grouped,          4},
    {"_fastplyr_cpp_frame_addresses_equal", (DL_FUNC) &_fastplyr_cpp_frame_addresses_equal, 2},
    {"_fastplyr_cpp_frame_dims",            (DL_FUNC) &_fastplyr_cpp_frame_dims,            3},
    {"_fastplyr_cpp_group_locs",            (DL_FUNC) &_fastplyr_cpp_group_locs,            2},
    {"_fastplyr_cpp_grouped_run_id",        (DL_FUNC) &_fastplyr_cpp_grouped_run_id,        3},
    {"_fastplyr_cpp_is_exotic",             (DL_FUNC) &_fastplyr_cpp_is_exotic,             1},
    {"_fastplyr_cpp_list_subset",           (DL_FUNC) &_fastplyr_cpp_list_subset,           4},
    {"_fastplyr_cpp_r_address",             (DL_FUNC) &_fastplyr_cpp_r_address,             1},
    {"_fastplyr_cpp_row_id",                (DL_FUNC) &_fastplyr_cpp_row_id,                3},
    {"_fastplyr_cpp_set_list_element",      (DL_FUNC) &_fastplyr_cpp_set_list_element,      3},
    {"_fastplyr_cpp_slice_locs",            (DL_FUNC) &_fastplyr_cpp_slice_locs,            2},
    {"_fastplyr_cpp_sorted_group_starts",   (DL_FUNC) &_fastplyr_cpp_sorted_group_starts,   2},
    {"_fastplyr_cpp_unlist_group_locs",     (DL_FUNC) &_fastplyr_cpp_unlist_group_locs,     1},
    {"_fastplyr_cpp_which_all",             (DL_FUNC) &_fastplyr_cpp_which_all,             1},
    {NULL, NULL, 0}
};
}

extern "C" attribute_visible void R_init_fastplyr(DllInfo* dll){
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}
