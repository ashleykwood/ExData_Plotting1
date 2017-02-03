#This file, plot4.R, will load the "Individual household electric power consumption Data set" from UCI Machine Learning Repository (only dates Feb 1-2, 2007). This dataset will be used to create four sub-plots: i - line graph of global active power vs time (same as plot2), ii - line graph of voltage vs time, iii - line graph of sub-metering 1, 2, and 3 vs time (same as plot3), and iv - line graph of global reactive power vs. time. The plot is then saved to a png file, plot4.png.



#create data table (only reading in rows with desired dates)

edata <- read.table("household_power_consumption.txt", sep = ";",skip = 66637, nrows = 2880, colClasses = c( "factor", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


#need to read in column names

edata.cols <- as.character( read.table( "household_power_consumption.txt", sep = ";", nrows = 1, stringsAsFactors = F))
names( edata ) <- edata.cols


#combine "Date" and "Time" columns, and change them to class POSIXct

edata <- mutate(edata, dt = paste( Date, Time))
edata$dt <- as.POSIXct(edata$dt, format = "%d/%m/%Y %H:%M:%S")
edata <- data.frame(Date = edata$dt, edata[,3:9])

###################################################################

#set plotting parameters

par(mfrow = c(2,2))


#create line graph of global active power vs. time with y-label

with(edata, plot(Date, Global_active_power, type = "n", xlab = NA, ylab = "Global Active Power (kilowatts)")) 
with(edata, lines(Date, Global_active_power))


#create line graph of voltage vs time with x and y labels

with(edata, plot(Date, Voltage, type = "n", xlab = "datetime"))
with(edata, lines(Date, Voltage))


#create line graph of sub-metering 1, 2, and 3 vs. time with y-label and legend

with(edata, plot(Date, Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering"))
legend(30,1000, legend = names(edata)[6:8], col = c("black", "red", "blue"), lty = 1, cex = 0.6)
with(edata, lines(Date, Sub_metering_1))
with(edata, lines(Date, Sub_metering_2, col = "red"))
with(edata, lines(Date, Sub_metering_3, col = "blue"))


#create line graph of global reactive power vs. time with x and y labels

with(edata, plot(Date, Global_reactive_power, type = "n", xlab = "datetime"))
with(edata, lines(Date, Global_reactive_power))


#print to png

dev.print(png, "plot4.png", width = 480, height = 480, units = "px")