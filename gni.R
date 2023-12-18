library(ggplot2)
gni <- read.csv("GNI_USD.csv")

gni_plot <- ggplot(data = gni, aes(x=Year, y=Value)) +
  geom_line (color = "#DA70D6") +
  labs(title = "GNI in USD for Bahamas over years",
     x = "Year", y = "GNI_USD")

