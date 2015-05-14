#' An A prime function
#'
#' This function allows you to calculate A prime from the hit rate and false alarm rate
#' @param h Hit rate.
#' @param f False alarm rate.
#' @keywords A prime
#' @export
#' @examples
#' aPrime(0.50, 0.25)


aPrime <-function(h, f){
    if(h >= f)
      {
        a <- .5 + (((h - f) * (1 + h - f)) / ((4 * h) * (1 - f)))
      } else if(h < f)
      {
        a <- .5 - (((f - h) * (1 + f - h)) / ((4 * f) * (1 - h)))
      }
       return(a)
}
