#This file, plot1.R, will load the "Individual household electric power consumption Data set" from UCI Machine Learning Repository (only dates Feb 1-2, 2007). This dataset will be used to create a histogram of household global minute-active (kilowatts). The plot is then saved to a png file, plot1.png.

#create data table (only reading in rows with desired dates)

edata <- read.table("household_power_consumption.txt", sep = ";",skip = 66637, nrows = 2880, colClasses = c( "factor", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


#need to read in column names

edata.cols <- as.character( read.table( "household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = F))
names( edata ) <- edata.cols


#create histogram of global active power with x-label and title

hist(edata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")


#print to png

dev.print(png, "plot1.png", width = 480, height = 480, units = "px")


