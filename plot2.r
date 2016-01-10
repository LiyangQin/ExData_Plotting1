library(data.table)
library(lubridate)

file_name  <- "./Coursera/ExploratoryAnalysis/household_power_consumption.txt"

# Read file into a datatable
power_consum_data <- fread(file_name, header=TRUE, sep=";", colClasses="character",  na="?")

# The dataset has 2,075,259 rows and 9 columns: 
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#  subsetting those dates.
selected1 <- subset(power_consum_data, Date=='1/2/2007')
selected2 <- subset(power_consum_data, Date=='2/2/2007')
power_consum_selected <- rbind(selected1,selected2)
power_consum_selected$DateTime <- paste(power_consum_selected$Date,power_consum_selected$Time)

# convert the Date and Time variables to Date/Time

power_consum_selected$DateTime<-dmy(power_consum_selected$Date)+hms(power_consum_selected$Time)
power_consum_selected$Date <- as.Date(power_consum_selected$Date, format="%d/%m/%Y")

# convert other numeric data
power_consum_selected$Global_active_power <- as.numeric(power_consum_selected$Global_active_power)
power_consum_selected$Global_reactive_power <- as.numeric(power_consum_selected$Global_reactive_power)
power_consum_selected$Voltage <- as.numeric(power_consum_selected$Voltage)
power_consum_selected$Global_intensity <- as.numeric(power_consum_selected$Global_intensity)
power_consum_selected$Sub_metering_1 <- as.numeric(power_consum_selected$Sub_metering_1)
power_consum_selected$Sub_metering_2 <- as.numeric(power_consum_selected$Sub_metering_2)
power_consum_selected$Sub_metering_3 <- as.numeric(power_consum_selected$Sub_metering_3)
# write tidy data to file power_consumption20070201.txt
write.table(power_consum_selected,file='power_consumption20070201.txt',sep=';',row.names=FALSE)

# Plot part
png(filename='./Coursera/ExploratoryAnalysis/ExData_Plotting1/plot2.png',width=480,height=480,units='px')
plot(power_consum_selected$DateTime,power_consum_selected$Global_active_power,ylab='Global Active Power (kilowatts)',xlab="",type="l")

# Close off graphic device
dev.off()
