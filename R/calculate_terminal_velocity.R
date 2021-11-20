#' A function to calculate terminal velocity
#'
#' The function allows one to calculate terminal velocity using a physical model for free fall with air resistance for a large sphere.
#'
#' @param file A .txt file containing pixel coordinates extracted from videos by imageJ
#' @param min.size Minimum size (in pixels) of valid objects
#' @param min.circularity Minimum circularity of valid objects
#' @param fps Frame per second, defaults to 130 in our method
#' @param tubelength 2.095 m,1.575 m, and 1.075 m for long, medium, and short tube, respectively
#'
#' @return A list of estimated Vt using the linear and mechanistic models, data used to fit the models, intercept, R-squared values
#' @export
#'
#' @examples
#' library(velocimeter)
#' # not run
#' # calculate.terminal.velocity.phys(file =
#' # paste0(.libPaths()[which("velocimeter"%in%list.files(.libPaths()))],
#' # "/velocimeter/extdata/agri-short_00000.aviResults.txt"),
#' # min.size = 10,min.circularity = 0.05,fps = 130,tubelength = 1.075)

calculate.terminal.velocity.phys <- function(file,min.size,min.circularity,fps=130,tubelength){
  # load the conversion functions:
  load(paste0(.libPaths()[which("velocimeter"%in%list.files(.libPaths()))],"/velocimeter/extdata/calib.Robj"))
  message<-""
  dt<-1/fps #time interval between images
  dat<-read.table(file=file,header=T)
  # select putative falling objects
  dat<-dat[dat$Circ.>=min.circularity,]
  dat<-dat[dat$Area>=min.size,]
  # further select data based on range limits in the mirror view
  dat<-dat[(dat$XM>200)&(dat$XM<800)|(dat$XM>900&dat$XM<1850),]
  dat<-dat[dat$YM<1000,]
  # select data for direct view
  directdat<-dat[dat$XM>900,]
  # select data for mirror view
  mirrordat<-dat[dat$XM<820,]
  # time values in direct and mirror views
  directtimevals<-unique(directdat$Slice)
  mirrortimevals<-unique(mirrordat$Slice)
  timevals<-directtimevals[directtimevals%in%mirrortimevals]
  #select the longest sequence of consecutive images
  timevals<-sort(timevals)
  time.rle<-rle(diff(timevals))
  time.rle<-data.frame(length=time.rle$length,values=time.rle$values,period=1:length(time.rle$values))
  time.rle$endtime<-1+cumsum(time.rle$length)
  startendtimes<-c(1,time.rle$endtime)
  time.rle1<-time.rle[time.rle$values==1,]
  time.period<-time.rle1$period[which.max(time.rle1$length)]
  period.startend<-startendtimes[c(time.period,time.period+1)]
  timevals<-timevals[period.startend[1]:period.startend[2]]
  if (length(timevals)==0) {
    message<-paste(message,"Error: no data from consecutive images",sep="  ")
    vtfit<-NULL
    vt<-NA
  } else {
    directdat<-directdat[(directdat$Slice%in%timevals),]
    mirrordat<-mirrordat[(mirrordat$Slice%in%timevals),]
    #make sure that there is only a single object in each time step (this works because dat was sorted by decreasing Area)
    if (max(table(directdat$Slice))>1) message<-paste(message,"Warning: more than one object detected in direct image")
    directdat<-directdat[!duplicated(directdat$Slice),]
    if (max(table(mirrordat$Slice))>1) message<-paste(message,"Warning: more than one object detected in mirror image")
    mirrordat<-mirrordat[!duplicated(mirrordat$Slice),]
    # image coordinates of direct view
    names(directdat)[2:3]<-c("xd","zd")
    # image coordinates of mirror view
    names(mirrordat)[2:3]<-c("ym","zm")

    imagedat<-merge(directdat,mirrordat,by="Slice",suffixes=c("",".mirror"))
    if (any(abs(imagedat$yf-imagedat$ym)>250)) {
      message<-paste(message,"Warning: direct and mirror image may not refer to same object",sep="  ")
    }

    # convert the image coordinates to real coordinates in 3-d space
    imagedat$x<-predict(calib$xcalib,imagedat)
    imagedat$y<-predict(calib$ycalib,imagedat)
    imagedat$z<-predict(calib$zcalib,imagedat)
    imagedat$t<-imagedat$Slice*dt

    # (traditional) method 1: simple linear regression model
    linfit<-lm(z~t,imagedat)
    if (summary(linfit)$r.squared<0.999) {
      message<-paste(message,"Warning: seed may not yet have reached terminal velocity",sep="  ")
    }
    vt.lin<- (-coef(linfit)[2])*0.01 # in m/s

    # method 2: calculate vt with the physical model of free fall with air resistance
    # Equation (2.58) from “Classical Mechanics” by John R. Taylor
    z.obs<- -(tubelength-imagedat$z*0.01) # adding the 0/0 point not necessary; all in m now
    ts<-imagedat$t
    dats <- data.frame(t=ts,z.obs=z.obs)
    # fit the physical model for free fall with air resistance:
    physfit <- nls(z.obs ~ z0 - vt^2/9.80665 * log(cosh(9.80665*t/vt)),
                   data=dats,start=list(vt=2,z0=0))
    vt.phys <- coef(physfit)[1]
    z0.phys <- coef(physfit)[2]
    rsq.cond.phys <- (1 - var(residuals(physfit))/var(dats$z.obs))

    if (z0.phys > 0.1) {
      message<-paste("Warning: Z0 10cm or larger",message,sep="  ")
    }
  }
  # save the results
  return(list(vt.lin.mps=vt.lin,message=message,linfit=linfit,physfit=physfit,imagedat=imagedat,vt.phys.mps=vt.phys,z0.phys.m=z0.phys,rsq.cond.phys=rsq.cond.phys))
}
