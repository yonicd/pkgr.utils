#' @title pkgr commands
#' @description Commands that can be called in pkgr command line
#' @param pkgs character, names of packages passed in add/remove
#' @param \dots options that are passed into the command calls
#' @param flags character, names of flags that are passed into the command calls
#' @return character
#' @details
#'
#' add package/s to the configuration file and optionally install
#'
#' pkgr add [package name1] [package name2] ... [options] [flags]
#'
#' command specific flag
#'
#' \tabular{llll}{
#' \strong{Flag} \tab \strong{Description} \tab \strong{Default}\cr
#' install   \tab install package/s after adding \tab
#' }
#'
#' remove package/s from the configuration file
#'
#' pkgr remove [package name1] [package name2] ... [options] [flags]
#'
#' install a package
#'
#' pkgr install [options] [flags]
#'
#' see the plan for an install
#'
#' pkgr plan [options] [flags]
#'
#' global options:
#'
#' \tabular{llll}{
#' \strong{Option} \tab \strong{Class} \tab \strong{Description} \tab \strong{Default}\cr
#' config   \tab character \tab config file path                       \tab pkgr.yml\cr
#' loglevel \tab character \tab evel for logging                       \tab         \cr
#' thread   \tab integer   \tab number of threads to execute with      \tab
#'}
#'
#'
#' global flags:
#'
#' \tabular{llll}{
#' \strong{Flag} \tab \strong{Description} \tab \strong{Default}\cr
#' debug       \tab use debug mode                         \tab         \cr
#' preview     \tab preview action, but do not run command \tab         \cr
#' update      \tab update packages along with install     \tab
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

pkgr.add <- function(pkgs,...,flags = NULL){

  pkgr.boiler('add',pkgs = paste0(pkgs,collapse = ' '),...,flags = flags)

}

#' @rdname pkgr_cmds
#' @export
pkgr.remove <- function(pkgs,...,flags = NULL){

  pkgr.boiler('remove',pkgs = paste0(pkgs,collapse = ' '),...,flags = flags)

}

#' @rdname pkgr_cmds
#' @export
pkgr.install <- function(...,flags = NULL){

  pkgr.boiler('install',...,flags = flags)

}

#' @rdname pkgr_cmds
#' @export
pkgr.plan <- function(...,flags = NULL){

  pkgr.boiler('plan',...,flags = flags)

}

pkgr.boiler <- function(cmd, pkgs = NA_character_, ...,flags = NULL){

  ret <- sprintf('pkgr %s', cmd)

  if(!is.na(pkgs))
    ret <- sprintf('%s %s', ret, pkgs = pkgs)

  if(length(list(...))){
    ret <- sprintf('%s %s', ret, list2switch(list(...)))
  }

  if(!is.null(flags)){
    ret <- sprintf('%s %s', ret, list2flag(flags))
  }

  ret

}
