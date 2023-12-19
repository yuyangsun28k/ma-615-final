library(ggplot2)
library(dplyr)
library(gridExtra)
gdp_b<-read.csv("data/gdp.csv")
gdp_c<-read.csv("data/cuba_gdp.csv")
gni_b<-read.csv("data/GNI_USD.csv")
gni_c<-read.csv("data/cuba_gni.csv")
pop_b<-read.csv("data/total_population_thousands.csv")
pop_c<-read.csv("data/cuba_pop.csv")
infant_b<-read.csv("data/infant_mortality_rate_thousands.csv")
infant_c<-read.csv("data/cuba_infant.csv")
under5_b<-read.csv("data/under5_mortality_rate_thousands.csv")
under5_c<-read.csv("data/cuba_under5.csv")

### gdp
gdp_b <- gdp_b %>% mutate(Country = "Bahamas")
gdp_c <- gdp_c %>% mutate(Country = "Cuba")

# Create bar charts for Bahamas and Cuba
plot_bahamas <- ggplot(gdp_b, aes(x = Year, y = Value, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "GDP Comparison: Bahamas",
       x = "Year", y = "GDP (USD)") +
  scale_fill_manual(values = c("Bahamas" = "blue")) +
  theme_minimal()

plot_cuba <- ggplot(gdp_c, aes(x = Year, y = Value, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "GDP Comparison: Cuba",
       x = "Year", y = "GDP (USD)") +
  scale_fill_manual(values = c("Cuba" = "red")) +
  theme_minimal()

# Set custom height and width for the plots
plot_height <- 5
plot_width <- 8

# Arrange the plots side by side with custom height and width
gdp_bc <- grid.arrange(plot_bahamas, plot_cuba, ncol = 2, heights = c(plot_height, plot_height), widths = c(plot_width, plot_width))

# Display the combined plot
print(gdp_bc)

# Define a function to generate and return the combined GDP plot
generateCombinedGDPPlot_c <- function() {
  # Arrange the plots side by side with custom height and width
  gdp_bc <- grid.arrange(plot_bahamas, plot_cuba, ncol = 2, heights = c(plot_height, plot_height), widths = c(plot_width, plot_width))
  
  # Return the combined plot
  return(gdp_bc)
}




###### gni
# Combine the datasets
combined_gni <- rbind(gni_b %>% mutate(Country = "Bahamas"),
                      gni_c %>% mutate(Country = "cuba"))

# Create a GNI comparison plot
gni_plot_bc <- ggplot(data = combined_gni, aes(x = Year, y = Value, color = Country)) +
  geom_line() +
  labs(title = "GNI in USD for Bahamas and cuba over Years",
       x = "Year", y = "GNI (USD)") +
  scale_color_manual(values = c("Bahamas" = "#DA70D6", "Cuba" = "blue"))

# Display the GNI comparison plot
print(gni_plot_bc)


####### population
pop_b <- pop_b %>% 
  filter(Year.s. >= 2000, Year.s. <= 2010, Variant == "Medium") %>%
  select(Year.s., Value) %>%
  mutate(Country = "Bahamas")

pop_c <- pop_c %>%
  filter(Year.s. >= 2000, Year.s. <= 2010, Variant == "Medium") %>%
  select(Year.s., Value) %>%
  mutate(Country = "Cuba")

# Combine the datasets
combined_pop <- rbind(pop_b, pop_c)

# Create a population projection comparison plot
population_plot_bc <- ggplot(combined_pop, aes(x = Year.s., y = Value, color = Country)) +
  geom_line() +
  labs(title = "Population Projections for Bahamas and Cuba (Medium Variant) over Years",
       x = "Year", y = "Population in Thousands") +
  scale_color_manual(values = c("Bahamas" = "cyan4", "Cuba" = "blue"))

# Display the population projection comparison plot
print(population_plot_bc)


###### Infant / under 5 mortality
# Combine the data frames row-wise
# Add a new column to identify the source of each row
infant_b$Source <- "Infant (Bahamas)"
infant_c$Source <- "Infant (Cuba)"
under5_b$Source <- "Under Age 5 (Bahamas)"
under5_c$Source <- "Under Age 5 (Cuba)"

combined_data <- rbind(infant_b, infant_c, under5_b, under5_c)
combined_data <- na.omit(combined_data)

# Create a plot using the combined data with four distinct colors
mortality_plot_bc <- ggplot(combined_data, aes(x = Year.s., y = Value, color = Source)) +
  geom_line() +
  labs(title = "Mortality Rate in Thousands for Bahamas and Cuba",
       x = "Year(s)", y = "Mortality Rate") +
  scale_color_manual(values = c("Infant (Bahamas)" = "red", 
                                "Infant (Cuba)" = "blue", 
                                "Under Age 5 (Bahamas)" = "green", 
                                "Under Age 5 (Cuba)" = "purple"))

# Display the mortality rate comparison plot
print(mortality_plot_bc)