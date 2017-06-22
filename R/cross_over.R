#' A cross over function
#'
#' This function allows you to calculate boundary/crossover point in 
#' logistic regression models. 
#' @param mod A glm object
#' @param cont_pred The continuous (x) predictor
#' @param grouping_var (logical) Set to TRUE to include grouping var
#' @param int_adj With grouping variable, include intercept adjustment
#' @param slope_adj With grouping variable, include interaction (slope adjustment)
#' @keywords crossover
#' @export
#' @examples
#' # Generate data
#' set.seed(1)
#' vot = rnorm(20, 15, 5)
#' vot = sort(vot)
#' phon1 = c(0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1)
#' group1 = rep('g1', 20)
#' df1 = data.frame(vot = vot, phon = phon1, group = group1)
#' 
#' phon2 = c(1,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1,1,1)
#' group2 = rep('g2', 20)
#' df2 = data.frame(vot = vot, phon = phon2, group = group2)
#' df <- rbind(df1, df2)
#' 
#' # Fit model
#' glm1 <- glm(phon ~ vot, data = df, family = "binomial")
#' glm2 <- glm(phon ~ vot * group, data = df, family = "binomial")
#' 
#' # Get crossover point
#' cross_over(mod = glm1, cont_pred = 'vot')
#' 
#' # Get crossover point of grouping variables
#' cross_over(mod = glm2, cont_pred = 'vot')
#' cross_over(mod = glm2, cont_pred = 'vot', grouping_var = TRUE, int_adj = 'groupg2', slope_adj = 'vot:groupg2')
#' 
#' # Plot regression with crossover point
#' ggplot(df, aes(x = vot, y = phon)) + 
#'   geom_smooth(method = 'glm', method.args = list(family = 'binomial')) + 
#'   geom_vline(xintercept = cross_over(mod = glm1, cont_pred = 'vot'))
#' 
#' ggplot(df, aes(x = vot, y = phon, color = group)) + 
#'   geom_smooth(method = 'glm', method.args = list(family = 'binomial'), se = F) + 
#'   geom_vline(xintercept = cross_over(mod = glm2, cont_pred = 'vot')) +
#'   geom_vline(xintercept = cross_over(mod = glm2, cont_pred = 'vot', grouping_var = T, 
#'                                      int_adj = 'groupg2', slope_adj = 'vot:groupg2'))


cross_over <- function(mod, cont_pred, grouping_var = FALSE, int_adj, slope_adj) {

  if (class(mod)[1] == "glm") {

    # Store intercept
    int <- summary(mod)$coefficients['(Intercept)', 'Estimate']

    # Store continuous x var
    slope <- summary(mod)$coefficients[cont_pred, 'Estimate']

    # For bivariate models
    if (grouping_var == FALSE) {

      # Calculate crossover
      co <- int / slope * -1

    # For models with grouping vars
    } else {

      # Calculate group level intercept
      int_derived <- int + summary(mod)$coefficients[int_adj, 'Estimate']

      # Calculate slope adjustment
      slope_derived <- slope + summary(mod)$coefficients[slope_adj, 'Estimate']

      # Calculate crossover
      co <- int_derived / slope_derived * -1

    }

    return(co)

  } else {

    stop("Error: this function requires a glm object\n", 
         "You have provided an object of class: ", class(mod)[1])
  }

}








