#' @title Convert a Description file to pkgr.yml
#' @description Reads in a DESCRIPTION file and populates a pkgr.yml template
#' with the non base packages listed as Depends, Imports, Suggests
#' @param desc_path character, path to DESCRIPTION file, Default: '.'
#' @param \dots arguments passed on to [pkgr.new][pkgr.utils::pkgr.new]
#' @return populated pkgr template
#' @details The path to the DESCRIPTION file can be a web URI, in this case it will
#' be downloaded and read.
#' @examples
#' \dontrun{
#'  desc2pkgr()
#' }
#' @rdname desc2pkgr
#' @export
#' @importFrom httr GET
#' @importFrom utils download.file
desc2pkgr <- function(desc_path ='.', ...){

  pkgr.new(desc2vec(check_path(desc_path))$package,...)

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

  this_yaml$Packages <- union(desc2vec(file = desc_file)$package,this_yaml$Packages)

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

  x[!x$package%in%base_packages(),]

}

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
