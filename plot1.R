##################### Reading data

#reading header
header <- read.csv("household_power_consumption.txt",sep=";", nrows=1, header=FALSE)
#reading data
data <- read.csv("household_power_consumption.txt",sep=";",header=FALSE, skip=66637,nrows=2880)
#putting labels and data together
colnames( data ) <- unlist(header) #tip taken from this stackoverflow.com answer: http://stackoverflow.com/a/23544256/334681
#converting dates
library(dplyr)
dateTimeStr <- mutate(data, DateTime = paste(as.character(Date),as.character(Time), sep=" "))$DateTime
data$DateTime <- strptime(dateTimeStr, format="%d/%m/%Y %H:%M:%S")
data <- select(data, c(10, 3:9))


##################### Setting environment up
par(mfrow=c(1,1))



##################### Making Plot

png("plot1.png",width=480,height=480)
par(bg = NA)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col = "red", main = "Global Active Power")


##################### Saving File
dev.off()
