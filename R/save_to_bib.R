#' A function for saving R packages to a .bib file
#'
#' This function will generate a .bib file for an R package.
#'
#' @param package A character vector of the package you want to cite.
#' @param file_name A character vector for the file name of the output. Defaults to the package name.
#' @keywords bibtex
#' @importFrom utils capture.output citation toBibtex
#' @export
#' @examples
#' # Create a .bib file called "test.bib" to cite the tidyverse
#' # save_to_bib("tidyverse", "test")


save_to_bib <- function(package, file_name = NULL) {

  # Check if filename is provided
  if (is.null(file_name)) {
    f_name <- paste0(package, ".bib")
  } else {
  f_name = paste0(file_name, ".bib")
  }

  # Get package name and write file
  pkg <- citation(package)
  writeLines(capture.output(toBibtex(pkg)), f_name)
  cat(f_name, "saved to working directory.\n")
}
