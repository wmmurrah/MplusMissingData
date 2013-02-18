# prepare data source:

load("~/Dropbox/1_Projects/1_NSF_ScoreGaps/ScienceAchievementClean/data/eclsksa.Rdata")

eclsk <- na.omit(eclsksa)
names(eclsk)
tr.names <- c("t2learn","t2contro","t2interp","t2extern","t2intern")
names(eclsk)[29:33] <- tr.names
save(eclsk,file="data/eclsk.Rdata")

# select subset of variables for base data frame

ecls.comp <- eclsk[,-c(2,3)]

save(ecls.comp,file="data/ecls.comp.Rdata")