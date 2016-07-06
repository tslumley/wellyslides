combined<-read.csv("~/MBIECOURSE/combined-data.csv")

dnhanes<-svydesign(id=~SDMVPSU, strata=~SDMVSTRA,weights=~fouryearwt,data=combined)

combined<-subset(combined, !is.na(fouryearwt))

dnhanes<-svydesign(id=~SDMVPSU, strata=~SDMVSTRA,weights=~fouryearwt,data=combined)

with(combined,table(SDMVPSU))

dnhanes<-svydesign(id=~SDMVPSU, strata=~SDMVSTRA,weights=~fouryearwt,data=combined,nest=TRUE)
