#' install.packages("devtools")
#' devtools::install_github("klutometis/roxygen")
library(devtools)
library(roxygen2)

document("eval.save")
system("R CMD INSTALL eval.save")
reload(inst("eval.save"))

setwd("eval.save")
library(knitr)
knit("README.rmd", "README.md")
