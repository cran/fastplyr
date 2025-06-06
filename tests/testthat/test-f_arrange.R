test_that("f_arrange", {

  options(fastplyr.inform = FALSE)
  suppressWarnings(add_row_id(new_tbl()))
  suppressWarnings(add_group_id(new_tbl()))

  expect_equal(iris, f_arrange(iris))

  flights2 <- add_row_id(cheapr::with_local_seed(f_slice_sample(nycflights13::flights), .seed = 9192919))
  iris2 <- add_row_id(cheapr::with_local_seed(f_slice_sample(iris), .seed = 098124))
  base1 <- iris2 |>
    dplyr::arrange(dplyr::desc(Species), Sepal.Length)
  base2 <- flights2 |>
    dplyr::group_by(origin, dest) |>
    dplyr::arrange(dest, dplyr::desc(tailnum), origin)
  base3 <- flights2 |>
    dplyr::group_by(origin, dest) |>
    dplyr::arrange(dest, dplyr::desc(tailnum), origin,
                   .by_group = TRUE)
  res1 <- iris2 |>
    f_arrange(desc(Species), Sepal.Length)
  res2 <- flights2 |>
    f_group_by(origin, dest) |>
    f_arrange(dest, desc(tailnum), origin)
  res3 <- flights2 |>
    f_group_by(origin, dest) |>
    f_arrange(dest, desc(tailnum), origin,
             .by_group = TRUE)

  expect_equal(base1$row_id, res1$row_id)
  expect_equal(base2$row_id, res2$row_id)
  expect_equal(base3$row_id, res3$row_id)
})
