pkgr.boiler <- function(cmd, pkgs = NA_character_, ...){

  ret <- sprintf('pkgr %s', cmd)

  if(!is.na(pkgs))
    ret <- sprintf('%s %s', ret, pkgs = pkgs)

  if(length(list(...))){
    ret <- sprintf('%s %s', ret, list2switch(list(...)))
  }

  ret
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param pkgs PARAM_DESCRIPTION
#' @param \dots PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname pkgr_cmds
#' @export

pkgr.add <- function(pkgs,...){

  pkgr.boiler('add',pkgs = paste0(pkgs,collapse = ' '),...)

}

#' @rdname pkgr_cmds
#' @export
pkgr.install <- function(...){

  pkgr.boiler('install',...)

}

#' @rdname pkgr_cmds
#' @export
pkgr.plan <- function(...){

  pkgr.boiler('plan',...)

}
