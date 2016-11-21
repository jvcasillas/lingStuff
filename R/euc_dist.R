#' A euclidean distance function
#'
#' This function allows you to calculate the euclidean distance between two vectors
#' @param x1 Numeric vector (generally f1).
#' @param x2 Numeric vectors (generally f2).
#' @keywords euclidean distance
#' @export
#' @examples
#' # Create some data
#' df <- data.frame(vowel = gl(n = 2, k = 5, labels = c('a', 'o')),
#'                  var1 = rnorm(10, 10, 2), 
#'                  var2 = rnorm(10, 20, 2))
#' 
#' # Calculate euc.dist on entire data frame
#' euc_dist(data = df, var1 = var1, var2 = var2)
#' 
#' # Calculate euc.dist for each vowel
#' df %>%
#'  group_by(., vowel) %>%
#'  summarise(euc = euc_dist(., var1 = var1, var2 = var2))


euc_dist <- function(data, var1, var2){
    if(!is.data.frame(data)) {
    stop('I am so sorry, but this function requires a dataframe\n',
         'You have provided an object of class: ', class(data)[1])
    }

    # Make columns of dataframe available w/o quotes
    arguments <- as.list(match.call())
    var1 = eval(arguments$var1, data)
    var2 = eval(arguments$var2, data)

    x <- sqrt(sum((var1 - var2)^2))
  return(x)
}

