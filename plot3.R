t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                colClasses = c('character','character','numeric','numeric','numeric',
                               'numeric','numeric','numeric','numeric'))


## Format date to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
t <- t[complete.cases(t),]

## Combine Date and Time column
dateTime <- paste(t$Date, t$Time)

## Remove Date and Time column
t <- t[ ,!(names(t) %in% c("Date", "Time"))]

## Add DateTime column
t <- cbind(dateTime, t)

## Format dateTime Column

t$dateTime <- as.POSIXct(dateTime)

# Plot 2
with(t, {
  plot(t$Sub_metering_1 ~ t$dateTime, type="l", ylab = "Energy sub metering", xlab ="")
  lines(t$Sub_metering_2 ~ t$dateTime, col = "red")
  lines(t$Sub_metering_3 ~ t$dateTime, col = "blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()