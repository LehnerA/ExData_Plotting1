# read downloaded data to data table
temp.file <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp.file)
data <- read.table(unz(temp.file, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = c("?"),
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
unlink(temp.file)

# extract only 1st and 2nd February 2007
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# combine date and time an write it to new column
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# plot data to png
Sys.setlocale("LC_TIME", "English") # change to english week days
png("plot3.png", width = 480, height = 480)

plot(data$DateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()