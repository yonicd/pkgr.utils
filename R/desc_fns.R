#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param desc_path PARAM_DESCRIPTION, Default: '.'
#' @param src_path PARAM_DESCRIPTION, Default: 'pkg'
#' @param lib_path PARAM_DESCRIPTION, Default: .libPaths()[1]
#' @param pkgr_tmpl PARAM_DESCRIPTION, Default: system.file("DESC.tmpl", package = "pkgr.utils")
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
#'  \code{\link[httr]{GET}}
#'  \code{\link[utils]{download.file}}
#'  \code{\link[yaml]{as.yaml}}
#'  \code{\link[whisker]{whisker.render}}
#'  \code{\link[desc]{desc_get_field}}
#' @rdname desc2pkgr
#' @export
#' @importFrom httr GET
#' @importFrom utils download.file
#' @importFrom yaml as.yaml
#' @importFrom whisker whisker.render
#' @importFrom desc desc_get_field
desc2pkgr <- function(desc_path ='.', src_path = 'pkg', lib_path = .libPaths()[1], pkgr_tmpl = system.file('DESC.tmpl',package = 'pkgr.utils'), out = ''){

  if(!inherits(try(httr::GET(desc_path),silent = TRUE),'try-error')){
    desc_uri <- desc_path
    desc_path <- tempfile()
    utils::download.file(desc_uri,destfile = desc_path,quiet = TRUE)
  }

  pkgs <- yaml::as.yaml(list(Packages=desc2vec(desc_path)$package))

  w <- whisker::whisker.render(
    template = readLines(pkgr_tmpl),
    data = list(
      PKG_NAME = desc::desc_get_field('Package',file = desc_path),
      PKGS    = pkgs,
      PKGPATH = src_path,
      LIBPATH = lib_path)
    )

  cat(w,file = out,sep='\n')

}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param desc_file PARAM_DESCRIPTION, Default: '.'
#' @param pkgr_yml PARAM_DESCRIPTION
#' @param test PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[yaml]{read_yaml}},\code{\link[yaml]{as.yaml}},\code{\link[yaml]{write_yaml}}
#' @rdname update_pkgr_desc
#' @export
#' @importFrom yaml read_yaml as.yaml write_yaml
update_pkgr_desc <- function(desc_file = '.', pkgr_yml, test = TRUE){

  this_yaml <- yaml::read_yaml(pkgr_yml)

  this_yaml$Packages <- union(desc2vec(file = desc_file),this_yaml$Packages)

  if(test){

    cat(yaml::as.yaml(this_yaml))

  }else{

    yaml::write_yaml(this_yaml,file = pkgr_yml)

  }


}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param file PARAM_DESCRIPTION, Default: '.'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[desc]{desc_get_deps}}
#' @rdname desc2vec
#' @export
#' @importFrom desc desc_get_deps
desc2vec <- function(file='.'){

  x <- desc::desc_get_deps(file = file)

  x[!x$package%in%c('R','tools','stats','parallel','utils','methods','graphics'),]

}
