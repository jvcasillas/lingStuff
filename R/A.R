#' An A function
#'
#' This function allows you to calculate A from from a vector hits 
#' and a vector a false alarms.
#' @param data A data frame.
#' @param h A vector of hits (0 = miss, 1 = hit).
#' @param f A vector of false alarms (0 = correct rejection, 1 = false alarm).
#' @keywords A
#' @export
#' @examples
#' # Example
#' # Create some data
#' set.seed(1); library(dplyr)
#' axb <- data.frame(subj = sort(rep(1:10, each = 20, times = 10)),
#'                   group = gl(2, 1000, labels = c("g1", "g2")),
#'                   hit = c(rbinom(1000, size = c(0, 1), prob = .8), 
#'                           rbinom(1000, size = c(0, 1), prob = .6)),
#'                   fa =  c(rbinom(1000, size = c(0, 1), prob = .3), 
#'                           rbinom(1000, size = c(0, 1), prob = .4))
#' )
#' 
#' # Calculate A for each subject
#' # by group, plot it, and run a 
#' # linear model
#' axb %>%
#'   group_by(subj, group) %>%
#'   summarize(A = A(., hit, fa)) %T>%
#'  {
#'   plot(A ~ as.numeric(group), data = ., 
#'        main = "A as a function of group", xaxt = "n", 
#'        xlab = "Group", ylab = "A")
#'   axis(1, at = 1:2, labels = c("g1", "g2"))
#'   abline(lm(A ~ as.numeric(group), data = .), col = "red")
#'  } %>%
#'  lm(A ~ group, data = .) %>%
#'  summary()

A <- function(data, h, f){
    hRate = mean(h)
    faRate = mean(f) 
    if (faRate <= .5 & hRate >= .5)
      {
       a <- .75 + (hRate - faRate) / 4 - faRate * (1 - hRate)
      } else if (faRate <= hRate & hRate <= .5)
      {
       a <- .75 + (hRate - faRate) / 4 - faRate / (4 * hRate)
      } else {
       a <- .75 + (hRate - faRate) / 4 - (1 - hRate) / (4 * (1 - faRate))
      } 
}
