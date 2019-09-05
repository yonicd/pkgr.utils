#' @title Stored Repositories
#' @description Returns names of stored CRAN and CRANlike repositories
#' @param name character, Names of repositories to return,
#'    Default: c("gh_external", "gh_dev", "mrg_val", "rs_cran")
#' @return character
#' @examples
#' get_repos()
#' @rdname get_repos
#' @export
get_repos <- function(name = c('gh_external','gh_dev','mrg_val','rs_cran')){

  repos <- c(gh_external = 'https://metrumresearchgroup.github.io/rpkgs/gh_external',
    gh_dev      = 'https://metrumresearchgroup.github.io/rpkgs/gh_dev',
    mrg_val     = 'https://metrumresearchgroup.github.io/r_validated',
    rs_cran = 'https://cran.rstudio.com'
  )

  repos[match.arg(name,names(repos),several.ok = TRUE)]

}
