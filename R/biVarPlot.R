#' A bivariate regression function
#'
#' This function will fit a linear model to two continuous 
#' variables and plot the outcome.
#'
#' @param data A data frame.
#' @param y A dependent variable
#' @param x An independent variable
#' @keywords bivariate regression
#' @export
#' @examples
#' biVarPlot(data = cars, x = dist, y = speed)
#' biVarPlot(data = mtcars, x = cyl, y = mpg)
#' biVarPlot(data = Orange, x = age, y = circumference)
#' biVarPlot(data = ChickWeight, x = Time, y = weight)
#' biVarPlot(data = USArrests, x = UrbanPop, y = Rape)

biVarPlot <- function(data, x, y){

    # This function takes a dataframe and two columns (i.e. numeric vectors) 
    # and fits a bivariate linear regression. 
    # It will produce a scatterplot with a regression line, 95% CI, R2, and 
    # print the model output

    # Check inputs
    if(!is.data.frame(data)) {
    stop('I am so sorry, but this function requires a dataframe\n',
         'You have provided an object of class: ', class(data)[1])
    }

    # Make columns of dataframe available w/o quotes
    arguments <- as.list(match.call())
    dv = eval(arguments$y, data)
    iv = eval(arguments$x, data)

    # Get column names for plot labels 
    yLab = as.character(arguments$y)
    xLab = as.character(arguments$x)

    # Fit the model
    mod = lm(dv ~ iv)

    # Use model to predict data for CIs
    xvals = seq(from = min(iv) - 100, to = max(iv) + 100, by = 0.01)
    newdata = data.frame(iv = xvals)
    predY = predict(mod, newdata)
    SEs = predict(mod, newdata, se.fit = T)$se.fit

    # Plot the data, including regression line, CIs, and R2
    plot(dv ~ iv, type = 'n', frame = TRUE, ylab = yLab, xlab = xLab)
    polygon(x = c(xvals, rev(xvals)), 
            y = c(predY + 1.96 * SEs, rev(predY - 1.96 * SEs)), 
            border = NA, col = 'grey90')
    points(iv, dv, bg = "lightblue", col = "darkred", cex = 0.8, pch = 21)
    abline(mod, lwd = 1.25, col = 'grey20')
    text(x = (max(iv) - (max(iv) * 0.05)), y = (max(dv) - (max(dv) * 0.05)), 
         bquote(R^2 == .(format(round(summary(mod)$r.squared, 2), nsmall = 2))))

    # Print summary of model fit
    print(summary(mod))
}
