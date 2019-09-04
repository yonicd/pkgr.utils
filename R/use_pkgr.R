#' @title Installing pkgr
#' @description Identifies system running and return installation instructions
#' @return character
#' @examples
#' use_pkgr()
#' @rdname use_pkgr
#' @export
#' @importFrom glue glue glue_collapse
#' @importFrom cli rule
use_pkgr <- function(){

  os <- c('linux','darwin','mingw')

  header <- glue::glue(
    'Installing pkgr on a {cli::col_red(R.version$os)} system',
    cli::rule(),.sep = '\n')

  body <-  switch(os[sapply(os,grepl,x=R.version$os)],
         'darwin'  = {
           c('brew tap metrumresearchgroup/homebrew-tap',
             'brew install pkgr')

         },
         'linux' = {
           c('sudo wget https://github.com/metrumresearchgroup/pkgr/releases/download/v0.5.0-beta.3/pkgr_0.5.0-beta.3_linux_amd64.tar.gz -O /tmp/pkgr.tar.gz',
             'sudo tar xzf /tmp/pkgr.tar.gz pkgr',
             'sudo mv pkgr /usr/local/bin/pkgr',
             'sudo chmod +x /usr/local/bin/pkgr')
         },
         {
           c('browse to: https://github.com/metrumresearchgroup/pkgr#getting-started')
         })

    glue_this <- c(header,body)

    glue::glue_collapse(glue_this,sep = '\n')

}
