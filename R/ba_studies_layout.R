#' ba_studies_layout
#'
#' lists studies_layout available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param studyDbId string; default: 1
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/PlotLayoutDetails.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_layout.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_layout <- function(con = NULL, studyDbId = 1, rclass = "tibble") {
    ba_check(con, FALSE, "studies/id/layout")
    brp <- get_brapi(con)
    studies_layout_list <- paste0(brp, "studies/", studyDbId, "/layout/")
    try({
        res <- brapiGET(studies_layout_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- lyt2tbl(res, rclass)
        }
        class(out) <- c(class(out), "ba_studies_layout")
        return(out)
    })
}