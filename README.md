
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgr.utils

<!-- badges: start -->

<!-- badges: end -->

The goal of `pkgr.utils` is to control `pkgr` with utility functions
from within `R`.

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
```

### Convert DESCRIPTION file to pkgr.yml

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

### Convert pkgSetup.R file to pkgr.yml

``` r
pkgr.utils::pkgSetup2pkgr(pkgsetup = system.file('pkgSetup.R',package = 'pkgr.utils'))
#> Version: 1
#> Threads: 4
#> Packages:
#> - anytime
#> - batchmeans
#> - bayesplot
#> - bitops
#> - boot
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
#> - MASS
#> - Matrix
#> - MCMCpack
#> - mcmcse
#> - metrumrg
#> - mgcv
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

### Find difference in packages listed in pkgSetup and pkgr.yml

``` r

tf <- tempfile(fileext = '.yml')
pkgr.utils::desc2pkgr(out = tf)

pkgr.utils::pkgr.diff(pkgsetup = system.file('pkgSetup.R',package = 'pkgr.utils'),pkgr = tf)
#>  [1] "anytime"    "batchmeans" "bayesplot"  "bitops"     "boot"      
#>  [6] "broom"      "caTools"    "corrplot"   "corrr"      "data.table"
#> [11] "devtools"   "DHARMa"     "digest"     "docxtractr" "fork"      
#> [16] "formatR"    "GGally"     "ggcorrplot" "ggrepel"    "glmnet"    
#> [21] "gridExtra"  "haven"      "Hmisc"      "htmltools"  "kableExtra"
#> [26] "knitr"      "lubridate"  "MASS"       "Matrix"     "MCMCpack"  
#> [31] "mcmcse"     "metrumrg"   "mgcv"       "mrggsave"   "mrgsolve"  
#> [36] "mrgtable"   "npde"       "ordinalNet" "PKNCA"      "PKPDmisc"  
#> [41] "pmplots"    "png"        "qapply"     "remotes"    "reprex"    
#> [46] "reshape2"   "review"     "rlecuyer"   "rmarkdown"  "scales"    
#> [51] "tidynm"     "tidyverse"  "vpc"        "XML"        "xtable"    
#> [56] "yspec"
```
