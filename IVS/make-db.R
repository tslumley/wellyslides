
alltables<-list.files(pattern="csv")
allnames<-sub("vw_IVS(.+)\\.csv$","\\1",alltables)
allnames<-gsub("[^a-zA-z]+","_",allnames)

library(RSQLite)
sqlite<-dbDriver("SQLite")
ivs<-dbConnect(sqlite,"ivs.db")
for(i in 1:length(alltables)){
	df<-read.csv(alltables[i])
	dbWriteTable(ivs,allnames[i],df)
	print(allnames[i])
}

