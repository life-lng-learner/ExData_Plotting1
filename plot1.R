##Read in the power data file
datafile<-"./exdata_data_household_power_consumption/household_power_consumption.txt"
powerdata<-read.table(datafile,header=TRUE,sep=";",na.strings = "?")

##Subset the data for dates 1/2/2007 and 2/2/2007
subsetdata<-subset(powerdata,powerdata$Date=="1/2/2007" | powerdata$Date=="2/2/2007")

##Convert Date and Time objects
subsetdata$Date<-as.Date(subsetdata$Date,format="%d/%m/%Y")
subsetdata$Time<-substr(strptime(subsetdata$Time,format="%H:%M:%S"),12,19)

##Open a PNG file
png("plot1.png",width=480,height = 480)

##Create histogram for Global Active Power
hist(as.numeric(as.character(subsetdata$Global_active_power)),main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

##Close the PNG file
dev.off()