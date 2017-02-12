#' A vowel plot function
#'
#' This function will plot f1/f2 data. The function takes 4 
#' obligatory arguments and optionally one can include a 
#' grouping variable ('group'). This function is a wrapper 
#' for ggplot. Columns from the data frame must be wrapped 
#' in quotation marks. 
#'
#' @param data A data frame.
#' @param vowel A factor with vowels as levels
#' @param f1 A continuous variable
#' @param f2 A continuous variable
#' @param group An optional grouping variable for facets
#' @keywords vowel plot
#' @export
#' @examples
#' # Vowel plot without grouping variable
#' vowel_plot(data = vowel_data, vowel = 'vowel', f1 = 'f1', f2 = 'f2', group = NULL)
#' 
#' # Vowel plot with grouping variable
#' vowel_plot(data = vowel_data, vowel = 'vowel', f1 = 'f1', f2 = 'f2', group = 'gender')


vowel_plot <- function(data, vowel, f1, f2, group = NULL) {

  # Load ggplot
  require(ggplot2)

  # Check inputs for data frame 
  if(!is.data.frame(data)) {
  stop('I am so sorry, but this function requires a dataframe\n',
       'You have provided an object of class: ', class(data)[1])
  }

  # If no faceting needed
  if (length(group) == 0) {

  # Calculate means of f1/f2 as a function of vowel and print it 
  means_formula <- as.formula(paste("cbind(", f1, ",", f2, ")", "~", vowel))
  means <- aggregate(means_formula, FUN = mean, data = data)
  print(means)

  # Plot 
  p <- ggplot(data, 
       aes_string(x = f2, y = f1, color = vowel, label = vowel)) + 
       stat_ellipse(type = "norm", show.legend = FALSE, geom = "polygon", alpha = 0.15) + 
       geom_text(alpha = 0.3, show.legend = FALSE, size = 2.5) +
       geom_text(data = means, aes_string(x = f2, y = f1, color = vowel, 
                 label = vowel), size = 9, show.legend = FALSE, color = 'grey40') +
       scale_y_reverse() + 
       scale_x_reverse(position = "top") + 
       ylab('F1 (Hz)') + xlab('F2 (Hz)') + 
       scale_color_brewer(palette = 'Set1') + 
       theme_bw(base_size = 12, base_family = "Times New Roman")

  # If faceting needed
  } else {

  # Calculate means of f1/f2 as a function of vowel and grouping variable 
  # and print it
  means_formula <- as.formula(paste("cbind(", f1, ",", f2, ")", "~", vowel, "+", group))
  means <- aggregate(means_formula, FUN = mean, data = data)
  print(means)

  # Plot 
  p <- ggplot(data, 
       aes_string(x = f2, y = f1, color = vowel, label = vowel)) + 
       stat_ellipse(type = "norm", show.legend = FALSE, geom = "polygon", alpha = 0.15) +
       geom_text(alpha = 0.3, show.legend = FALSE, size = 2.5) +
       geom_text(data = means, aes_string(x = f2, y = f1, label = vowel), 
                 size = 9, show.legend = FALSE, color = 'grey40') +
       scale_y_reverse() + 
       scale_x_reverse(position = "top") +
       facet_grid(as.formula(paste(".~ ", group))) + 
       ylab('F1 (Hz)') + xlab('F2 (Hz)') + 
       scale_color_brewer(palette = 'Set1') + 
       theme_bw(base_size = 12, base_family = "Times New Roman")

  }

  print(p)

}

