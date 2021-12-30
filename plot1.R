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

## Plot 1
# Convert data-type for necessary data
df_hpc$Global_active_power <- as.numeric(df_hpc$Global_active_power)

# Plot
png(filename = "plot1.png", width = 480, height = 480)
hist(df_hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
