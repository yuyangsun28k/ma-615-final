library(ggplot2)
gdp <- read.csv(file = "gdp.csv")
library(ggplot2)
library(dplyr)

# Assuming 'gdp' is your data frame
# Filter the data for each item
item1_data <- gdp %>% filter(Item == "Final consumption expenditure")
item2_data <- gdp %>% filter(Item == "Household consumption expenditure (including Non-profit institutions serving households)")
item3_data <- gdp %>% filter(Item == "General government final consumption expenditure")
item4_data <- gdp %>% filter(Item == "Gross capital formation")
item5_data <- gdp %>% filter(Item == "Gross fixed capital formation (including Acquisitions less disposals of valuables)")
item6_data <- gdp %>% filter(Item == "Changes in inventories")
item7_data <- gdp %>% filter(Item == "Exports of goods and services")

# Create individual plots for each item
plot1 <- ggplot(data = item1_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Final consumption expenditure", x = "Year", y = "Value")

plot2 <- ggplot(data = item2_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Household consumption expenditure", x = "Year", y = "Value")

plot3 <- ggplot(data = item3_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "General government final consumption expenditure", x = "Year", y = "Value")

plot4 <- ggplot(data = item4_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Gross capital formation", x = "Year", y = "Value")

plot5 <- ggplot(data = item5_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Gross fixed capital formation", x = "Year", y = "Value")

plot6 <- ggplot(data = item6_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Changes in inventories", x = "Year", y = "Value")

plot7 <- ggplot(data = item7_data, aes(x = Year, y = Value)) +
  geom_bar(stat = "identity") +
  labs(title = "Exports of goods and services", x = "Year", y = "Value")

# Store the plots in a list
plot_list <- list(plot1, plot2, plot3, plot4, plot5, plot6, plot7)

# Adjust the height and width of all plots in the list
adjusted_plots <- lapply(plots, function(plot) {
  plot_height <- 5  # Adjust this value to your desired height in inches
  plot_width <- 8   # Adjust this value to your desired width in inches
  
  # Modify the plot with adjusted height and width
  plots <- plot_list + theme(
    plot.margin = unit(c(1, 1, plot_height, plot_width), "inches")
  )
  
  return(plots)
})