#' An inverse logit function
#'
#' This function allows you to calculate probability from log odds
#' @param mod A glm object
#' @keywords inverse logit
#' @export
#' @examples
#' # Generate data
#' set.seed(1)
#' vot <- rnorm(20, 15, 5)
#' vot <- sort(vot)
#' fac <- rnorm(20, 100, 100)
#' phon <- c(0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1)
#' df <- data.frame(vot = vot, fac = fac, phon = phon)
#' 
#' # Fit models
#' glm0 <- glm(phon ~ vot, data = df, family = "binomial")
#' glm1 <- glm(phon ~ vot + fac, data = df, family = "binomial")
#' glm2 <- glm(phon ~ vot * fac, data = df, family = "binomial")
#' testLM <- lm(speed ~ dist, data = cars)
#' 
#' # Get beta weights as probabilities
#' inv_logit(glm0)
#' inv_logit(glm1)
#' inv_logit(glm2)
#' inv_logit(testLM) # Gives an error


inv_logit <- function(mod) {
    
    # Load dplyr
    require(dplyr)
    
    # Check to see if mod = glm object, if not, stop 
    if (class(mod)[1] == 'glm')
        {
            # Get betas weights and save them to DF
            tempDF <- as.data.frame(summary(mod)$coefficients[, 1])

            # Change name of betas column to 'betas'
            names(tempDF)[names(tempDF)=="summary(mod)$coefficients[, 1]"] <- "betas"

            # Set row names as column
            tempDF$variables <- rownames(tempDF)

            # Group by 'betas' and calculate inverse logit for all values
            betasDF <- group_by(tempDF, variables, betas) %>% 
            summarise(., prob = (exp(betas) / (1 + exp(betas)))) %>%
            as.data.frame(.)
            return(betasDF)
        } else {
            stop('Error: this function requires a glm object\n',
                 'You have provided an object of class: ', class(mod)[1])
        }
}





