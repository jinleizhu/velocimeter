
<!-- README.md is generated from README.Rmd. Please edit that file -->

# velocimeter

<!-- badges: start -->
<!-- badges: end -->

The goal of velocimeter is to calculate terminal velocity using a
physical model for free fall with air resistance.

## Installation

You can install the development version of velocimeter like so:

``` r
# install.packages("devtools")
# library(devtools)
# install_github("jinleizhu/velocimeter")
```

## Example

This is a basic example which shows you how to 1) convert image
coordinates to real coordinates in 3-d space, 2) calculate terminal
velocity using the physical model for free fall with air resistance, and
3) diagnose the measurements of terminal velocity.

``` r
library(velocimeter)
# 1) convert image coordinates to real coordinates in 3-d space
datx <- read.csv(file = paste0(system.file(package = "velocimeter"),"/extdata/datx.csv"),header = TRUE)
xcalib(dat=datx)
#> 
#> Call:
#> lm(formula = x.m ~ ym * xd, data = dat)
#> 
#> Residuals:
#>        Min         1Q     Median         3Q        Max 
#> -0.0027015 -0.0010741 -0.0000806  0.0009415  0.0034503 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -1.656e-01  1.142e-03 -144.98   <2e-16 ***
#> ym          -1.605e-04  2.606e-06  -61.58   <2e-16 ***
#> xd           2.160e-04  8.647e-07  249.86   <2e-16 ***
#> ym:xd        1.726e-07  2.097e-09   82.32   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.001392 on 156 degrees of freedom
#> Multiple R-squared:  0.9996, Adjusted R-squared:  0.9996 
#> F-statistic: 1.377e+05 on 3 and 156 DF,  p-value: < 2.2e-16

# 2) calculate terminal velocity using the physical model for free fall with air resistance
# NOTE: When using the function, you should change the path to your .txt files.
calculate.terminal.velocity.phys(file = paste0(system.file(package = "velocimeter"),"/extdata/agri-short_00000.aviResults.txt"),
min.size = 10,min.circularity = 0.05,fps = 130,tubelength = 1.075)
#> $vt.lin.mps
#>        t 
#> 3.678817 
#> 
#> $message
#> [1] " Warning: more than one object detected in mirror image"
#> 
#> $linfit
#> 
#> Call:
#> lm(formula = z ~ t, data = imagedat)
#> 
#> Coefficients:
#> (Intercept)            t  
#>       1.855       -3.679  
#> 
#> 
#> $physfit
#> Nonlinear regression model
#>   model: z.obs ~ z0 - vt^2/9.80665 * log(cosh(9.80665 * t/vt))
#>    data: dats
#>      vt      z0 
#> 6.42460 0.04759 
#>  residual sum-of-squares: 1.379e-06
#> 
#> Number of iterations to convergence: 6 
#> Achieved convergence tolerance: 5.376e-08
#> 
#> $imagedat
#>    Slice Area       xd      zd Circ.    AR Round Solidity Area.mirror      ym
#> 1     51   71 1327.542   2.627 0.624 2.152 0.465    0.877         388 332.575
#> 2     52  558 1329.828  87.783 0.635 1.801 0.555    0.913         395 335.791
#> 3     53  600 1331.513 188.575 0.645 1.720 0.581    0.900         482 340.351
#> 4     54  618 1332.547 290.335 0.585 1.631 0.613    0.905         519 343.862
#> 5     55  657 1333.471 393.234 0.488 1.606 0.622    0.858         521 346.435
#> 6     56  685 1334.208 498.005 0.540 1.599 0.625    0.875         527 350.597
#> 7     57  696 1334.874 604.154 0.551 1.562 0.640    0.893         525 354.410
#> 8     58  694 1335.086 711.333 0.581 1.579 0.633    0.886         551 357.170
#> 9     59  694 1334.718 819.187 0.583 1.590 0.629    0.898         539 360.760
#> 10    60  697 1334.705 928.236 0.628 1.589 0.629    0.897         532 364.205
#>         zm Circ..mirror AR.mirror Round.mirror Solidity.mirror         x
#> 1  155.304        0.483     1.185        0.844           0.802 0.1440693
#> 2  227.495        0.328     1.103        0.906           0.793 0.1449167
#> 3  300.529        0.222     1.151        0.869           0.700 0.1456948
#> 4  375.174        0.247     1.247        0.802           0.740 0.1462232
#> 5  450.705        0.215     1.175        0.851           0.729 0.1466570
#> 6  527.103        0.258     1.158        0.864           0.694 0.1471510
#> 7  605.395        0.218     1.084        0.922           0.729 0.1476020
#> 8  684.123        0.231     1.266        0.790           0.656 0.1478540
#> 9  764.038        0.166     1.241        0.806           0.667 0.1480028
#> 10 844.870        0.190     1.174        0.852           0.712 0.1482401
#>            y         z         t
#> 1  0.1116985 0.4089291 0.3923077
#> 2  0.1129645 0.3831133 0.4000000
#> 3  0.1147061 0.3555988 0.4076923
#> 4  0.1160386 0.3277185 0.4153846
#> 5  0.1170218 0.2996301 0.4230769
#> 6  0.1185851 0.2712686 0.4307692
#> 7  0.1200176 0.2424498 0.4384615
#> 8  0.1210445 0.2135527 0.4461538
#> 9  0.1223554 0.1844418 0.4538462
#> 10 0.1236264 0.1551324 0.4615385
#> 
#> $vt.phys.mps
#>       vt 
#> 6.424604 
#> 
#> $z0.phys.m
#>         z0 
#> 0.04758519 
#> 
#> $rsq.cond.phys
#> [1] 0.9999791

# 3) diagnose the measurements of terminal velocity:
# NOTE: When using the function, you should change the path to your vtobj.Rdata file.
load(file = paste0(system.file(package = "velocimeter"),"/extdata/vtobj.Rdata"))
absdiff.veloc(obj = vtobj[[1]])
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#> 0.01140 0.01726 0.03467 0.03952 0.06273 0.07818
rmse.veloc(obj = vtobj[[1]])
#> [1] 0.04662084
```
