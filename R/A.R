#' An A function
#'
#' This function allows you to calculate A from the hit rate and false alarm rate
#' @param h Hit rate.
#' @param f False alarm rate.
#' @keywords A
#' @export
#' @examples
#' A(0.50, 0.25)

# Calculate A in discrimination experiments. 
# Takes two vectors:
#    - h (hit rate)
#    - f (false alarm rate)

A <- function(h, f){
    if(f <= .5 & h >= .5)
      {
        a <- .75 + (h - f) / 4 - f * (1 - h)
      } else if (f <= h & h <= .5)
      {
        a <- .75 + (h - f) / 4 - f / (4 * h)
      } else {
       a <- .75 + (h - f) / 4 - (1 - h) / (4 * (1 - f))
      } 
       return(a)
}
