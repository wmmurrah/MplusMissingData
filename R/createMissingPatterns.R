# Create eclsk files with missing data with two mechanisms of missingness

load(file="data/eclsk.Rdata")



# Simulate MCAR -----------------------------------------------------------

library(simFrame)
set.seed(1234)


nc <- NAControl(target=c("age","faminc","fatlths","motlths","mombage",
                         "fmotor","gmotor","t2learn","c1read","c1math","c1genk",
                         "c7read","c7math","c7sci"),
                NArate=c(0.03,                # age
                         0.50,                # faminc
                         0.19,                # father education
                         0.015,               # mother education
                         0.05,0.05,0.05,0.05, # mom birth age, motor, t2learn
                         0.10,0.10,0.10,      # k achievement
                         0.55,0.55,0.55))     # 8th achievement 

mcar50.setup <- setup(x=ecls.comp,size=c(50),k=1)
mcar50 <- draw(x=ecls.comp,setup=mcar50.setup)
mcar50 <- setNA(mcar50,nc)

mcar150.setup <- setup(x=ecls.comp,size=c(150),k=1)
mcar150 <- draw(x=ecls.comp,setup=mcar150.setup)
mcar150 <- setNA(mcar150,nc)

mcar1500.setup <- setup(x=ecls.comp,size=c(1500),k=1)
mcar1500 <- draw(x=ecls.comp,setup=mcar1500.setup)
mcar1500 <- setNA(mcar1500,nc)


    




results <- runSimulation(ecls.comp,NAControl=na,fun=srs)

sim <- function(x, orig) {
  i <- apply(x, 1, function(x) any(is.na(x)))
  ni <- length(which(i))
  xKNNa <- impKNNa(x)$xImp
  xLS <- impCoda(x, method = "lm")$xImp
  c(knn = aDist(xKNNa, orig)/ni, LS = aDist(xLS, orig)/ni)
}
  