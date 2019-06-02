
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rainbowr

<!-- badges: start -->

<!-- badges: end -->

The rainbowr package provides functions to generate LGBT pride flags
overlaid with the R logo

## Installation

The package can be installed [GitHub](https://github.com/) with:

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

The set of flags is taken from the Wikipedia page for [LGBT
symbols](https://en.wikipedia.org/wiki/LGBT_symbols) and the Wikicommons
page for [Sexual identity
symbols](https://commons.wikimedia.org/wiki/Sexual_identity_symbols),
and is only a partial listing. The flags inclided are:

``` r
list_flags()
#>  [1] "agender"          "aromantic"        "asexual"         
#>  [4] "bear"             "bisexual"         "demisexual"      
#>  [7] "genderfluid"      "genderqueer"      "intersex"        
#> [10] "lesbian"          "lipstick_lesbian" "nonbinary"       
#> [13] "pansexual"        "polyamory"        "polysexual"      
#> [16] "rainbow"          "transgender"      "twink"
```
