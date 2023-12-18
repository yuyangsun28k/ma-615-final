library(ggplot2)
library(dplyr)
library(gridExtra)
gdp_b<-read.csv("data/gdp.csv")
gdp_h<-read.csv("data/haiti_gdp.csv")
gni_b<-read.csv("data/GNI_USD.csv")
gni_h<-read.csv("data/haiti_gni.csv")
pop_b<-read.csv("data/total_population_thousands.csv")
pop_h<-read.csv("data/haiti_pop.csv")
infant_b<-read.csv("data/infant_mortality_rate_thousands.csv")
infant_h<-read.csv("data/haiti_infant.csv")
under5_b<-read.csv("data/under5_mortality_rate_thousands.csv")
under5_h<-read.csv("data/haiti_under5.csv")

### gdp
gdp_b <- gdp_b %>% mutate(Country = "Bahamas")
gdp_h <- gdp_h %>% mutate(Country = "Haiti")

# Create bar charts for Bahamas and Haiti
plot_bahamas <- ggplot(gdp_b, aes(x = Year, y = Value, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "GDP Comparison: Bahamas",
       x = "Year", y = "GDP (USD)") +
  scale_fill_manual(values = c("Bahamas" = "blue")) +
  theme_minimal()

plot_haiti <- ggplot(gdp_h, aes(x = Year, y = Value, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "GDP Comparison: Haiti",
       x = "Year", y = "GDP (USD)") +
  scale_fill_manual(values = c("Haiti" = "red")) +
  theme_minimal()

# Set custom height and width for the plots
plot_height <- 5
plot_width <- 8

# Arrange the plots side by side with custom height and width
gdp_bh <- grid.arrange(plot_bahamas, plot_haiti, ncol = 2, heights = c(plot_height, plot_height), widths = c(plot_width, plot_width))

# Display the combined plot
print(gdp_bh)

# Define a function to generate and return the combined GDP plot
generateCombinedGDPPlot <- function() {
  # Arrange the plots side by side with custom height and width
  gdp_bh <- grid.arrange(plot_bahamas, plot_haiti, ncol = 2, heights = c(plot_height, plot_height), widths = c(plot_width, plot_width))
  
  # Return the combined plot
  return(gdp_bh)
}




###### gni
# Combine the datasets
combined_gni <- rbind(gni_b %>% mutate(Country = "Bahamas"),
                      gni_h %>% mutate(Country = "Haiti"))

# Create a GNI comparison plot
gni_plot_bh <- ggplot(data = combined_gni, aes(x = Year, y = Value, color = Country)) +
  geom_line() +
  labs(title = "GNI in USD for Bahamas and Haiti over Years",
       x = "Year", y = "GNI (USD)") +
  scale_color_manual(values = c("Bahamas" = "#DA70D6", "Haiti" = "blue"))

# Display the GNI comparison plot
print(gni_plot_bh)


####### population
pop_b <- pop_b %>% 
  filter(Year.s. >= 2000, Year.s. <= 2010, Variant == "Medium") %>%
  select(Year.s., Value) %>%
  mutate(Country = "Bahamas")

pop_h <- pop_h %>%
  filter(Year.s. >= 2000, Year.s. <= 2010, Variant == "Medium") %>%
  select(Year.s., Value) %>%
  mutate(Country = "Haiti")

# Combine the datasets
combined_pop <- rbind(pop_b, pop_h)

# Create a population projection comparison plot
population_plot_bh <- ggplot(combined_pop, aes(x = Year.s., y = Value, color = Country)) +
  geom_line() +
  labs(title = "Population Projections for Bahamas and Haiti (Medium Variant) over Years",
       x = "Year", y = "Population in Thousands") +
  scale_color_manual(values = c("Bahamas" = "cyan4", "Haiti" = "blue"))

# Display the population projection comparison plot
print(population_plot_bh)


###### Infant / under 5 mortality
# Combine the data frames row-wise
# Add a new column to identify the source of each row
infant_b$Source <- "Infant (Bahamas)"
infant_h$Source <- "Infant (Haiti)"
under5_b$Source <- "Under Age 5 (Bahamas)"
under5_h$Source <- "Under Age 5 (Haiti)"

combined_data <- rbind(infant_b, infant_h, under5_b, under5_h)
combined_data <- na.omit(combined_data)

# Create a plot using the combined data with four distinct colors
mortality_plot_bh <- ggplot(combined_data, aes(x = Year.s., y = Value, color = Source)) +
  geom_line() +
  labs(title = "Mortality Rate in Thousands for Bahamas and Haiti",
       x = "Year(s)", y = "Mortality Rate") +
  scale_color_manual(values = c("Infant (Bahamas)" = "red", 
                                "Infant (Haiti)" = "blue", 
                                "Under Age 5 (Bahamas)" = "green", 
                                "Under Age 5 (Haiti)" = "purple"))

# Display the mortality rate comparison plot
print(mortality_plot_bh)