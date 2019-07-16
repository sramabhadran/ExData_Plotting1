## This is plot3.R. The objective of this script is to read in the power consumption data,
## produce the plot showing the layered sub-metering data, and store it in a file called plot3.png


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
png("plot3.png", width = 480, height = 480)
plot(subdata_dt, subdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(subdata_dt, subdata$Sub_metering_2, col="red", type="l", lty=1)
lines(subdata_dt, subdata$Sub_metering_3, col="purple", type="l", lty=1)
legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "purple"), lty=1 )

dev.off()


