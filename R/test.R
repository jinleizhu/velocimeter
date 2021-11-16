#' A test function to calculate terminal velocity
#'
#' Testing the function to calculate terminal velocity with a physical model for free fall with air resistance
#'
#'
#'
#' @param file A .txt file containing pixel coordinates extracted from videos by imageJ.
#' Here default to a file of a falling seed in Agrimonia eupatoria
#'
#' @return A list of estimated Vt using the linear and mechanistic models, data used to fit the models, intercept, R-squared values
#' @export
#'
#' @examples
calculate.terminal.velocity.test <- function(file= "./inst/extdata/agri-short_00000.aviResults.txt"){
  return(calculate.terminal.velocity.phys(file = file,
                                          min.size = 10,min.circularity = 0.05,fps = 130,tubelength = 1.075))
}
