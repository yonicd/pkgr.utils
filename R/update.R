#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param file PARAM_DESCRIPTION, Default: '.'
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
#' @rdname update_pkgr
#' @export
#' @importFrom yaml read_yaml as.yaml write_yaml
update_pkgr <- function(file = '.', pkgr_yml, test = TRUE,...){

  this_yaml <- yaml::read_yaml(pkgr_yml)

  this_yaml$Packages <- union(get_deps(file = file,...),this_yaml$Packages)

  if(test){

    cat(yaml::as.yaml(this_yaml))

  }else{

    yaml::write_yaml(this_yaml,file = pkgr_yml)

  }


}


