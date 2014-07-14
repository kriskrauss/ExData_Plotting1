library(data.table)

## Read data using data.table; much faster
DT<-fread('household_power_consumption.txt',header=TRUE,sep=";",na.strings="?")

## subset to only what we want
DT2<-data.table(DT[(DT$Date=="1/2/2007" | DT$Date=="2/2/2007")])

## Create a datetime column combining date and time
DT2[,DateTime:=as.POSIXct(strptime(paste(Date,Time,sep=","),"%d/%m/%Y,%H:%M:%S"))]


## create a png file
png("plot4.png", width=480, height=480)

## 2 columns in 2 rows for the 4 plots
par(mfrow=c(2,2))

## plot Global_active_power against DateTime for Plot 1
plot(DT2$DateTime, DT2$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## plot Voltage against DateTime for Plot 2
plot(DT2$DateTime, DT2$Voltage, type="l", xlab="datetime", ylab="Voltage")

## plot Sub_metering_1 against DateTime for Plot 3
plot(DT2$DateTime, DT2$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")

## now draw lines for Sub_metering_2 and Sub_metering_3
lines(DT3$DateTime, DT3$Sub_metering_2, col="red", type="l")
lines(DT3$DateTime, DT3$Sub_metering_3, col="blue", type="l")

# add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8, lty=1, col=c("black","red","blue"))

## plot Sub_metering_1 against DateTime for Plot 4
plot(DT2$DateTime, DT2$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## remember to close the device
dev.off()
