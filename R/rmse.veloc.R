#' A diagnostic function for measurements of terminal velocity
#'
#' To calculate the root-mean-square error (RMSE) of differences between observed and predicted velocity between successive images
#'
#' @param obj The R object "vtobj.Rdata" produced by the script to calculate terminal velocity from .txt files
#'
#' @return Result summary of the RMSE of differences between observed and predicted velocity between successive images
#' @export
#'
#' @examples
#' library(velocimeter)
#' load(file = paste0(.libPaths()[which("velocimeter"%in%list.files(.libPaths()))],"/velocimeter/extdata/vtobj.Rdata"))
#' rmse.veloc(obj = vtobj[[1]])
rmse.veloc <- function(obj) {
  sqrt(mean(((diff(fitted(obj$physfit))-diff(obj$imagedat$z))/diff(obj$imagedat$t))^2))
}
