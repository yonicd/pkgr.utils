#' @title Location of pkgr.yml
#' @description Function that uses \code{\link[here]{here}} to build path to pkgr.yml
#' @param path here path to pkgr.yml, Default: 'pkgr.yml'
#' @return character
#' @examples
#' pkgr.here()
#' @seealso
#'  \code{\link[here]{here}}
#' @rdname pkgr.here
#' @export
#' @importFrom here here
pkgr.here <- function(path = 'pkgr.yml'){
  here::here(path)
}

list2switch <- function(x){

  x <- lapply(x,FUN=function(xx) ifelse(is_file(xx),normalizePath(xx),xx))

  paste0(sprintf('--%s=%s',gsub('[ ._]','-',names(x)),x),collapse = ' ')
}

list2flag <- function(x){
  paste0(sprintf('--%s',gsub('[ ._]','-',x)),collapse = ' ')
}

#' @title Compare packages listed in DESCRIPTION/pkgSetup.R and pkgr.yml
#' @description Compare packages listed in DESCRIPTION/pkgSetup.R and pkgr.yml
#' and return the setdiff.
#' @param src character, path to DESCRIPTION/pkgSetup.R , Default: 'DESCRIPTION'
#' @param pkgr character, path to pkgr.yml, Default: 'pkgr.yml'
#' @return character
#' @details The setdiff returns what packages are in DESCRIPTION/pkgSetup.R
#' that are missing from pkgr.yml Package field.
#' @examples
#' \dontrun{
#'
#' pkgr.diff()
#'
#' pkgr.diff()%>%
#'   pkgr.add()
#'
#' }
#' @seealso
#'  \code{\link[yaml]{read_yaml}}
#' @rdname pkgr.diff
#' @export
#' @importFrom yaml read_yaml
pkgr.diff <- function(src = 'DESCRIPTION',pkgr = 'pkgr.yml'){

  if(grepl('DESCRIPTION',basename(src))){
    src_pkgs <- desc2vec(file = src)$package
  }else{
    src_pkgs <- parse.pkgSetup(src)
  }



  setdiff( src_pkgs, yaml::read_yaml(pkgr)$Package )

}

#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL

is_file <- function (path) {
  !is.na(file.info(path)$size)
}


#' @title Open pkgr.yml in editor
#' @description Opens a pkgr.file in the RStudio Editor
#' @param path character, path to pkgr.yml, Default: pkgr.here()
#' @return NULL
#' @examples
#' \dontrun{
#' pkgr.open()
#' }
#' @rdname pkgr.open
#' @export
#' @importFrom rstudioapi isAvailable navigateToFile
pkgr.open <- function(path = pkgr.here()){

  if(rstudioapi::isAvailable()){

    rstudioapi::navigateToFile(path)

  }

}


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param pkgs PARAM_DESCRIPTION, Default: NULL
#' @param libpath PARAM_DESCRIPTION, Default: 'lib'
#' @param version PARAM_DESCRIPTION, Default: 1
#' @param threads PARAM_DESCRIPTION, Default: parallel::detectCores() - 1
#' @param repos PARAM_DESCRIPTION, Default: c(mrg_repos, cran_repos)
#' @param pkgr_tmpl PARAM_DESCRIPTION, Default: system.file("pkgr.tmpl", package = "pkgr.utils")
#' @param out PARAM_DESCRIPTION, Default: ''
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' pkgr.new('dplyr')
#' @rdname pkgr.new
#' @export
#' @importFrom parallel detectCores
#' @importFrom glue glue
pkgr.new <- function(pkgs = NULL,
                     libpath = .libPaths()[1],
                     version = 1,
                     threads = parallel::detectCores() - 1,
                     repos = c(mrg_repos,cran_repos),
                     pkgr_tmpl = system.file('pkgr.tmpl',package = 'pkgr.utils'),
                     out = ''){

  comment = '# Created using pkgr.utils template'

  pkgs <- as_yml(pkgs)
  repos <- as_yml(repos,NAMES = TRUE)

  tmpl <- paste0(readLines(pkgr_tmpl,warn = FALSE),collapse = '\n')

  cat(glue::glue(tmpl),file = out)
}

mrg_repos <- c(gh_external = 'https://metrumresearchgroup.github.io/rpkgs/gh_external',
               gh_dev      = 'https://metrumresearchgroup.github.io/rpkgs/gh_dev',
               mrg_val     = 'https://metrumresearchgroup.github.io/r_validated')

cran_repos <- c(CRAN = 'https://cran.rstudio.com')

as_yml <- function(x,NAMES = FALSE){
  if(NAMES){

    paste0(sprintf('\n- %s: %s',names(x),x),collapse = '')

  }else{

    paste0(sprintf('\n- %s',x),collapse = '')

  }

}
