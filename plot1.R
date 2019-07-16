## This is plot1.R. The objective of this script is to read in the power consumption data,
## produce the histogram plot showing global active power, and store it in a file called plot1.png

## Pull down the Zip file from the URL below
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## and get everything into a text file called household_power_consumption.txt

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL, destfile = "data.zip")
unzip("data.zip", "household_power_consumption.txt")


## Read in all the data (yes, my computer can handle it)
mydatatypes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
data <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", colClasses = mydatatypes, stringsAsFactors = FALSE)


## Subset by dates to only include February 1st and 2nd from 2007
## Note: Dataset format has days before months
targetdates <- c("1/2/2007", "2/2/2007")
subdata <- subset(data, Date %in% targetdates)

## Format dates as necessary  - remember days before months

subdata$Date <- as.Date(subdata$Date, format = "%d/%m/%Y")

## Produce the plot make the fill color red format the axes 
## to show appropriate labels and tick marks only every other on the x-axis
png("plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", axes = FALSE)
axis(side = 1, at = c(0,2,4,6))
axis(side = 2, at = c(0,200,400,600, 800, 1000, 1200))
dev.off()
