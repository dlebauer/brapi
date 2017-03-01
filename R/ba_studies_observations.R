#' ba_studies_observations
#'
#' lists studies_observations available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param studyDbId character; default: 1
#' @param observationVariableDbId character; default: 1:3
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/GetObservationUnitsByObservationVariableIds.md}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_observations.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_observations <- function(con = NULL, studyDbId = 1, observationVariableDbId = 1:3,
                                 page = 0, pageSize = 1000, rclass = "tibble") {
    ba_check(con, FALSE, "studies/id/observations")
    brp <- get_brapi(con)
    studies_observations_list <- paste0(brp, "studies/", studyDbId, "/observations/?")

    observationVariableDbId <- paste0("observationVariableDbIds=", paste(observationVariableDbId, collapse = ","),
        "&")
    page <- ifelse(is.numeric(page), paste0("page=", page), "")
    pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

    studies_observations_list <- paste0(studies_observations_list, observationVariableDbId, pageSize, page)

    try({
        res <- brapiGET(studies_observations_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list", "tibble", "data.frame")) {
            out <- dat2tbl(res, rclass)
        }
        class(out) <- c(class(out), "ba_studies_observations")
        return(out)
    })
}