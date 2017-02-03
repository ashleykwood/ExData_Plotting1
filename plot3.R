#This file, plot3.R, will load the "Individual household electric power consumption Data set" from UCI Machine Learning Repository (only dates Feb 1-2, 2007). This dataset will be used to create a graph of sub-metering 1, 2, and 3 vs time. The plot is then saved to a png file, plot3.png.

#create data table (only reading in rows with desired dates)

edata <- read.table("household_power_consumption.txt", sep = ";",skip = 66637, nrows = 2880, colClasses = c( "factor", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


#need to read in column names

edata.cols <- as.character( read.table( "household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = F))
names( edata ) <- edata.cols


#combine "Date" and "Time" columns, and change them to class POSIXct

edata <- mutate(edata, dt = paste( Date, Time))
edata$dt <- as.POSIXct(edata$dt, format = "%d/%m/%Y %H:%M:%S")
edata <- data.frame(Date = edata$dt, edata[,3:9])


#create line graph of sub-metering 1, 2, and 3 vs. date with y-label and legend

with(edata, plot(Date, Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering"))
legend(30,1000, legend = names(edata)[6:8], col = c("black", "red", "blue"), lty = 1, cex = 0.6)
with(edata, lines(Date, Sub_metering_1))
with(edata, lines(Date, Sub_metering_2, col = "red"))
with(edata, lines(Date, Sub_metering_3, col = "blue"))


#print to png

dev.print(png, "plot3.png", width = 480, height = 480, units = "px")
