#' A linear regression teaching tool
#'
#' This function takes user inputs, creates a data frame, 
#' fits a linear model, and plots the output. The function 
#' can take 4 optional arguments that adjust the relationship 
#' between x and y. The purpose of this function is to help 
#' teach the linear model.
#'
#' @param n Number of observations
#' @param intercept The y-intercept
#' @param slope The slope the line
#' @param sigma Spread around the mean
#' @keywords linear model plot
#' @export
#' @examples
#' # 'y' as a function of 'x' with 100 observations, intercept 
#' of 50, slope of 10, and sigma at 0.5
#' lm_ex()
#' 
#' # Negative slope
#' lm_ex(n = 55, intercept = 25, slope = -5, sigma = 0.75)


lm_ex <- function(n = 100, intercept = 50, slope = 10, sigma = 0.5){
  
  # Load ggplot
  require(ggplot2)

  # Define variables
  x <- rnorm(n)
  beta0 <- intercept  
  beta1 <- slope
  sigma <- sigma

  # Add linear effect to y
  y <- beta0 + x * beta1 + rnorm(n = n, sd = sigma)

  # make df 
  mod_df <- data.frame(x, y)

  # fit model 
  mod_ex <- lm(y ~ x, data = mod_df)

  # Plot it 
  annotations <- data.frame(
    xpos = c(-Inf, 1),
    ypos = c(coef(mod_ex)[1], coef(mod_ex)[1]),
    annotateText = c(paste("y-intercept = ", round(coef(mod_ex)[1], 2)), 
                     paste("Slope = ", round(coef(mod_ex)[2], 2))),
    hjustvar = c(-0.20, -0.10),
    vjustvar = c(-1, 2))

  p <- ggplot(mod_df, aes(x = x, y = y)) + 
    geom_point(size = 3, color = 'grey30', alpha = 0.5) + 
    geom_point(size = 2, color = 'lightblue', alpha = 0.4) + 
    geom_abline(color = "darkred", lwd = 1,
                slope = coef(mod_ex)[2], 
                intercept = coef(mod_ex)[1]) + 
    # Intercept lines
    geom_vline(xintercept = 0, lty = 3, color = 'grey30') + 
    geom_hline(yintercept = coef(mod_ex)[1], lty = 3, 
               color = 'grey30') + 
    # Slope lines 
    geom_segment(aes(x = 0, xend = 1, 
                     y = coef(mod_ex)[1], yend = coef(mod_ex)[1]), 
                     lty = 2, color = 'darkred') + 
    geom_segment(aes(x = 1, xend = 1, 
                     y = coef(mod_ex)[1], 
                     yend = coef(mod_ex)[1] + coef(mod_ex)[2]), 
                     lty = 2, color = 'darkred') + 
    geom_text(data = annotations, aes(x = xpos, y = ypos, 
              hjust = hjustvar, vjust = vjustvar, 
              label = annotateText)) +
    theme_bw(base_size = 20, base_family = "Times")

  print(p)
}