
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgr.utils

<!-- badges: start -->

<!-- badges: end -->

The goal of pkgr.utils is to …

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pkgr.utils)
## basic example code
```

``` r
pkgr.add(c('dplyr','ggplot2'))
#> [1] "pkgr add dplyr ggplot2"

pkgr.add(c('dplyr','ggplot2'),config='pkgr.yml')
#> [1] "pkgr add dplyr ggplot2 --config=pkgr.yml"

pkgr.add(c('dplyr','ggplot2'),config='pkgr.yml',flags='install')
#> [1] "pkgr add dplyr ggplot2 --config=pkgr.yml --install"

pkgr.remove(c('dplyr','ggplot2'))
#> [1] "pkgr remove dplyr ggplot2"

pkgr.install()
#> [1] "pkgr install"

pkgr.install(config='pkgr.yml',library=.libPaths()[1])
#> [1] "pkgr install --config=pkgr.yml --library=/Library/Frameworks/R.framework/Versions/3.6/Resources/library"

pkgr.plan(config='pkgr.yml',library=.libPaths()[1])
#> [1] "pkgr plan --config=pkgr.yml --library=/Library/Frameworks/R.framework/Versions/3.6/Resources/library"
```

``` r
pkgr.utils::desc2pkgr()
#> # DESCRIPTION file of 'pkgr.utils' converted to pkgr.yml
#> Version: 1
#> Threads: 4
#> Packages:
#> - httr
#> - yaml
#> - whisker
#> - desc
#> - magrittr
#> 
#> Repos:
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - CRAN: 'https://cran.rstudio.com'
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

``` r
pkgr.utils::pkgSetup2pkgr(pkgsetup = system.file('pkgSetup.R',package = 'pkgr.utils'))
#> Version: 1
#> Threads: 4
#> Packages: []
#> 
#> Repos:
#> - pkgsetup: 'pkg'
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - CRAN: 'https://cran.rstudio.com'
#> Library: 'lib'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

``` r

tf <- tempfile(fileext = '.yml')
pkgr.utils::desc2pkgr(out = tf)

pkgr.utils::pkgr.diff(pkgsetup = system.file('pkgSetup.R',package = 'pkgr.utils'),pkgr = tf)
#> logical(0)
```
