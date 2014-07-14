library(data.table)

## Read data using data.table; much faster
DT<-fread('household_power_consumption.txt',header=TRUE,sep=";",na.strings="?")

## subset to only what we want
DT2<-data.table(DT[(DT$Date=="1/2/2007" | DT$Date=="2/2/2007")])

## Create a datetime column combining date and time
DT2[,DateTime:=as.POSIXct(strptime(paste(Date,Time,sep=","),"%d/%m/%Y,%H:%M:%S"))]

## Convert Global_active_power to be numeric
DT2[,Global_active_power:=as.numeric(Global_active_power)]

## create a png file
png("plot2.png", width=480, height=480)

## plot Global_active_power against DateTime
plot(DT2$DateTime, DT2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## remember to close the device
dev.off()
