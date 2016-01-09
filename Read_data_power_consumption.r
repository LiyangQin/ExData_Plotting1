
load_powerdata <- function() {
  
  library(data.table)
  
  file_name  <- "household_power_consumption.txt"
  
  # Read file into a datatable
  power_consum_data <- fread(file_name, header=TRUE, sep=";", colClasses="character",  na="?")
  
  # The dataset has 2,075,259 rows and 9 columns: 
  # We will only be using data from the dates 2007-02-01 and 2007-02-02. 
  #  subsetting those dates.
  selected1 <- subset(power_consum_data, Date=='2/1/2007')
  selected2 <- subset(power_consum_data, Date=='2/2/2007')
  power_consum_selected <- rbind(selected1,selected2)
  power_consum_selected$DateTime <- paste0(power_consum_selected$Date,"-",power_consum_selected$Time)
  
  # convert the Date and Time variables to Date/Time
  power_consum_selected$Date <- as.Date(power_consum_selected$Date, format="%m/%d/%Y")
  DateTime_Format <- "%m/%d/%Y-%H:%M:%S"
  power_consum_selected$DateTime <- strptime(power_consum_selected$DateTime, format=DateTime_Format)
  
  str(power_consum_selected)
  
}