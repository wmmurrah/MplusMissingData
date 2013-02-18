# Create eclsk files with missing data with two mechanisms of missingness

load(file="data/eclsk.Rdata")



# Simulate MCAR -----------------------------------------------------------

library(simFrame)
set.seed(1234)

setup(x=ecls.comp,)

na <- NAControl(NArate=.05)


sim <- function(x, orig) {
  i <- apply(x, 1, function(x) any(is.na(x)))
  ni <- length(which(i))
  xKNNa <- impKNNa(x)$xImp
  xLS <- impCoda(x, method = "lm")$xImp
  c(knn = aDist(xKNNa, orig)/ni, LS = aDist(xLS, orig)/ni)
  