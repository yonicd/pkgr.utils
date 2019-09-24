
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgr.utils

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of `pkgr.utils` is to create `pkgr` commands and config files
from templates from within `R`.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pkgr.utils)
```

### Command line builders

add/remove packages to `pkgr.yml`

``` r
pkgs <- c('dplyr','ggplot2')

pkgs%>%
  pkgr.add()
#> [1] "pkgr add dplyr ggplot2"

pkgs%>%
  pkgr.add(config='pkgr.yml')
#> [1] "pkgr add dplyr ggplot2 --config=pkgr.yml"

pkgs%>%
  pkgr.add(config='pkgr.yml',flags='install')
#> [1] "pkgr add dplyr ggplot2 --config=pkgr.yml --install"

pkgs[1]%>%
  pkgr.remove()
#> [1] "pkgr remove dplyr"
```

plan/install

``` r
# basic
pkgr.plan()
#> [1] "pkgr plan"
pkgr.install()
#> [1] "pkgr install"


# with options
pkgr.install(config='pkgr.yml',library=.libPaths()[1])
#> [1] "pkgr install --config=pkgr.yml --library=/Library/Frameworks/R.framework/Versions/3.6/Resources/library"

# using pkgr.here function
pkgr.install(config=pkgr.here(),library=.libPaths()[1])
#> [1] "pkgr install --config=/Users/yonis/projects/pkgr.utils/pkgr.yml --library=/Library/Frameworks/R.framework/Versions/3.6/Resources/library"
```

### Initialize a yml from a template

``` r
pkgs%>%
  pkgr.utils::pkgr.new()
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
#> Packages: 
#> - dplyr
#> - ggplot2
#> Repos: 
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - rs_cran: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Convert DESCRIPTION file to pkgr.yml

#### Local

``` r

pkgr.utils::get_deps()%>%
  pkgr.utils::pkgr.new()
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
#> Packages: 
#> - yaml
#> - desc
#> - httr
#> - here
#> - rstudioapi
#> - glue
#> - cli
#> - magrittr
#> - jsonlite
#> - curl
#> Repos: 
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - rs_cran: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

#### URL

``` r
sinew_uri <- 'https://raw.githubusercontent.com/metrumresearchgroup/sinew/master/DESCRIPTION'

sinew_uri%>%
  pkgr.utils::get_deps()%>%
  pkgr.utils::pkgr.new()
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
#> Packages: 
#> - rstudioapi
#> - shiny
#> - miniUI
#> - sos
#> - stringi
#> - yaml
#> - crayon
#> - cli
#> - rematch2
#> - roxygen2
#> - testthat
#> Repos: 
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - rs_cran: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Convert pkgSetup.R file to pkgr.yml

``` r

system.file('pkgSetup.R',package = 'pkgr.utils')%>%
  pkgr.utils::get_deps(type = 'pkgSetup')%>%
  pkgr.utils::pkgr.new(
    repos = c(pkgsetup = 'pkg',pkgr.utils::get_repos()),
    libpath = 'lib'
  )
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
#> Packages: 
#> - anytime
#> - batchmeans
#> - bayesplot
#> - bitops
#> - broom
#> - caTools
#> - corrplot
#> - corrr
#> - data.table
#> - devtools
#> - DHARMa
#> - digest
#> - docxtractr
#> - fork
#> - formatR
#> - GGally
#> - ggcorrplot
#> - ggrepel
#> - glmnet
#> - gridExtra
#> - haven
#> - Hmisc
#> - htmltools
#> - kableExtra
#> - knitr
#> - lubridate
#> - magrittr
#> - MCMCpack
#> - mcmcse
#> - metrumrg
#> - mrggsave
#> - mrgsolve
#> - mrgtable
#> - npde
#> - ordinalNet
#> - PKNCA
#> - PKPDmisc
#> - pmplots
#> - png
#> - qapply
#> - remotes
#> - reprex
#> - reshape2
#> - review
#> - rlecuyer
#> - rmarkdown
#> - scales
#> - tidynm
#> - tidyverse
#> - vpc
#> - XML
#> - xtable
#> - yaml
#> - yspec
#> Repos: 
#> - pkgsetup: pkg
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - rs_cran: https://cran.rstudio.com
#> Library: 'lib'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Find difference in packages listed in DESCRIPTION/pkgSetup and pkgr.yml

#### pkgSetup.R

``` r
tf <- tempfile(fileext = '.yml')

pkgr.utils::get_deps(type = 'DESCRIPTION')%>%
  pkgr.utils::pkgr.new(
    repos = c(pkgsetup = 'pkg',pkgr.utils::get_repos()),
    libpath = 'lib',
    out = tf
  )

pkgr.utils::pkgr.diff(
  src = system.file('pkgSetup.R',package = 'pkgr.utils'),
  pkgr = tf
)
#>  [1] "anytime"    "batchmeans" "bayesplot"  "bitops"     "broom"     
#>  [6] "caTools"    "corrplot"   "corrr"      "data.table" "devtools"  
#> [11] "DHARMa"     "digest"     "docxtractr" "fork"       "formatR"   
#> [16] "GGally"     "ggcorrplot" "ggrepel"    "glmnet"     "gridExtra" 
#> [21] "haven"      "Hmisc"      "htmltools"  "kableExtra" "knitr"     
#> [26] "lubridate"  "MCMCpack"   "mcmcse"     "metrumrg"   "mrggsave"  
#> [31] "mrgsolve"   "mrgtable"   "npde"       "ordinalNet" "PKNCA"     
#> [36] "PKPDmisc"   "pmplots"    "png"        "qapply"     "remotes"   
#> [41] "reprex"     "reshape2"   "review"     "rlecuyer"   "rmarkdown" 
#> [46] "scales"     "tidynm"     "tidyverse"  "vpc"        "XML"       
#> [51] "xtable"     "yspec"
```

#### DESCRIPTION

``` r

pkgr.utils::pkgr.diff(src = 'DESCRIPTION',pkgr = tf)
#> character(0)

pkgr.utils::pkgr.diff(src = sinew_uri,pkgr = tf)
#> [1] "shiny"    "miniUI"   "sos"      "stringi"  "crayon"   "rematch2"
#> [7] "roxygen2" "testthat"
```
