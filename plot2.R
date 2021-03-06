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
png("plot2.png",width=480,height = 480)

#Plot (with lines) the datetime variable on the x-axis and global active power on the y-axis
plot(subsetdata$datetime,subsetdata$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

##Close the PNG file
dev.off()