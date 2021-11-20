#' Conversion function for real x coordinates of a falling object in 3-d space
#'
#' The function converts the image coordinates (x coordinates in the drect view and
#' y coordinates in the mirror view) to real x coordinates in 3-d space
#'
#' @param dat A dataframe containing the image coordinates (ym, xd) and the real x coordinates
#'
#' @return Summary result of the fitted linear regression model.
#' @export
#'
#' @examples
#' datx <- read.csv(file = paste0(system.file(package = "velocimeter"),"/extdata/datx.csv"),header = TRUE)
#' xcalib(dat=datx)
xcalib <- function(dat){
  xcalib <- lm(x.m~ym*xd,data = dat)
  return(summary(xcalib))
}
