
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

# using pkgr.here function
pkgr.install(config=pkgr.here(),library=.libPaths()[1])
#> [1] "pkgr install --config=/Users/yonis/projects/pkgr.utils/pkgr.yml --library=/Library/Frameworks/R.framework/Versions/3.6/Resources/library"
```

### Initialize a yml from a template

``` r
pkgr.new(pkgs)
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
#> - CRAN: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Convert DESCRIPTION file to pkgr.yml

#### Local

``` r
pkgr.utils::desc2pkgr()
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
#> Packages: 
#> - httr
#> - yaml
#> - whisker
#> - desc
#> - magrittr
#> - here
#> - rstudioapi
#> Repos: 
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - CRAN: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

#### URL

``` r
sinew_uri <- 'https://raw.githubusercontent.com/metrumresearchgroup/sinew/master/DESCRIPTION'
sinew_pkgr <- pkgr.utils::desc2pkgr(sinew_uri)
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
#> - CRAN: https://cran.rstudio.com
#> Library: '/Library/Frameworks/R.framework/Versions/3.6/Resources/library'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Convert pkgSetup.R file to pkgr.yml

``` r
pkgr.utils::pkgSetup2pkgr(pkgsetup = system.file('pkgSetup.R',package = 'pkgr.utils'))
#> # Created using pkgr.utils template
#> Version: 1
#> Threads: 7
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
#> Repos: 
#> - pkgsetup: pkg
#> - gh_external: https://metrumresearchgroup.github.io/rpkgs/gh_external
#> - gh_dev: https://metrumresearchgroup.github.io/rpkgs/gh_dev
#> - mrg_val: https://metrumresearchgroup.github.io/r_validated
#> - CRAN: https://cran.rstudio.com
#> Library: 'lib'
#> Cache: pkgcache
#> Logging:
#>   all: pkgr-log.log
```

### Find difference in packages listed in DESCRIPTION/pkgSetup and pkgr.yml

#### pkgSetup.R

``` r
tf <- tempfile(fileext = '.yml')
pkgr.utils::desc2pkgr(out = tf)

pkgr.utils::pkgr.diff(src = system.file('pkgSetup.R',package = 'pkgr.utils'),pkgr = tf)
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

#### DESCRIPTION

``` r
tf_desc <- tempfile(pattern = 'DESCRIPTION')
utils::download.file(sinew_uri, destfile = tf_desc, quiet = TRUE)

readLines(tf_desc)
#>  [1] "Package: sinew"                                                                            
#>  [2] "Type: Package"                                                                             
#>  [3] "Title: Create 'roxygen2' Skeleton with Information from Function Script"                   
#>  [4] "Version: 0.3.9004"                                                                         
#>  [5] "Date: 2018-12-03"                                                                          
#>  [6] "Author: c(person(\"Jonathan\", \"Sidi\", email = \"yonis@metrumrg.com\", role = c(\"aut\","
#>  [7] "         \"cre\")), "                                                                      
#>  [8] "         person(\"Anton\",\"Grishin\",role = \"ctb\"),"                                    
#>  [9] "         person(\"Lorenzo\",\"Busetto\",role = \"ctb\"),"                                  
#> [10] "         person(\"Alexey\",\"Shiklomanov\",role = \"ctb\"))"                               
#> [11] "Maintainer: Jonathan Sidi <yonis@metrumrg.com>"                                            
#> [12] "Description: Create 'roxygen2' skeleton populated with information scraped from the"       
#> [13] "         within the function script. Also creates field entries for imports in the"        
#> [14] "         'DESCRIPTION' and import in the 'NAMESPACE' files. Can be run from the R"         
#> [15] "         console or through the 'RStudio' 'addin' menu."                                   
#> [16] "Depends: R (>= 2.3.0)"                                                                     
#> [17] "Imports: rstudioapi,utils,shiny,miniUI,tools,sos,stringi,yaml,crayon,cli,rematch2"         
#> [18] "License: GPL-2 | GPL-3"                                                                    
#> [19] "Suggests: roxygen2,testthat"                                                               
#> [20] "URL: https://github.com/metrumresearchgroup/sinew"                                         
#> [21] "BugReports: https://github.com/metrumresearchgroup/sinew/issues"                           
#> [22] "LazyData: true"                                                                            
#> [23] "NeedsCompilation: no"                                                                      
#> [24] "Packaged: 2017-01-31 14:00:00 UTC; Yoni"                                                   
#> [25] "RoxygenNote: 6.1.1"
```

``` r
pkgr.utils::pkgr.diff(src = tf_desc,pkgr = tf)
#> [1] "shiny"    "miniUI"   "sos"      "stringi"  "crayon"   "cli"     
#> [7] "rematch2" "roxygen2" "testthat"
```
