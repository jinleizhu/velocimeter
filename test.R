# install package
install.packages("devtools")
library(devtools)
install_github("jinleizhu/velocimeter")
# test
library(velocimeter)
calculate.terminal.velocity.phys(file = "terminal_velocity_analysis20219191543/agri-short_00000.aviResults.txt",
                                 min.size = 10,min.circularity = 0.05,fps = 130,tubelength = 1.075)
