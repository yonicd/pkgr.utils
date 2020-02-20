
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

### Updating/Installing pkgr with pkgr.utils

`Use_pkgr()` checks the OS that R is being used on and returns
installation instructions for pkgr on the system. It also checks if the
current release is installed on the system. If it is not then the user
is asked if the steps listed should be executed to update to the current
release.

``` r
pkgr.utils::use_pkgr()
#> Installing pkgr on a darwin15.6.0 system
#> ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#> brew tap metrumresearchgroup/homebrew-tap
#> brew install metrumresearchgroup/tap/pkgr
#>  
#> ══ pkgr Version: 0.5.0-beta (Not Current Release) is Installed ════════════════════════════════════════════════════════════════════════════════════════════════════════
```

### Query MPN Releases

``` r
pkgr.utils::mpn_release()
#> $latest
#> [1] "2020-01-29"
#> 
#> $snapshots
#> [1] "2020-01-29" "2020-01-11" "2019-12-15" "2019-12-02" "2019-11-09"
#> [6] "2019-10-21" "2019-10-04"
```

### Command line builders

> To run these outputs from within `R` pipe (`%>%`) them into a `system`
> call.

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
#> - MPN: https://mpn.metworx.com/snapshots/stable/2020-01-29
#> - CRAN: https://cran.microsoft.com/snapshot/2020-02-19
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
#> - base64enc
#> Repos: 
#> - MPN: https://mpn.metworx.com/snapshots/stable/2020-01-29
#> - CRAN: https://cran.microsoft.com/snapshot/2020-02-19
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
#> - MPN: https://mpn.metworx.com/snapshots/stable/2020-01-29
#> - CRAN: https://cran.microsoft.com/snapshot/2020-02-19
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
#> - MPN: https://mpn.metworx.com/snapshots/stable/2020-01-29
#> - CRAN: https://cran.microsoft.com/snapshot/2020-02-19
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
```

<details closed>

<summary> <span title="Click to Open"> Click to See pkgr.yml in the
tempfile </span> </summary>

``` yml

# Created using pkgr.utils template
Version: 1
Threads: 7
Packages: 
- yaml
- desc
- httr
- here
- rstudioapi
- glue
- cli
- magrittr
- jsonlite
- curl
- base64enc
Repos: 
- pkgsetup: pkg
- MPN: https://mpn.metworx.com/snapshots/stable/2020-01-29
- CRAN: https://cran.microsoft.com/snapshot/2020-02-19
Library: 'lib'
Cache: pkgcache
Logging:
  all: pkgr-log.log
```

</details>

<br>

``` r
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
