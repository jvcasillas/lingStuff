#' A b double prime d function
#'
#' This function allows you to calculate b double prime d from a vector hits 
#' and a vector a false alarms.
#' @param data A data frame.
#' @param h A vector of hits (0 = miss, 1 = hit).
#' @param f A vector of false alarms (0 = correct rejection, 1 = false alarm).
#' @keywords b double prime d
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
#' # Calculate b''d for each subject
#' # by group, plot it, and run a 
#' # linear model
#' axb %>%
#'   group_by(subj, group) %>%
#'   summarize(bdpd = bPrimed(., hit, fa)) %T>%
#'  {
#'   plot(bdpd ~ as.numeric(group), data = ., 
#'        main = "b''d as a function of group", xaxt = "n", 
#'        xlab = "Group", ylab = "b''d")
#'   axis(1, at = 1:2, labels = c("g1", "g2"))
#'   abline(lm(bdpd ~ as.numeric(group), data = .), col = "red")
#'  } %>%
#'  lm(bdpd ~ group, data = .) %>%
#'  summary()



bPrimed <- function(data, h, f){
    hRate = mean(h)
    faRate = mean(f) 
    bd <- ((1 - hRate) * (1 - faRate) - (hRate * faRate)) / ((1 - hRate) * (1 - faRate) + (hRate * faRate))
    return(bd)
}
