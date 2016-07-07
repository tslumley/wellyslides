frs<-read.csv("~/MBIECOURSE/frs.csv")

dfrs<-svydesign(id=~PSU,weights=~GROSS2,data=frs)

## it has already been raked, so the estimated totals *ARE* the population totals

ctband.totals<-svytotal(~factor(CTBAND),dfrs)
tenure.totals<-svytotal(~factor(TENURE),dfrs)

calfrs<-calibrate(dfrs, formula=~factor(CTBAND)+factor(TENURE), pop=c(`(Intercept)`= 2236979,coef(ctband.totals)[-1],coef(tenure.totals)[-1]))

svytotal(~factor(CTBAND),dfrs)
svytotal(~factor(CTBAND),calfrs)  ##zero, now R knows it is calibrated

svymean(~HHINC,calfrs,na.rm=TRUE)
svymean(~HHINC,dfrs,na.rm=TRUE)

svyboxplot(HHINC~ factor(DEPCHLDH),design=calfrs)
svyboxplot(HHINC~ factor(DEPCHLDH),design=calfrs,all.outliers=TRUE)
summary(svyglm(HHINC~factor(DEPCHLDH),design=calfrs))
summary(svyglm(HHINC~factor(DEPCHLDH),design=dfrs))