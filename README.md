
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rainbowr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/djnavarro/rainbowr.svg?branch=master)](https://travis-ci.org/djnavarro/rainbowr)
<!-- badges: end -->

The `rainbowr` package generates LGBT pride flags overlaid with the R
logo

## Installation

The package can be installed from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("djnavarro/rainbowr")
```

## Example

``` r
library(magick)
#> Linking to ImageMagick 6.9.7.4
#> Enabled features: fontconfig, freetype, fftw, lcms, pango, x11
#> Disabled features: cairo, ghostscript, rsvg, webp
library(rainbowr)

rainbow_flag <- make_banner("rainbow")
trans_flag <- make_banner("transgender")

plot(rainbow_flag)
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r
plot(trans_flag)
```

<img src="man/figures/README-example-2.png" width="100%" />

The flags are taken from the Wikipedia page for [LGBT
symbols](https://en.wikipedia.org/wiki/LGBT_symbols) and the Wikicommons
page for [Sexual identity
symbols](https://commons.wikimedia.org/wiki/Sexual_identity_symbols),
but is not exhaustive. To see which flags are included:

``` r
list_flags()
#>  [1] "agender"          "aromantic"        "asexual"         
#>  [4] "bear"             "bisexual"         "demisexual"      
#>  [7] "genderfluid"      "genderqueer"      "intersex"        
#> [10] "lesbian"          "lipstick_lesbian" "nonbinary"       
#> [13] "pansexual"        "polyamory"        "polysexual"      
#> [16] "rainbow"          "transgender"      "twink"
```
