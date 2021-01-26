
## lingStuff <img src='https://raw.githubusercontent.com/jvcasillas/hex_stickers/master/stickers/lingStuff.png' align='right' width='275px' style="padding-left:5px;"/>

### Overview

This is a collection of `R` functions that I often use in my research.
Some are borrowed and edited, others are my own. Feel free to fork and
edit as you see fit.

### Current functions

-   `A`: Calculate A (discrimination experiments)
-   `aPrime`: Calculate A’ (discrimination experiments)
-   `b`: Calculate B (discrimination experiments)
-   `biVarPlot`: Fit a linear model to two variables and plot the
    results
-   `bPrimed`: Calculate b’’d (b double prime d) (discrimination
    experiments)
-   `cross_over`: Calculate 50% crossover point between categorical
    dependent variable (logistic regression)
-   `dPrime`: Calculate d’ (discrimination experiments)
-   `eb`: Wrapper function for `barplot()` that adds error bars
-   `euc.dist`: Calculate the euclidean distance between points/vowels
    (production experiments)
-   `inv_logit`: Calculate the inverse logit from a GLM object (log odds
    to probability)
-   `lm_ex`: Creates a scatter plot and fits a linear model. Used for
    teaching.
-   `vowel_plot`: Takes a dataframe of formant data and creates a vowel
    plot.

#### Data sets

These have been moved to the
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
