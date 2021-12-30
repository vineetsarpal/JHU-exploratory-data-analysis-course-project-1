library(tidyverse)
library(lubridate)

## Initial Common Steps
# Read file
df_hpc <- read.csv2("./data/household_power_consumption.txt")

# Convert Date to Date-type format
df_hpc <- df_hpc %>% 
    mutate(Date = dmy(Date))

# Sub-setting required data
df_hpc <- df_hpc %>% 
    subset(Date >= "2007-02-01" & Date <= "2007-02-02")

# =============================================================

## Plot 4
# Convert data-type for necessary data
datetime <- strptime(paste(df_hpc$Date, df_hpc$Time), format = "%Y-%m-%d %H:%M:%S")
df_hpc$Global_active_power <- as.numeric(df_hpc$Global_active_power)
df_hpc$Voltage <- as.numeric(df_hpc$Voltage)
df_hpc$Sub_metering_1 <- as.numeric(df_hpc$Sub_metering_1)
df_hpc$Sub_metering_2 <- as.numeric(df_hpc$Sub_metering_2)
df_hpc$Sub_metering_3 <- as.numeric(df_hpc$Sub_metering_3)
df_hpc$Global_reactive_power <- as.numeric(df_hpc$Global_reactive_power)

# Setting up device
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# plot (1,1)
plot(datetime, df_hpc$Global_active_power, type="l", xlab = "", ylab="Global Active Power")

# plot (1,2)
plot(datetime, df_hpc$Voltage, type="l", ylab="Voltage")

# plot (2,1)
plot(datetime, df_hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(datetime, df_hpc$Sub_metering_1)
lines(datetime, df_hpc$Sub_metering_2, col = "red")
lines(datetime, df_hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

# plot (2,2)
with(df_hpc, plot(datetime, Global_reactive_power, type="l"))

# Switch off current graphics device
dev.off()
