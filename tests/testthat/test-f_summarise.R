test_that("summarise", {

  options(fastplyr.inform = FALSE)

  set.seed(82134)
  airquality <- f_slice_sample(airquality, 2e04, TRUE)
  airquality$Month <- sample.int(2e04)

  # Cant have multiple rows per group
  expect_error(
    suppressWarnings(
      airquality |>
        f_summarise(Wind)
    )
  )

  target <- airquality |>
    dplyr::rowwise() |>
    dplyr::summarise(Wind)

  expect_equal(
    airquality |>
      f_rowwise() |>
      f_summarise(Wind) |>
      dplyr::select(Wind),
    target
  )

  target <- airquality |>
    dplyr::summarise(mean_wind = mean(Wind))

  expect_equal(
    airquality |>
      f_summarise(mean_wind = mean(Wind)),
    target
  )

  target <- airquality |>
    dplyr::summarise(mean_wind = mean(Wind),
                     .by = Month)

  expect_equal(
    airquality |>
      f_summarise(mean_wind = mean(Wind),
                  .by = Month, .order = FALSE),
    target
  )

  target <- airquality |>
    dplyr::group_by(Month) |>
    dplyr::summarise(mean_wind = mean(Wind))

  expect_equal(
    airquality |>
      dplyr::group_by(Month) |>
      f_summarise(mean_wind = mean(Wind)),
    target
  )
  expect_equal(
    airquality |>
      dplyr::group_by(Month) |>
      f_summarise(mean_wind = mean(Wind)),
    target
  )

  target <- airquality |>
    dplyr::summarise(n_nas = cheapr::na_count(Wind), .by = Month)

  expect_equal(
    airquality |>
      f_summarise(n_nas = cheapr::na_count(Wind), .by = Month, .order = FALSE),
    target
  )

  target <- airquality |>
    dplyr::group_by(Month) |>
    dplyr::summarise(n_nas = cheapr::na_count(Wind))

  expect_equal(
    airquality |>
      dplyr::group_by(Month) |>
      f_summarise(n_nas = cheapr::na_count(Wind)),
    target
  )

  target <- airquality |>
    dplyr::group_by(Month) |>
    dplyr::summarise(dplyr::across(Wind, cheapr::na_count))

  expect_equal(
    airquality |>
      dplyr::group_by(Month) |>
      f_summarise(dplyr::across(Wind, cheapr::na_count)),
    target
  )

  target <- airquality |>
    dplyr::summarise(
      dplyr::across(
        dplyr::everything(),
        list(mean = \(x) mean(x, na.rm = TRUE),
             median = \(x) median(x, na.rm = TRUE),
             min = \(x) min(x, na.rm = TRUE),
             max = \(x) max(x, na.rm = TRUE)),
        .names = "col_{.col}_fun_{.fn}"
      ), N = dplyr::n()
    )
  expect_equal(
    airquality |>
      f_summarise(
        dplyr::across(dplyr::everything(),
                      list(mean = \(x) mean(x, na.rm = TRUE),
                           median = \(x) median(x, na.rm = TRUE),
                           min = \(x) min(x, na.rm = TRUE),
                           max = \(x) max(x, na.rm = TRUE)),
                      .names = "col_{.col}_fun_{.fn}"),
        N = dplyr::n()
      ),
    target
  )
  expect_equal(
    airquality |>
      f_summarise(
        dplyr::across(dplyr::everything(), list(mean = \(x) mean(x, na.rm = TRUE),
                                                median = \(x) median(x, na.rm = TRUE),
                                                min = \(x) min(x, na.rm = TRUE),
                                                max = \(x) max(x, na.rm = TRUE)),
                      .names = "col_{.col}_fun_{.fn}"),
        N = dplyr::n()
      ),
    target
  )

  target <- airquality |>
    dplyr::summarise(
      dplyr::across(
        dplyr::everything(),
        list(mean = \(x) mean(x, na.rm = TRUE),
             median = \(x) median(x, na.rm = TRUE),
             min = \(x) min(x, na.rm = TRUE),
             max = \(x) max(x, na.rm = TRUE))
      ), N = dplyr::n()
    )
  expect_equal(
    airquality |>
      f_summarise(
        dplyr::across(dplyr::everything(),
                      list(mean = \(x) mean(x, na.rm = TRUE),
                           median = \(x) median(x, na.rm = TRUE),
                           min = \(x) min(x, na.rm = TRUE),
                           max = \(x) max(x, na.rm = TRUE))),
        N = dplyr::n()),
    target
  )

  # 2 variables and a mix of optimised/non-optimised calls

  target <- airquality |>
    dplyr::summarise(
      dplyr::across(
        dplyr::all_of(c("Wind", "Temp")),
        list(mean = \(x) mean(x, na.rm = TRUE),
             first = \(x) x[1],
             min = \(x) min(x, na.rm = TRUE),
             last_obs = \(x) x[length(x)],
             max = \(x) max(x, na.rm = TRUE))
      ), N = dplyr::n()
    )

  expect_equal(
    airquality |>
      f_summarise(
        dplyr::across(dplyr::all_of(c("Wind", "Temp")),
                      list(mean = mean,
                           first = \(x) x[1],
                           min = min,
                           last_obs = \(x) x[length(x)],
                           max = max)),
        N = dplyr::n()
      ),
    target
  )

  # 2 variables and a mix of optimised/non-optimised calls, and groups

  target <- airquality |>
    dplyr::summarise(
      dplyr::across(
        dplyr::all_of(c("Wind", "Temp")),
        list(mean = \(x) mean(x, na.rm = TRUE),
             first = \(x) x[1],
             min = \(x) min(x, na.rm = TRUE),
             last_obs = \(x) x[length(x)],
             max = \(x) max(x, na.rm = TRUE))
      ), N = dplyr::n(),
      .by = Month
    )

  expect_equal(
    airquality |>
      f_summarise(
        dplyr::across(dplyr::all_of(c("Wind", "Temp")),
                      list(mean = mean,
                           first = \(x) x[1],
                           min = min,
                           last_obs = \(x) x[length(x)],
                           max = max)),
        N = dplyr::n(),
        .by = Month,
        .order = FALSE
      ),
    target
  )
})
