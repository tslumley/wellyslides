# Roughly how many tourists are driving?

ivs<-read.csv("~/MBIECOURSE/ivs/vw_IVSSurveyMainHeader.csv")

divs<-svydesign(id=~PSU, weights=~PopulationWeight,data=ivs)

svymean(~LengthOfStay,divs,na.rm=TRUE)
svyquantile(~LengthOfStay, quantiles=c(.1,.25,.5,.75,.9),divs,na.rm=TRUE)

transport<-read.csv("~/MBIECOURSE/ivs/vw_IVSTransport.csv")

transport$is_rental<-with(transport, TransportMethod %in% c("Rental car","Rental campervan / motor-home"))
transport<-transport[order(-1*transport$is_rental),]
transport<-transport[!duplicated(transport$SurveyResponseID),]

ivs<-merge(transport,ivs,all.x=TRUE,by="SurveyResponseID")

divs<-svydesign(id=~PSU, weights=~PopulationWeight,data=ivs)

svymean(~LengthOfStay,divs,na.rm=TRUE)
svyquantile(~LengthOfStay, quantiles=c(.1,.25,.5,.75,.9),divs,na.rm=TRUE)

svyby(~LengthOfStay,~is_rental,svymean,design=divs,na.rm=TRUE)
svyby(~LengthOfStay,~is_rental,svyquantile,design=divs,na.rm=TRUE,quantiles=0.75,ci=TRUE,se=TRUE)
svyby(~LengthOfStay,~is_rental,svyquantile,design=divs,na.rm=TRUE,quantiles=0.9,ci=TRUE,se=TRUE)
svymean(~is_rental,design=divs,na.rm=TRUE)

svyby(~LengthOfStay,~is_rental+Qtr,svymean,design=divs,na.rm=TRUE)

plot(it<-coef(svyby(~LengthOfStay,~is_rental+Qtr,svymean,design=divs,na.rm=TRUE)),col=c("blue","orange"),pch=19)
plot(rep(1:8, length=154),it,col=c("blue","orange"),pch=19,ylim=c(0,30))


## money?
divs<-update(divs, actualqtr= as.numeric(Qtr) %% 4)
svyby(~WeightedSpend,~is_rental+actualqtr,svymean,design=divs,na.rm=TRUE)

