# R code for generating missing data 
#  Simulate Data for Examples
N<-2000;
x1<-rbinom(N,1,prob=.4)  #draw from a binomial dist with probability=.4
x2<-rnorm(N,0,1)         #draw from a normal dist with mean=0, sd=1
x3<-rnorm(N,-10,1)
y<--1+1*x1-1*x2+1*x3+rnorm(N,0,1)  #simulate linear regression data with a normal error (sd=1)

comp2000 <- as.data.frame(cbind(x1,x2,x3,y))

lin.res<-lm(y~x1+x2+x3)  #Do a quick linear regression
summary(lin.res)   #check the results to make sure the simulation worked

#Generate MCAR data
alpha.1=.2          #probability X1 is missing
alpha.2=.25         #probability X2 is missing
alpha.3=.3          #probability X3 is missing

r.x1.mcar<-rbinom(N,1,prob=alpha.1) #yes/no for whether x1 is missing
r.x2.mcar<-rbinom(N,1,prob=alpha.2)
r.x3.mcar<-rbinom(N,1,prob=alpha.3)
x1.mcar<-x1*(1-r.x1.mcar)+r.x1.mcar*99999  #x1.mcar=x1 if not missing, 99999 if missing
x2.mcar<-x2*(1-r.x2.mcar)+r.x2.mcar*99999
x3.mcar<-x3*(1-r.x3.mcar)+r.x3.mcar*99999
x1.mcar[x1.mcar==99999]=NA                  #change 99999 to NA (R's notation for missing)
x2.mcar[x2.mcar==99999]=NA
x3.mcar[x3.mcar==99999]=NA
lin.res.mcar<-lm(y~x1.mcar+x2.mcar+x3.mcar)    #Linear regression under mcar
summary(lin.res.mcar)

mcar2000 <- as.data.frame(cbind(x1.mcar,x2.mcar,x3.mcar,y))


#Generate MAR data
alpha.1<-exp(16+2*y-x2)/(1+exp(16+2*y-x2));
alpha.2<-exp(3.5+.7*y)/(1+exp(3.5+.7*y));
alpha.3<-exp(-13-1.2*y-x1)/(1+exp(-13-1.2*y-x1));


r.x1.mar<-rbinom(N,1,prob=alpha.1)
r.x2.mar<-rbinom(N,1,prob=alpha.2)
r.x3.mar<-rbinom(N,1,prob=alpha.3)
x1.mar<-x1*(1-r.x1.mar)+r.x1.mar*99999  #x1.mar=x1 if not missing, 99999 if missing
x2.mar<-x2*(1-r.x2.mar)+r.x2.mar*99999
x3.mar<-x3*(1-r.x3.mar)+r.x3.mar*99999
x1.mar[x1.mar==99999]=NA                  #change 99999 to NA (R's notation for missing)
x2.mar[x2.mar==99999]=NA
x3.mar[x3.mar==99999]=NA
lin.res.mar<-lm(y~x1.mar+x2.mar+x3.mar)    #Linear regression under mcar
summary(lin.res.mar)

mar2000 <- as.data.frame(cbind(x1.mar,x2.mar,x3.mar,y))

save(comp2000,file="data/R/comp2000.Rdata")
save(mcar2000,file="data/R/mcar2000.Rdata")
save(mar2000, file="data/R/mar2000.Rdata")

write.csv(comp2000,file="data/csv/comp2000.csv")
write.csv(mcar2000,file="data/csv/mcar2000.csv")
write.csv(mar2000,file="data/csv/mar2000.csv")