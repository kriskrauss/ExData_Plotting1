library(data.table)

## Read data using data.table; much faster
DT<-fread('household_power_consumption.txt',header=TRUE,sep=";",na.strings="?")

## subset to only what we want
DT2<-data.table(DT[(DT$Date=="1/2/2007" | DT$Date=="2/2/2007")])

## Create a datetime column combining date and time
DT2[,DateTime:=as.POSIXct(strptime(paste(Date,Time,sep=","),"%d/%m/%Y,%H:%M:%S"))]


## create a png file
png("plot3.png", width=480, height=480)

## plot Sub_metering_1 against DateTime
plot(DT2$DateTime, DT2$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")

## now draw lines for Sub_metering_2 and Sub_metering_3
lines(DT3$DateTime, DT3$Sub_metering_2, col="red", type="l")
lines(DT3$DateTime, DT3$Sub_metering_3, col="blue", type="l")

# add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"))

## remember to close the device
dev.off()
