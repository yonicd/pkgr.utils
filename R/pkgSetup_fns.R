#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param pkgsetup PARAM_DESCRIPTION, Default: 'pkgSetup.R'
#' @param repos PARAM_DESCRIPTION, Default: c(pkgsetup = 'pkg',mrg_repos,cran_repos)
#' @param libpath PARAM_DESCRIPTION, Default: 'lib'
#' @param \dots arguments to pass to [pkgr.new][pkgr.utils::pkgr.new]
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' pkgSetup <- system.file('pkgSetup.R',package = 'pkgr.utils')
#' pkgSetup2pkgr(pkgSetup)
#' @seealso
#'  \code{\link[yaml]{as.yaml}}
#'  \code{\link[whisker]{whisker.render}}
#' @rdname pkgSetup2pkgr
#' @export
pkgSetup2pkgr <- function(pkgsetup = 'pkgSetup.R', repos = c(pkgsetup = 'pkg',mrg_repos,cran_repos), libpath = 'lib', ...){

  pkgr.new(parse.pkgSetup(pkgsetup),repos = repos, libpath = libpath)

}

#' @importFrom utils getParseData
parse.pkgSetup <- function(pkgsetup = 'pkgSetup.R'){

  x <- utils::getParseData(parse(pkgsetup,keep.source = TRUE),includeText = TRUE)

  y <- grep('^pkgs',x$text[x$parent==0],value = TRUE)[1]

  sort(eval(parse(text = gsub('^pkgs(.*?)<- |\\n','',y))))
}
