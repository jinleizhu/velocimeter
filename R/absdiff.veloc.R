#' A diagnostic function for measurements of terminal velocity
#'
#' To calculate absolute differences between observed and predicted velocity between successive images
#'
#' @param obj The R object "vtobj.Rdata" produced by the script to calculate terminal velocity from .txt files
#'
#' @return Result summary of the absolute differences between observed and predicted velocity between successive images
#' @export
#'
#' @examples
#' library(velocimeter)
#' load(file = paste0(.libPaths()[which("velocimeter"%in%list.files(.libPaths()))],"/velocimeter/extdata/vtobj.Rdata"))
#' absdiff.veloc(obj = vtobj[[1]])

absdiff.veloc <- function(obj) {
  x <- obj$imagedat$t[-1]
  y <- abs(diff(fitted(obj$physfit))-diff(obj$imagedat$z))
  plot(x,y,
       type="b",
       xlab="Time (s)",
       ylab="Velocity difference (m/s)")
  summary(abs(diff(fitted(obj$physfit))-diff(obj$imagedat$z))/diff(obj$imagedat$t))
}
