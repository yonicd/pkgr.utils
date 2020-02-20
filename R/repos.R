#' @title Stored Repositories
#' @description Returns names of stored CRAN and CRANlike repositories
#' @param name character, Names of repositories to return,
#'    Default: c("MPN", "CRAN")
#' @param snapshot character, names vector corresponding to the repository of the dates to use for snapshots,
#' Default: c(MPN = mpn_release(latest = FALSE), CRAN = Sys.Date() - 1)
#' @details
#'
#' Snapshot value is coerced into a Date class internally.
#'
#' The earliest date for 'MPN' is '2019-09-22', if snapshot is earlier than this and
#' the user includes 'MPN' in name then snapshot will be replaced with '2019-09-22'.
#'
#' @return character
#' @examples
#'
#' get_repos()
#'
#' get_repos(name = 'MPN')
#'
#' get_repos(name = 'CRAN', snapshot = c(CRAN = Sys.Date() - 1))
#'
#'
#' @rdname get_repos
#' @export
#' @importFrom glue glue
get_repos <- function(name = c('MPN', 'CRAN'), snapshot = c(MPN = mpn_release(latest = TRUE), CRAN = Sys.Date() - 1)){

  snapshot <- as.Date(snapshot)

  repos <- vector('character',length(name))
  names(repos) <- name

  for(nm in names(repos)){

    if(nm=='MPN'){

      if(snapshot[[nm]] < as.Date('2019-09-22')){
          warning('MPN starts at "2019-09-22", resetting snapshot to that date')
          snapshot[[nm]] <- as.Date('2019-09-22')
        }

      repos[[nm]] <- glue::glue('https://mpn.metworx.com/snapshots/stable/{snapshot[["MPN"]]}')
    }

    if(nm=='CRAN'){
      repos[[nm]] <- glue::glue('https://cran.microsoft.com/snapshot/{snapshot[["CRAN"]]}')
    }

  }

  repos

}

#' @title Query MPN releases
#' @description Query GHE for list of MPN releases
#' @param latest logical, return only the lasest release, Default: FALSE
#' @param pat character, GHE Personal Access Token, Default: Sys.getenv("GHE_PAT")
#' @return if latest is TRUE then a character, else a list
#' @rdname mpn_release
#' @export
#' @importFrom glue glue
#' @importFrom httr GET add_headers set_config config content
#' @importFrom jsonlite fromJSON
#' @importFrom base64enc base64decode
mpn_release <- function(latest = FALSE, pat = Sys.getenv('GHE_PAT')){
  if(!nzchar(pat))
    stop('Missing GHE Personal Access Token needed for the query')

  uri <- glue::glue("https://ghe.metrumrg.com/api/v3/repos/r-snapshots/snapshots/contents/stable/versions/all")
  res <- httr::GET(uri,
                   httr::add_headers(Authorization = glue::glue("token {pat}")),
                   httr::set_config(httr::config(ssl_verifypeer = 0L)))
  ret <- jsonlite::fromJSON(rawToChar(base64enc::base64decode(httr::content(res)$content)))
  if(latest){
    ret <- as.Date(ret$latest)
  }
  ret
}
