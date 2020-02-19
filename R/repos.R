#' @title Stored Repositories
#' @description Returns names of stored CRAN and CRANlike repositories
#' @param name character, Names of repositories to return,
#'    Default: c("MPN", "CRAN")
#' @param snapshot Date, date of the snapshot of the repository, Default: Sys.Date() - 1
#' @details
#'
#' Snapshot value is coerced into a Date class internally.
#'
#' The earliest date for 'MPN' is '2019-09-22', if snapshot is earlier than this and
#' the user includes 'MPN' in name then snapshot will be replaced with '2019-09-22'.
#'
#' @return character
#' @examples
#' get_repos()
#'
#' get_repos(name = 'MPN')
#'
#' get_repos(name = 'MPN', snapshot = Sys.Date() - 1)
#'
#' @rdname get_repos
#' @export
#' @importFrom glue glue
get_repos <- function(name = c('MPN','CRAN'), snapshot = Sys.Date() - 1){

  min_date <- as.Date('2019-09-22')

  snapshot <- as.Date(snapshot)

  if('MPN' %in% name & snapshot < min_date){
    warning('MPN starts at "2019-09-22", resetting snapshot to that date')
    snapshot <- min_date
  }

  repos <-   c(
    MPN =  glue::glue('https://mpn.metworx.com/snapshots/stable/{snapshot}'),
    CRAN = glue::glue('https://cran.microsoft.com/snapshot/{snapshot}')
    )

  repos[match.arg(name,names(repos),several.ok = TRUE)]

}
