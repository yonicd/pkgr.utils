#' @title pkgr commands
#' @description Commands that can be called in pkgr command line
#' @param pkgs character, names of packages passed in add/remove
#' @param \dots options that are passed into the command calls
#' @param flags character, names of flags that are passed into the command calls
#' @return character
#' @details
#'
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> pkgr add [package name1] [package name2] ... [options] [flags] </span> </summary>
#' }
#' }
#'
#' add package/s to the configuration file and optionally install
#'
#' \tabular{ll}{
#' \strong{Flag} \tab \strong{Description}\cr
#' install   \tab install package/s after adding
#' }
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> pkgr remove [package name1] [package name2] ... [options] [flags] </span> </summary>
#' }
#' }
#'
#' remove package/s from the configuration file
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> pkgr install [options] [flags] </span> </summary>
#' }
#' }
#'
#' install a package
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> pkgr plan [options] [flags] </span> </summary>
#' }
#' }
#'
#' see the plan for an install
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> Global options </span> </summary>
#' }
#' }
#'
#' \tabular{llll}{
#' \strong{Option} \tab \strong{Class} \tab \strong{Description} \tab \strong{Default}\cr
#' config   \tab character \tab config file path                       \tab pkgr.yml\cr
#' loglevel \tab character \tab level for logging                      \tab         \cr
#' library \tab character \tab library to install packag               \tab         \cr
#' thread   \tab integer   \tab number of threads to execute with      \tab
#'}
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' \if{html}{
#' \out{
#' <br>
#' <details>
#' <summary> <span title='Click to Expand'> Global flags </span> </summary>
#' }
#' }
#'
#' \tabular{ll}{
#' \strong{Flag} \tab \strong{Description}\cr
#' debug       \tab use debug mode\cr
#' preview     \tab preview action, but do not run command \cr
#' update      \tab update packages along with install
#'}
#'
#' \if{html}{
#' \out{
#' </details>
#' }
#' }
#'
#' @examples
#'
#' pkgr.add(c('dplyr','ggplot2'))
#'
#' pkgr.add(c('dplyr','ggplot2'), config = 'pkgr.yml')
#'
#' # here::here is built into pkgr.utils
#' pkgr.add(c('dplyr','ggplot2'), config = pkgr.here())
#'
#' pkgr.add(c('dplyr','ggplot2'), config = 'pkgr.yml', flags = 'install')
#'
#' pkgr.remove(c('dplyr','ggplot2'))
#'
#' pkgr.install()
#'
#' pkgr.install(config = 'pkgr.yml', library = .libPaths()[1])
#'
#' pkgr.plan(config = 'pkgr.yml', library = .libPaths()[1])
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

#' @rdname pkgr_cmds
#' @export
pkgr.inspect <- function(...,flags = NULL){

  pkgr.boiler('inspect',...,flags = flags)

}

#' @rdname pkgr_cmds
#' @export
pkgr.run <- function(...,flags = NULL){

  pkgr.boiler('run',...,flags = flags)

}

#' @rdname pkgr_cmds
#' @export
pkgr.clean <- function(...,flags = NULL){

  pkgr.boiler('clean',...,flags = flags)

}

pkgr.boiler <- function(cmd, pkgs = NA_character_, ...,flags = NULL){

  ret <- sprintf('pkgr %s', cmd)

  if(!is.na(pkgs))
    ret <- sprintf('%s %s', ret, pkgs = pkgs)

  if(length(list(...))){

    params <- list(...)

    check_args(params,cmd,'parameters')

    ret <- sprintf('%s %s', ret, list2switch(params))
  }

  if(!is.null(flags)){

    check_args(flags,cmd,'flags')

    ret <- sprintf('%s %s', ret, list2flag(flags))

  }

  ret

}

flags_list <- list(
  global  = c('debug','preview','update'),
  add     = 'install',
  clean   = 'all',
  inspect = c('deps','installed-from','json','reverse','tree'),
  plan    = 'show-deps'
)

parameters_list <- list(
  global  = c('config','library','log-level','threads'),
  run     = 'pkg'
)

subcommands_list <- list(
  clean   = c('cache','pkgdbs')
)

check_args <- function(args,cmd,type='parameters'){

  if(type=='parameters'){
    args <- names(args)
  }

  args_list <- get(sprintf('%s_list',type))

  if(any(!args%in%unlist(args_list[c('global',cmd)]))){
    bad <- args[!args%in%unlist(args_list[c('global',cmd)])]
    bad <- paste0(bad,collapse = ', ')
    err_msg <- "Following %s not valid for 'pkgr %s': %s"
    hlp_msg <- "Use pkgr.help('%s') for more information"
    msg <- paste(err_msg,hlp_msg,sep = '\n\n')

    stop(sprintf(msg,type, cmd, bad, cmd))
  }

}

#' @title Help for pkgr commands
#' @description Get help documentation for pkgr commands
#' @param cmd character, command
#' @return output to console
#' @examples
#' \dontrun{
#' pkgr.help('add')
#' }
#' @rdname pkgr.help
#' @export

pkgr.help <- function(cmd){

  system(sprintf('pkgr %s --help',cmd))

}

#' @title pkgr version
#' @description Returns string of installed pkgr cli version
#' @return character
#' @examples
#' \dontrun{
#' pkgr.version()
#' }
#' @rdname pkgr.version
#' @export
pkgr.version <- function(){
  gsub('^(.*?)version ','',system('pkgr',intern = TRUE)[1])
}
