getwd()
#first we open the data frame
unzip("exdata_data_household_power_consumption.zip")
power_consumption<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
#we look for the names of the columns
names(power_consumption)
#we see the format of the observations in the columns Date
head(power_consumption)
#we weill used dplyr to subset the observations made in the 1/2/2007 and 2/2/2007
library(dplyr)
#we can used two forms
power_subset<- filter(power_consumption, Date %in% c("1/2/2007","2/2/2007"))
#we have a new data frame with 2880 obs, we convert the date column with date formart
power_subset$Date<- as.character(power_subset$Date)
power_subset$Time<- as.character(power_subset$Time)
#Now we merge Date and Time so we can convert both to class date
power_datetime<- as.POSIXct(paste(power_subset$Date, power_subset$Time), format= "%d/%m/%Y %H:%M:%S")
class(power_datetime)
#transform to numeric, but we put as character first, so it will not give us the number of the level
power_subset$Global_active_power<- as.numeric(as.character(power_subset$Global_active_power))
#Plot 1
hist(power_subset$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
#we save the plot in a png fie
dev.copy(device = png, filename = 'plot1.png', width = 480, height = 480) 
dev.off()



