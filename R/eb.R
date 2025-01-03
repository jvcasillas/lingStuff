#' A function for adding error bars to barplots
#'
#' This function is a wrap around for barplot() that will add error bars. This 
#' code was written by Dr. Mike Hammond at the U of A.
#' @param dv Numeric vector.
#' @param fac Factors.
#' @param ... Elipsis for passing arguements
#' @keywords error bars
#' @importFrom stats sd
#' @import untidydata
#' @export
#' @examples
#' eb(mtcars$mpg, as.factor(mtcars$cyl), ylab = "Miles per gallon", xlab = "cyl")
#' library(untidydata)
#' data(spirantization)
#' eb(spirantization$cIntensity, as.factor(spirantization$position))


eb <- function(dv, fac, ...) {
    # error checking
    if (!is.numeric(dv)) stop("first argument must be a vector of numbers")
    if (!is.factor(fac)) stop("Second argument must be a factor")
    if (length(dv) != length(fac))
        stop("Arguments must be of the same length")
    
    # set up variables
    num.levels <- length(levels(fac))
    lev.means <- numeric(num.levels)
    lev.sds <- numeric(num.levels)
    lev.sizes <- numeric(num.levels)
    lev.errors <- numeric(num.levels)
    
    # calculate error for each factor level
    for (l in 1:num.levels) {
        fl <- levels(fac)[l]
        lev.means[l] <- mean(dv[fac == fl])
        lev.sds[l] <- sd(dv[fac == fl])
        lev.sizes[l] <- length(dv[fac == fl])
        lev.errors[l] <- qnorm(0.975) * lev.sds[l] / sqrt(lev.sizes[l])
    }

    # how tall does the barplot have to be
    mean.max <- ceiling(max(lev.means + lev.errors))
    
    # make the plot
    x <- barplot(lev.means, ylim = c(0,mean.max), ...)
    
    # add the error bars
    arrows(
        x, lev.means - lev.errors,
        x, lev.means + lev.errors,
        code = 3, angle = 90, length = .1
    )
}

