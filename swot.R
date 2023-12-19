#swot
library(readr)
library(dplyr)
library(tidyr)
api_data_path <- "data/API_BHS_DS2_en_csv_v2_6243847.csv"
api_data <- read_csv(api_data_path, skip = 4)
api_data_long <- api_data %>%
  pivot_longer(
    cols = -c(`Country Name`, `Country Code`, `Indicator Name`, `Indicator Code`, ...68),
    names_to = "Year",
    values_to = "Value"
  ) %>%
  mutate(Year = as.numeric(gsub("X", "", Year))) %>%
  filter(!is.na(Value))

# Strengths
strengths <- api_data_long %>%
  filter(`Indicator Name` %in% c("GDP (current US$)", "GDP growth (annual %)", "High-technology exports (current US$)")) %>%
  group_by(`Indicator Name`) %>%
  summarise(Recent = last(Value, order_by = Year))

# Weaknesses
weaknesses <- api_data_long %>%
  filter(`Indicator Name` %in% c("Unemployment, total (% of total labor force) (national estimate)", "Inflation, consumer prices (annual %)")) %>%
  group_by(`Indicator Name`) %>%
  summarise(Recent = last(Value, order_by = Year))

# Opportunities
opportunities <- api_data_long %>%
  filter(`Indicator Name` %in% c("Foreign direct investment, net inflows (BoP, current US$)", "Market capitalization of listed domestic companies (current US$)")) %>%
  group_by(`Indicator Name`) %>%
  summarise(Recent = last(Value, order_by = Year))

# Threats
threats <- api_data_long %>%
  filter(`Indicator Name` %in% c("Natural disasters, number of people affected", "CO2 emissions (metric tons per capita)")) %>%
  group_by(`Indicator Name`) %>%
  summarise(Recent = last(Value, order_by = Year))

list(Strengths = strengths, Weaknesses = weaknesses, Opportunities = opportunities, Threats = threats)
