#' @title Extract DESCRIPTION file dependencies
#' @description Extract from a DESCRIPTION file a vector of the listed package
#'   dependencies.
#' @param file PARAM_DESCRIPTION, Default: '.'
#' @param type character, type of file to parse, Default: c('DESCRIPTION','pkgSetup')
#' @param \dots arguments to pass to desc_deps or pkgSetup_deps
#' @return character
#' @details For the vector of base and recommended packages use
#'   [base_packages][pkgr.utils::base_packages]
#' @rdname get_deps
#' @export
#' @export
get_deps <- function(file = '.',type = c('DESCRIPTION','pkgSetup'),...){

  switch(match.arg(type,c('DESCRIPTION','pkgSetup')),
         'DESCRIPTION' = {
           desc_deps(file,...)
         },
         'pkgSetup' = {
           pkgSetup_deps(file,...)
         })


}

#' @importFrom utils getParseData
pkgSetup_deps <- function(file = 'pkgSetup.R', excl_set = base_packages()){

  x <- utils::getParseData(parse(file,keep.source = TRUE),includeText = TRUE)

  y <- grep('^pkgs',x$text[x$parent==0],value = TRUE)[1]

  ret <- sort(eval(parse(text = gsub('^pkgs(.*?)<- |\\n','',y))))

  if(!is.null(excl_set))
    ret <- setdiff(ret,excl_set)

  ret

}

#' @importFrom desc desc_get_deps
desc_deps <- function(file='.', excl_set = base_packages()){

  x <- desc::desc_get_deps(file = check_path(file))

  ret <- x$package

  if(!is.null(excl_set))
    ret <- setdiff(ret,excl_set)

  ret

}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[utils]{installed.packages}}
#' @rdname base_packages
#' @export
#' @importFrom utils installed.packages
base_packages <- function(){
  i <- utils::installed.packages()
  ret <- i[ i[,"Priority"] %in% c("base","recommended"), c("Package","Priority")]

  c('R',rownames(ret))
}

check_path <- function(x){

  if(!inherits(try(httr::GET(x),silent = TRUE),'try-error')){
    desc_uri <- x
    x <- tempfile()
    utils::download.file(desc_uri,destfile = x,quiet = TRUE)
  }

  x
}
