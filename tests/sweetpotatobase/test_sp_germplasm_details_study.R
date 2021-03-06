context("sp germplasm_details_study")

con <- ba_db()$sweetpotatobase

test_that("Germplasm_details study results are present", {

  res <- ba_studies_germplasm_details(con = con, studyDbId = "1207")
  expect_that(nrow(res) >= 8, is_true())

})

test_that("Germplasm_details out formats work", {

  res <- ba_studies_germplasm_details(con = con, studyDbId = "1207", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_studies_germplasm_details(con = con, studyDbId = "1207", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_studies_germplasm_details(con = con, studyDbId = "1207", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

