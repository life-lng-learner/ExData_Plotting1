library(lubridate)

##Read in the power data file
datafile<-"./exdata_data_household_power_consumption/household_power_consumption.txt"
powerdata<-read.table(datafile,header=TRUE,sep=";",na.strings = "?")

##Subset the data for dates 1/2/2007 and 2/2/2007
subsetdata<-subset(powerdata,powerdata$Date=="1/2/2007" | powerdata$Date=="2/2/2007")

##Convert Date and Time objects
subsetdata$Date<-as.Date(subsetdata$Date,format="%d/%m/%Y")
subsetdata$Time<-substr(strptime(subsetdata$Time,format="%H:%M:%S"),12,19)

#Combine the date and time and convert to number of seconds since Jan 1, 1970
subsetdata$datetime<-as.POSIXct(paste(subsetdata$Date,subsetdata$Time))

##Open a PNG file
png("plot3.png",width=480,height = 480)

#Plot (with lines) the datetime variable on the x-axis and Sub_metering_1 on the y-axis
plot(subsetdata$datetime,subsetdata$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
#Add Sub_metering_2 lines in red color
lines(subsetdata$datetime,subsetdata$Sub_metering_2,type="l",col="Red")
#Add Sub_metering_2 lines in blue color
lines(subsetdata$datetime,subsetdata$Sub_metering_3,type="l",col="Blue")
#Add legend to the top right
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty="solid",col=c("Black","Red","Blue"))

##Close the PNG file
dev.off()