#' Function for calculating d prime
#'
#' This function will calculate d prime from a vector of hits 
#' and a vector of false alarms. 
#' 
#' This metric is common in discrimination experiments. 
#' Note: If your participants are at ceiling, you may want to 
#' consider another analysis.
#' @param data A data frame.
#' @param h A vector of hits (0 = miss, 1 = hit).
#' @param f A vector of false alarms (0 = correct rejection, 1 = false alarm).
#' @keywords d prime
#' @importFrom stats qnorm
#' @export
#' @examples
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
#' # Calculate d prime on entire data frame
#' dPrime(axb, hit, fa)
#'
#'
#' # Calculate d prime for each subject by group, plot it, 
#' # and run a linear model
#' library(dplyr)
#' axb %>%
#'   group_by(subj, group) %>%
#'   summarize(dp = dPrime(., hit, fa)) %T>%
#'  {
#'   plot(dp ~ as.numeric(group), data = ., 
#'        main = "d' as a function of group", xaxt = "n", 
#'        xlab = "Group", ylab = "d' prime")
#'   axis(1, at = 1:2, labels = c("g1", "g2"))
#'   abline(lm(dp ~ as.numeric(group), data = .), col = "red")
#'  } %>%
#'  lm(dp ~ group, data = .) %>%
#'  summary()

dPrime <- function(data, h, f){
    if(!is.data.frame(data)) {
    stop('I am so sorry, but this function requires a dataframe\n',
         'You have provided an object of class: ', class(data)[1])
    }

    # Make columns of dataframe available w/o quotes
    arguments <- as.list(match.call())
    hits = eval(arguments$h, data)
    fas = eval(arguments$f, data)

    dp = qnorm(mean(hits)) - qnorm(mean(fas))
    return(dp)
}

