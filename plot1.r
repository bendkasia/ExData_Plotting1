td <- tempdir()
tf <- tempfile(tmpdir=td,fileext=".zip")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, tf)
dateDownloaded <- date()
powerdata<-unzip(tf)
powerdata2<-read.table(powerdata,skip=66638,nrows=2879,sep=";",na.strings="?",col.names=c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))
powerdata2$date<-as.Date(powerdata2$date,format="%d/%m/%Y")
powerdata2$datetime<-as.POSIXct(paste(powerdata2$date,powerdata2$time),format="%Y-%m-%d %H:%M:%S")
plot1<-hist(powerdata2$global_active_power,breaks=12,main = "Global Active Power",col = "red",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width = 480, height = 480, units = "px")
dev.off()
