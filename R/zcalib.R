#' Conversion function for real z coordinates of a falling object in 3-d space
#'
#' The function converts the image coordinates (z coordinates in the drect view and
#' z coordinates in the mirror view) to real z coordinates in 3-d space
#'
#' @param dat A dataframe containing the image coordinates (zd, zm) and the real z coordinates (z.m)
#'
#' @return Summary result of the fitted linear regression model.
#' @export
#'
#' @examples
#' datz <- read.csv(file = paste0(system.file(package = "velocimeter"),"/extdata/datz.csv"),header = TRUE)
#' zcalib(dat=datz)
zcalib <- function(dat){
  zcalib <- lm(z.m~zm*zd,data = dat)
  return(summary(zcalib))
}
