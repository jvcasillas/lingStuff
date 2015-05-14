#' A d prime function
#'
#' This function will calculate d prime. This is common in discrimination experiments.
#' Note: If your participants are at ceiling, you may want to consider another analysis.
#' @param f Hit rate.
#' @param f False alarm rate.
#' @keywords d prime
#' @export
#' @examples
#' dPrime(.75, .25)


dPrime <- function(h, f){
    dp <- qnorm(h) - qnorm(f)
    return(dp)
}
