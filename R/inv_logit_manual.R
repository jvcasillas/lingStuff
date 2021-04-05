#' An inverse logit function
#'
#' This function allows you to calculate probability from log odds
#' @param x An integer
#' @keywords inverse logit
#' @import dplyr
#' @importFrom rlang .data
#' @export
#' @examples
#' inv_logit_manual(1)

inv_logit_manual <- function(x) {
  val <- 1 / (1 + exp(-x))
  return(val)
}
