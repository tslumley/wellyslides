shs<-read.csv("~/MBIECOURSE/shs.csv")
head(shs)

dshs<-svydesign(id=~psu,weights=~grosswt,strata=~stratum,data=shs)

byagesex<-svyby(~intuse,~age+sex,svymean, design=dshs,na.rm=TRUE)

m<-svysmooth(intuse~age,design=subset(dshs,sex=="male"))
f<-svysmooth(intuse~age,design=subset(dshs,sex=="female"))
plot(rep(16:80,2),coef(byagesex),pch=c(1,19),ylim=c(0,1),xlab="Age",ylab="Proportion internet users")
lines(m,lty=2)
lines(f,lty=1)