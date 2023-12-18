library(dplyr)

# Read the data frames
infant <- read.csv("data/infant_mortality_rate_thousands.csv")
under5 <- read.csv("data/under5_mortality_rate_thousands.csv")

# Add a new column to identify the source of each row
infant$Source <- "infant"
under5$Source <- "under Age 5"

# Combine the data frames row-wise
combined_data <- rbind(infant, under5)
combined_data <- na.omit(combined_data)

# Create a plot using the combined data
mob <- ggplot(combined_data, aes(x = Year.s., y = Value, color = Source)) +
  geom_line() +
  labs(title = "Mortality Rate in Thousands",
       x = "Year(s)", y = "Age") +
  scale_color_manual(values = c("infant" = "red", "under Age 5" = "blue"))
