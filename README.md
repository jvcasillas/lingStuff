
<!-- badges: start -->

[![R-CMD-check](https://github.com/jvcasillas/lingStuff/workflows/R-CMD-check/badge.svg)](https://github.com/jvcasillas/lingStuff/actions)  
[![CodeFactor](https://www.codefactor.io/repository/github/jvcasillas/lingstuff/badge)](https://www.codefactor.io/repository/github/jvcasillas/lingstuff)
<!-- badges: end -->

## lingStuff <img src='https://raw.githubusercontent.com/jvcasillas/hex_stickers/master/stickers/lingStuff.png' align='right' width='275px' style="padding-left:5px;"/>

### Overview

This is a collection of `R` functions that I often use in my research.
Some are borrowed and edited, others are my own. Feel free to fork and
edit as you see fit.

#### Data sets

All data sets have been moved to the
[untidydata](https://github.com/jvcasillas/untidydata) package.

### Installation

In order to install this package you must have devtools and version
3.1.3 of R. Don’t know if you have devtools? Copy and paste this into
your console:

``` r
if (!require('devtools')) {
  stop('The package devtools is not installed')
}
```

R will load devtools if you have it, otherwise it will give you an
error, in which case you should copy and paste the following code into
the console:

``` r
install.packages("devtools")
```

Now that you have `devtools` installed, you can install `lingStuff`.

``` r
devtools::install_github("jvcasillas/lingStuff")
```
