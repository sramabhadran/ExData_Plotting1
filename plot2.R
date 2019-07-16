## This is plot2.R. The objective of this script is to read in the power consumption data,
## produce the line plot showing global active power over time, and store it in a file called plot2.png



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
png("plot2.png", width = 480, height = 480)
plot(subdata_dt, subdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(side = 1, at = c(0,2,4,6))
dev.off()
