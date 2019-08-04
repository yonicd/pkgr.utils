list2switch <- function(x){
  paste0(sprintf('--%s=%s',gsub('[ ._]','-',names(x)),x),collapse = ' ')
}

list2flag <- function(x){
  paste0(sprintf('--%s',gsub('[ ._]','-',x)),collapse = ' ')
}

#' @title Compare packages listed in DESCRIPTION/pkgSetup.R and pkgr.yml
#' @description Compare packages listed in DESCRIPTION/pkgSetup.R and pkgr.yml
#' and return the setdiff.
#' @param src character, path to DESCRIPTION/pkgSetup.R , Default: 'DESCRIPTION'
#' @param pkgr character, path to pkgr.yml, Default: 'pkgr.yml'
#' @return character
#' @details The setdiff returns what packages are in DESCRIPTION/pkgSetup.R
#' that are missing from pkgr.yml Package field.
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
pkgr.diff <- function(src = 'DESCRIPTION',pkgr = 'pkgr.yml'){

  if(basename(src)=='DESCRIPTION'){
    src_pkgs <- desc2vec(file = src)$package
  }else{
    src_pkgs <- parse.pkgSetup(pkgsetup)
  }



  setdiff( src_pkgs, yaml::read_yaml(pkgr)$Package )

}

#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL
