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
#plot3
#we first transform to numeric the sub_metering variables
power_subset$Sub_metering_1<- as.numeric(as.character(power_subset$Sub_metering_1))
power_subset$Sub_metering_2<- as.numeric(as.character(power_subset$Sub_metering_2))
names(power_subset)[7:9]
energy_submetering<- select(power_subset, Sub_metering_1:Sub_metering_3)
plot3<- ggplot(power_subset, aes(x=power_datetime, y=Sub_metering_1)) + geom_line() + xlab("") + ylab("Energy sub Metering") + geom_line(aes(y=power_subset$Sub_metering_2), colour="red") + geom_line(aes(y=power_subset$Sub_metering_3), colour="blue")+ scale_x_datetime(date_labels = "%a") + theme_classic() 
plot3
dev.copy(device = png, filename = 'plot3.png', width = 480, height = 480) 
dev.off()