list2switch <- function(x){
  paste0(sprintf('--%s=%s',gsub('[ ._]','-',names(x)),x),collapse = ' ')
}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param pkgsetup PARAM_DESCRIPTION, Default: 'pkgSetup.R'
#' @param pkgr PARAM_DESCRIPTION, Default: 'pkgr.yml'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[yaml]{read_yaml}}
#' @rdname pkgr.diff
#' @export
#' @importFrom yaml read_yaml
pkgr.diff <- function(pkgsetup = 'pkgSetup.R',pkgr = 'pkgr.yml'){

  setdiff(parse.pkgSetup(pkgsetup),yaml::read_yaml(pkgr)$Package)

}

