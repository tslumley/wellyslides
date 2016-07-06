#wers analysis

wers<-read.csv("~/MBIECOURSE/wers.csv") #or file.choose()
head(wers)

# a coding infelicity
table(wers$nempsize)
wers$nemployees<-with(wers,factor(as.character(nempsize), levels=levels(nempsize)[c(1,4,5,2,3,6)]))
table(wers$nemployees,wers$nempsize)

# (a)
library(survey)
wers_design<-svydesign(id=~1, strata=~strata, weights=~grosswt,data=wers)
wers_fpc<-svydesign(id=~1, strata=~strata, weights=~grosswt,data=wers, fpc=~sampfrac)

wers_design
wers_fpc

#(b)

svymean(~female, wers_design, na.rm=TRUE)
svymean(~female, wers_fpc, na.rm=TRUE)

svyquantile(~female, wers_design,quantiles=0.5,ci=TRUE, na.rm=TRUE)

mean(wers$female,na.rm=TRUE)
median(wers$female,na.rm=TRUE)

#(c)
?svyttest
svyttest(female~eo,design=wers_design,na.rm=TRUE)

#(d)
eo_by_size<-svytable(~eo+nemployees,design=wers_design,round=TRUE)
barplot(eo_by_size)
plot(eo_by_size
summary(eo_by_size)

#(e)

svyby(~female+ethnic,~nemployees,svymean,design=wers_design,na.rm=TRUE)
