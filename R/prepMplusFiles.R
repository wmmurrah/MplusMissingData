# create .dat files and Mplus code for missing data files.
library(MplusAutomation)

# for 
prep <- function(df,file) {
  require(MplusAutomation)
  x <- load(file)
    prepareMplusData(df=df,filename=paste("data/mplus/",x,".dat",sep=""),inpfile=paste("analyses/mplus/",x,".inp",sep=""))
  return(x)
}

prep(comp50,file="data/R/comp50.Rdata")
prep(comp250,file="data/R/comp250.Rdata")
prep(comp2000,file="data/R/comp2000.Rdata")

prep(mcar50,file="data/R/mcar50.Rdata")
prep(mcar250,file="data/R/mcar250.Rdata")
prep(mcar2000,file="data/R/mcar2000.Rdata")

prep(mar50,file="data/R/mar50.Rdata")
prep(mar250,file="data/R/mar250.Rdata")
prep(mar2000,file="data/R/mar2000.Rdata")
# file <- "data/R/comp50.Rdata"