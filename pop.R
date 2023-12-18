library(dplyr)
library(ggplot2)

# Load Dataset
pop <- read.csv("data/total_population_thousands.csv")
pop <- subset(pop, Variant == "Medium")
# test plot here:
plot_pop <- ggplot(pop, aes(x = Year.s., y = Value)) +
  geom_line(color = "cyan4") +
  labs(title = "Population Projections for Bahamas over years",
       x = "Variant", y = "Population")
