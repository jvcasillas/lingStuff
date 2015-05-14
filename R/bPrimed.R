#' A b double prime d function
#'
#' This function allows you to calculate b double prime d from the hit rate and false alarm rate
#' @param h Hit rate.
#' @param f False alarm rate.
#' @keywords b double prime d
#' @export
#' @examples
#' bPrimed(0.50, 0.25)


bPrimed <- function(h, f){
    bd <- ((1 - h) * (1 - f) - (h * f)) / ((1 - h) * (1 - f) + (h * f))
    return(bd)
}