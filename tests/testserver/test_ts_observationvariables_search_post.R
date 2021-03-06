context("ts observationvariables_search_post")


con <- ba_db()$testserver

test_that("observationvariables_search results are present", {

  res <- ba_observationvariables_search_post(con = con, pageSize = 3)
  expect_that(nrow(res) >= 3, is_true())
  expect_that(ncol(res) >= 36, is_true())

})

test_that("observationvariables_search rclass output works", {
  res <- ba_observationvariables_search_post(con = con, pageSize = 3, rclass = "json")
  expect_that("json" %in% class(res), is_true())
})

test_that("observationvariables_search rclass output works", {
  res <- ba_observationvariables_search_post(con = con, pageSize = 3, rclass = "list")
  expect_that("list" %in% class(res), is_true())
})

test_that("observationvariables_search rclass output works", {
  res <- ba_observationvariables_search_post(con = con, pageSize = 3, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())
})
