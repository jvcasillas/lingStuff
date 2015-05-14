#' A euclidean distance function
#'
#' This function allows you to calculate the euclidean distance between two vectors
#' @param x1 Numeric vector (generally f1).
#' @param x2 Numeric vectors (generally f2).
#' @keywords euclidean distance
#' @export
#' @examples
#' euc.dist(rnorm(10, 10, 2), rnorm(10, 20, 2))


euc.dist <- function(x1, x2){
  x <- sqrt(sum((x1 - x2)^2))
  return(x)
}
