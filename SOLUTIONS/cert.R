cert<-read.csv("~/MBIECOURSE/certsurvey.csv")

summary(cert)

cert$college<-cert$COLLEGE
cert$college<-match(cert$college,c("M","P"),nomatch=3)
cert$college<-factor(cert$college, labels=c("M","P","O"))
with(cert,table(college,COLLEGE))


# who knows what's up with the non-AGI people
cert<-subset(cert, WORKENV %in% c("A","G","I"))
cert$workenv<-as.factor(as.character(cert$WORKENV))
table(cert$workenv)

college.totals<-18609*c(.38,.55,1-.38-.55)
workenv.totals<-18609*c(workenvA=.34,workenvG=.11,workenvI=.29)/(.34+.11+.29)

library(survey)
rawdesign<-svydesign(id=~1,data=cert)
caldesign<-calibrate(rawdesign, ~college+workenv, pop=c(`(Intercept)`=18609,college.totals[-1],workenv.totals[-1]),calfun="raking")



 svymean(~factor(CERTIFY),design=rawdesign)
  svymean(~factor(CERTIFY),design=caldesign)


 svymean(~factor(WOULDYOU),design=rawdesign)
  svymean(~factor(WOULDYOU),design=caldesign)

svytable(~WOULDYOU+CERTIFY,design=caldesign,round=TRUE)

svytable(~WOULDYOU+workenv,design=caldesign,round=TRUE)
svytable(~WOULDYOU+college,design=caldesign,round=TRUE)

