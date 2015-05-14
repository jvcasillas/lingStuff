#' A b function
#'
#' This function allows you to calculate b from the hit rate and false alarm rate
#' @param h Hit rate.
#' @param f False alarm rate.
#' @keywords b prime
#' @export
#' @examples
#' b(0.50, 0.25)

b <- function(h, f){
     if(f <= .5 & h >= .5)
       {
         b <- (5 - 4 * h) / (1 + 4 * f)
       } else if(f <= h & h <= .5)
       {
         b <-( h^2 + h) / (h^2 + f) 
       } else { 
         b <- ((1 - f)^2 + (1 - h)) / ((1 - f)^2 + (1 - f))
       } 
        return(b)
}
