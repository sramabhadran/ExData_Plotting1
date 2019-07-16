## This is plot4.R. The objective of this script is to read in the power consumption data,
## produce 4 pre-specified plots in a 2 x 2 display format, and store them in a single file called plot4.png


## Read in all the data (yes, my computer can handle it)
mydatatypes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", colClasses = mydatatypes, stringsAsFactors = FALSE)


## Subset by dates to only include February 1st and 2nd from 2007
## Note: Dataset format has days before months
targetdates <- c("1/2/2007", "2/2/2007")
subdata <- subset(data, Date %in% targetdates)

## Format dates as necessary  - remember days before months

subdata$Date <- as.Date(subdata$Date, "%d/%m/%Y")
subdata_dt <- strptime(paste(subdata$Date, subdata$Time), "%Y-%m-%d %H: %M: %S")

## Produce the plot
png("plot4.png", width = 480, height = 480)

## set up a 2 X 2 grid
par(mfrow = c(2,2))

## 1st - Plot 2 Display
plot(subdata_dt, subdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
axis(side = 1, at = c(0,2,4,6))
    
## 2nd - Like Plot 2 but  with Voltage instead of Global_active_power, and "datetime" x-axis label
plot(subdata_dt, subdata$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = c(0,2,4,6))

## 3rd - Plot 3 Display
plot(subdata_dt, subdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(subdata_dt, subdata$Sub_metering_2, col="red", type="l", lty=1)
lines(subdata_dt, subdata$Sub_metering_3, col="purple", type="l", lty=1)
legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "purple"), lty=1 )

## 4th - Like Plot 2 but with Global_reactive_power instead of Global_active_power, and "datetime" x-axis label
plot(subdata_dt, subdata$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
axis(side = 1, at = c(0,2,4,6))

dev.off()


