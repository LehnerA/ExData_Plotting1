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

# plot histogram
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

# save to png
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()