#' A bivariate regression function
#'
#' This function will fit a linear model to two variables. The 
#' criterion can be continuous or binary. For logistic regression, 
#' set family = 'binomial'. For poisson regression, set family = 
#' 'poisson'. If omitted, family will default to 'gaussian' for 
#' standard linear regression.
#'
#' @param data A data frame.
#' @param x An independent variable
#' @param y A dependent variable
#' @param family A distribution ('gaussian', 'binomial', or 'poisson')
#' @keywords bivariate regression
#' @importFrom stats glm lm predict plogis
#' @import graphics
#' @export
#' @examples
#' # Linear regression
#' biVarPlot(data = cars, x = dist, y = speed)
#' biVarPlot(data = mtcars, x = cyl, y = mpg)
#' biVarPlot(data = Orange, x = age, y = circumference)
#' biVarPlot(data = ChickWeight, x = Time, y = weight)
#' biVarPlot(data = USArrests, x = UrbanPop, y = Rape)
#' 
#' # Logistic regression
#' vot  <- rnorm(20, 15, 5)
#' vot  <- sort(vot)
#' phon <- c(0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1)
#' df1  <- data.frame(vot, phon)
#' biVarPlot(data = df1, x = vot, y = phon, family = 'binomial')
#' 
#' # Poisson regression
#' time   <- 1:10
#' counts <- c(18, 17, 21, 20, 25, 27, 30, 43, 52, 50)
#' df2    <- data.frame(time, counts)
#' biVarPlot(data = df2, x = time, y = counts, family = 'poisson')

biVarPlot <- function(data, x, y, family = 'Gaussian'){

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

    if (family == 'poisson'){

        # Fit the model
        mod = glm(dv ~ iv, family = 'poisson')

        # Use model to predict data for CIs
        xvals = seq(from = min(iv) - 100, to = max(iv) + 100, by = 0.01)
        newdata = data.frame(iv = xvals)
        predY = predict(mod, newdata)
        SEs = predict(mod, newdata, se.fit = T)$se.fit

        seUB <- exp(predY + 1.96 * SEs)
        seLB <- exp(predY - 1.96 * SEs)

        # Plot the data, including regression line, CIs, and R2
        plot(dv ~ iv, type = 'n', frame = TRUE, ylab = yLab, xlab = xLab)
        polygon(x = c(xvals, rev(xvals)), 
                y = c(seUB, rev(seLB)), 
                border = NA, col = 'grey90')
        curve(predict(mod, data.frame(iv = x), type = "resp"), add = TRUE) 
        points(iv, dv, bg = "lightblue", col = "darkred", cex = 0.8, pch = 21)
        abline(mod, lwd = 1.25, col = 'grey20')

        # Print summary of model fit
        print(summary(mod))

    } else if(family == 'binomial'){

        # Fit the model
        mod = glm(dv ~ iv, family = family)

        # Use model to predict data for CIs
        xvals = seq(from = min(iv) - 100, to = max(iv) + 100, by = 0.01)
        newdata = data.frame(iv = xvals)
        predY = predict(mod, newdata)
        SEs = predict(mod, newdata, se.fit = T)$se.fit

        seUB <- plogis(predY + 1.96 * SEs)
        seLB <- plogis(predY - 1.96 * SEs)

        # Plot the data, including regression line, CIs, and R2
        plot(dv ~ iv, type = 'n', frame = TRUE, ylab = yLab, xlab = xLab)
        polygon(x = c(xvals, rev(xvals)), 
                y = c(seUB, rev(seLB)), 
                border = NA, col = 'grey90')
        curve(predict(mod, data.frame(iv = x), type = "resp"), add = TRUE) 
        points(iv, dv, bg = "lightblue", col = "darkred", cex = 0.8, pch = 21)

        # Print summary of model fit
        print(summary(mod))

    } else {

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
}






