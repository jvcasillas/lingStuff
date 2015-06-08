#' A cross over function
#'
#' This function allows you to calculate boundary/crossover point in 
#' 2AFC experiments. 
#' @param x A glm object
#' @keywords crossover
#' @export
#' @examples
#' # Generate data
#' set.seed(1)
#' vot = rnorm(20, 15, 5)
#' vot = sort(vot)
#' phon = c(0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1)
#' df = as.data.frame(cbind(vot, phon))
#'  
#' # Fit model
#' glm <- glm(phon ~ vot, data = df, family = "binomial")
#' 
#' # Get crossover point
#' print(crossOver(glm))
#' 
#' # Plot regression with crossover point
#' plot(df$vot, df$phon, xlab = "vot", ylab = "phon", pch = 16, col = rgb(0, 0, 204, 102, maxColorValue = 255)) 
#' curve(predict(glm, data.frame(vot = x), type = "resp"), add = TRUE) 
#' points(vot, fitted(glm), pch = 20)
#' abline(v = crossOver(glm), lty = 2, lwd = 0.75)
#' abline(h = 0.5, v = 0)


crossOver <- function(x) {
    cross <- (summary(x)$coefficients[1, 1] / summary(x)$coefficients[2, 1] * -1)
    return(cross)
}