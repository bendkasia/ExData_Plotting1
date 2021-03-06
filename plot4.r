td <- tempdir()
tf <- tempfile(tmpdir=td,fileext=".zip")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, tf)
dateDownloaded <- date()
powerdata<-unzip(tf)
powerdata2<-read.table(powerdata,skip=66638,nrows=2879,sep=";",na.strings="?",col.names=c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))
powerdata2$date<-as.Date(powerdata2$date,format="%d/%m/%Y")
powerdata2$datetime<-as.POSIXct(paste(powerdata2$date,powerdata2$time),format="%Y-%m-%d %H:%M:%S")
par(mfrow=c(2,2))

plot(powerdata2$datetime,powerdata2$global_active_power,xlab="",ylab="Global Active Power",type="l")
plot(powerdata2$datetime,powerdata2$voltage,xlab="datetime",ylab="voltage",type="l")
plot(powerdata2$datetime,powerdata2$sub_metering_1,type="l",xlab="",ylab="Energy sub-metering",ylim=c(0,30))
lines(powerdata2$datetime,powerdata2$sub_metering_2,type="l",col="red")
lines(powerdata2$datetime,powerdata2$sub_metering_3,type="l",col="blue")
legend("top",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
plot(powerdata2$datetime,powerdata2$global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

dev.copy(png,file="plot4.png",width = 480, height = 480, units = "px",res=50)
dev.off()
