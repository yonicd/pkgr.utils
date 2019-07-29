#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param pkgsetup PARAM_DESCRIPTION, Default: 'pkgSetup.R'
#' @param src_path PARAM_DESCRIPTION, Default: 'pkg'
#' @param lib_path PARAM_DESCRIPTION, Default: 'lib'
#' @param pkgr_tmpl PARAM_DESCRIPTION, Default: system.file("PKGSETUP.tmpl", package = "pkgr.utils")
#' @param out PARAM_DESCRIPTION, Default: ''
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[yaml]{as.yaml}}
#'  \code{\link[whisker]{whisker.render}}
#' @rdname pkgSetup2pkgr
#' @export
#' @importFrom yaml as.yaml
#' @importFrom whisker whisker.render
pkgSetup2pkgr <- function(pkgsetup = 'pkgSetup.R', src_path = 'pkg', lib_path = 'lib', pkgr_tmpl = system.file('PKGSETUP.tmpl',package = 'pkgr.utils'), out = ''){

  pkgs <- pkgs <- yaml::as.yaml(list(Packages = parse.pkgSetup(pkgsetup)))

  if(is.null(out))
    out <- ''

  w <- whisker::whisker.render(
    template = readLines(pkgr_tmpl),
    data = list(
      PKGS    = pkgs,
      PKGPATH = src_path,
      LIBPATH = lib_path)
  )

  cat(w,file = out,sep='\n')

}

#' @importFrom utils getParseData
parse.pkgSetup <- function(pkgsetup = 'pkgSetup.R'){

  x <- utils::getParseData(parse(pkgsetup),includeText = TRUE)

  y <- grep('^pkgs',x$text[x$parent==0],value = TRUE)[1]

  sort(eval(parse(text = gsub('^pkgs(.*?)<- |\\n','',y))))
}
