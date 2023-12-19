source("compare_cuba.R")
source("compare_jamaica.R")
source("compare_haiti.R")
source("compare_dominica.R")
library(knitr)
library(kableExtra)

#GNI
gni_table <- rbind(gni_b %>% mutate(Country = "Bahamas"),
                   gni_c %>% mutate(Country = "Cuba"),
                   gni_d %>% mutate(Country = "Dominica"),
                   gni_h %>% mutate(Country = "Haiti"),
                   gni_j %>% mutate(Country = "Jamaica")
                   %>% 
                     arrange(Country, desc(Year)))

#GDP
gdp_table <- bind_rows(gdp_b, gdp_c, gdp_h, gdp_d,gdp_j) %>% 
  arrange(Country, desc(Year))

#Pop
pop_table <- bind_rows(pop_b, pop_c, pop_h, pop_d,pop_j) %>% 
  arrange(Country, desc(Year.s.))

#Mob
mob_table <- bind_rows(infant_b, infant_j, under5_b, under5_j,
                       infant_c, infant_d, under5_c, under5_d,
                       infant_h, under5_h)

#
generateGNITable <- function(data_frame) {
  kable(data_frame, caption = "GNI Comparison", format = "html") %>%
    kable_styling(bootstrap_options = c("striped", "hover"))
}

generateGDPTable <- function(data_frame) {
  kable(data_frame, caption = "GDP Comparison", format = "html") %>%
    kable_styling(bootstrap_options = c("striped", "hover"))
}

generatePopulationTable <- function(data_frame) {
  kable(data_frame, caption = "Population Comparison", format = "html") %>%
    kable_styling(bootstrap_options = c("striped", "hover"))
}

generateMortalityTable <- function(data_frame) {
  kable(data_frame, caption = "Mortality Rate Comparison", format = "html") %>%
    kable_styling(bootstrap_options = c("striped", "hover"))
}