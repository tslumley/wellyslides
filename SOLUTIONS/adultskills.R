sas<-read.csv("~/MBIECOURSE/ADULTSKILLS/prgnzlp1.csv")
grep("WT",names(sas),value=TRUE)

rwt<-grep("WT[1-9]",names(sas))
image(as.matrix(sas[,rwt]))

dsas<-svrepdesign(repweights="WT[1-9]",weights=~SPFWT0,data=sas,type="JK1")

svymean(~factor(ISIC1L),design=dsas,na.rm=TRUE)

svymean(~as.numeric(as.character(EARNHR)),design=dsas,na.rm=TRUE)

dsas<-update(dsas, earnhr=as.numeric(as.character(EARNHR)))

svyhist(~earnhr,subset(dsas,earnhr<200),breaks=30)

mn <- svymean(~earnhr,subset(dsas,earnhr<200),na.rm=TRUE,return.replicates=TRUE)

mnsilly<-svymean(~earnhr,dsas,na.rm=TRUE,return.replicates=TRUE)
mnsilly$replicates

svyby(~earnhr,~ISIC1L,design=dsas,svymean,na.rm=TRUE)


dsas<-update(dsas,planning=as.numeric(as.character(PLANNING)))

svymean(~planning,dsas,na.rm=TRUE)

svyplot(earnhr~planning,subset(dsas,earnhr<200),style="hex")