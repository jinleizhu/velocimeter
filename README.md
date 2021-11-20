
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

This is a basic example which shows you how to calculate terminal
velocity using the physical model for free fall with air resistance:

``` r
library(velocimeter)
calculate.terminal.velocity.phys(file =
paste0(.libPaths()[which("velocimeter"%in%list.files(.libPaths()))],
"/velocimeter/extdata/agri-short_00000.aviResults.txt"),
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
#>       185.5       -367.9  
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
#> Achieved convergence tolerance: 4.288e-07
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
#>         zm Circ..mirror AR.mirror Round.mirror Solidity.mirror        x
#> 1  155.304        0.483     1.185        0.844           0.802 14.40693
#> 2  227.495        0.328     1.103        0.906           0.793 14.49167
#> 3  300.529        0.222     1.151        0.869           0.700 14.56948
#> 4  375.174        0.247     1.247        0.802           0.740 14.62232
#> 5  450.705        0.215     1.175        0.851           0.729 14.66570
#> 6  527.103        0.258     1.158        0.864           0.694 14.71510
#> 7  605.395        0.218     1.084        0.922           0.729 14.76020
#> 8  684.123        0.231     1.266        0.790           0.656 14.78540
#> 9  764.038        0.166     1.241        0.806           0.667 14.80028
#> 10 844.870        0.190     1.174        0.852           0.712 14.82401
#>           y        z         t
#> 1  11.16985 40.89291 0.3923077
#> 2  11.29645 38.31133 0.4000000
#> 3  11.47061 35.55988 0.4076923
#> 4  11.60386 32.77185 0.4153846
#> 5  11.70218 29.96301 0.4230769
#> 6  11.85851 27.12686 0.4307692
#> 7  12.00176 24.24498 0.4384615
#> 8  12.10445 21.35527 0.4461538
#> 9  12.23554 18.44418 0.4538462
#> 10 12.36264 15.51324 0.4615385
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

# NOTE: When using the function, you should change the path to your .txt files.
```
