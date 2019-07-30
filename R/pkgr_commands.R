#' @title pkgr commands
#' @description Commands that can be called in pkgr command line
#' @param pkgs character, names of packages passed in add/remove
#' @param \dots flags that are passed into the command calls
#' @return NULL
#' @details
#'
#' add package/s to the configuration file and optionally install
#'
#' pkgr add [package name1] [package name2] ... [flags]
#'
#' command specific flag
#'
#' \tabular{llll}{
#' \strong{Flag} \tab \strong{Class} \tab \strong{Description} \tab \strong{Default}\cr
#' install   \tab logical \tab install package/s after adding \tab
#' }
#'
#' remove package/s from the configuration file
#'
#' pkgr remove [package name1] [package name2] ... [flags]
#'
#' install a package
#'
#' pkgr install [flags]
#'
#' see the plan for an install
#'
#' pkgr plan [flags]
#'
#' global flags:
#'
#' \tabular{llll}{
#' \strong{Flag} \tab \strong{Class} \tab \strong{Description} \tab \strong{Default}\cr
#' config   \tab character \tab config file path                       \tab pkgr.yml\cr
#' debug    \tab logical   \tab use debug mode                         \tab         \cr
#' library  \tab character \tab path to install library                \tab         \cr
#' loglevel \tab character \tab evel for logging                       \tab         \cr
#' preview  \tab logical   \tab preview action, but do not run command \tab         \cr
#' thread   \tab integer   \tab number of threads to execute with      \tab         \cr
#' update   \tab logical   \tab update packages along with install     \tab
#'}
#' @examples
#'
#' pkgr.add(c('dplyr','ggplot2'))
#'
#' pkgr.add(c('dplyr','ggplot2'),config='pkgr.yml')
#'
#' pkgr.remove(c('dplyr','ggplot2'))
#'
#' pkgr.install()
#'
#' pkgr.install(config='pkgr.yml',library=.libPaths()[1])
#'
#' pkgr.plan(config='pkgr.yml',library=.libPaths()[1])
#'
#' @rdname pkgr_cmds
#' @export

pkgr.add <- function(pkgs,...){

  pkgr.boiler('add',pkgs = paste0(pkgs,collapse = ' '),...)

}

#' @rdname pkgr_cmds
#' @export
pkgr.remove <- function(pkgs,...){

  pkgr.boiler('remove',pkgs = paste0(pkgs,collapse = ' '),...)

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

pkgr.boiler <- function(cmd, pkgs = NA_character_, ...){

  ret <- sprintf('pkgr %s', cmd)

  if(!is.na(pkgs))
    ret <- sprintf('%s %s', ret, pkgs = pkgs)

  if(length(list(...))){
    ret <- sprintf('%s %s', ret, list2switch(list(...)))
  }

  ret

}
