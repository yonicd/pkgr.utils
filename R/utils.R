list2switch <- function(x){
  paste0(sprintf('--%s=%s',gsub('[ ._]','-',names(x)),x),collapse = ' ')
}


#' @title Compare packages listed in pkgSetup and pkgr.yml
#' @description Compare packages listed in pkgSetup and pkgr.yml and return the
#' setdiff.
#' @param pkgsetup character, path to pkgSetup.R , Default: 'pkgSetup.R'
#' @param pkgr character, path to pkgr.yml, Default: 'pkgr.yml'
#' @return character
#' @details The setdiff returns what packages are in pkgSetup that are missing
#' from pkgr.yml Package field.
#' @examples
#' \dontrun{
#'
#' pkgr.diff()
#'
#' pkgr.diff()%>%
#'   pkgr.add()
#'
#' }
#' @seealso
#'  \code{\link[yaml]{read_yaml}}
#' @rdname pkgr.diff
#' @export
#' @importFrom yaml read_yaml
pkgr.diff <- function(pkgsetup = 'pkgSetup.R',pkgr = 'pkgr.yml'){

  setdiff(parse.pkgSetup(pkgsetup),yaml::read_yaml(pkgr)$Package)

}

#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL
