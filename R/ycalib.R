#' Conversion function for real y coordinates of a falling object in 3-d space
#'
#' The function converts the image coordinates (x coordinates in the drect view and
#' y coordinates in the mirror view) to real y coordinates in 3-d space
#'
#' @param dat A dataframe containing the image coordinates (ym, xd) and the real y coordinates (y.m)
#'
#' @return Summary result of the fitted linear regression model.
#' @export
#'
#' @examples
#' daty <- read.csv(file = paste0(system.file(package = "velocimeter"),"/extdata/daty.csv"),header = TRUE)
#' ycalib(dat=daty)
ycalib <- function(dat){
  ycalib <- lm(y.m~ym*xd,data = dat)
  return(summary(ycalib))
}
