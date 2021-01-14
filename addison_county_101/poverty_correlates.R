library(tidyverse)
library(tidycensus)
library(weights)
library(lubridate)
library(gghighlight)

#acs_variables <- load_variables(year = 2018,
#                               dataset = "acs5")

pov_cor <- get_acs(year = 2018,
                   survey = "acs5",
                   geography = "county",
                   geometry = FALSE,
                   variables = c(commute_total = "B08303_001",
                                 commute_04 = "B08303_002",
                                 commute_09 = "B08303_003",
                                 commute_14 = "B08303_004",
                                 poverty_total = "C17002_001",
                                 poverty_050 = "C17002_002",
                                 poverty_099 = "C17002_003",
                                 poverty_124 = "C17002_004",
                                 poverty_149 = "C17002_005",
                                 pop_total = "B01003_001",
                                 median_hhi = "B19013_001",
                                 median_rent_pct_income = "B25071_001",
                                 gini = "B19083_001"),
                   output = "wide")


pov_cor_clean <- pov_cor %>%
  filter(!grepl("Puerto Rico", NAME)) %>%
  mutate(commute_under15 = 
           round(((commute_04E + commute_09E + commute_14E) /
                    commute_totalE), 3),
         poverty_rate = 
           round(((poverty_050E + poverty_099E) / poverty_totalE), 3),
         deep_poverty_rate = 
           round(((poverty_050E) / poverty_totalE), 3),
         poverty_in_deep_poverty =
           round(((poverty_050E) / (poverty_050E + poverty_099E)),3),
         poverty_rate_150 =
           round(((poverty_050E + poverty_099E + poverty_124E + poverty_149E)/
                    poverty_totalE), 3))

cor(pov_cor_clean$commute_under15, pov_cor_clean$poverty_rate, use = "complete")

cor(pov_cor_clean$commute_under15, pov_cor_clean$deep_poverty_rate, use = "complete")

cor(pov_cor_clean$commute_under15, pov_cor_clean$poverty_in_deep_poverty, use = "complete")

wtd.cor(pov_cor_clean$commute_under15, pov_cor_clean$giniE, weight = pov_cor_clean$pop_totalE)
wtd.cor(pov_cor_clean$commute_under15, pov_cor_clean$deep_poverty_rate, weight = pov_cor_clean$pop_totalE)
wtd.cor(pov_cor_clean$commute_under15, pov_cor_clean$poverty_in_deep_poverty, weight = pov_cor_clean$pop_totalE)
wtd.cor(pov_cor_clean$commute_under15, pov_cor_clean$median_hhiE, weight = pov_cor_clean$pop_totalE)

cor(pov_cor_clean$median_rent_pct_incomeE, pov_cor_clean$poverty_rate, use = "complete")
wtd.cor(pov_cor_clean$median_rent_pct_incomeE, pov_cor_clean$poverty_rate, weight = pov_cor_clean$pop_totalE)


pov_cor_clean %>%
  ggplot(aes(x = median_rent_pct_incomeE, y = poverty_rate_150,
             size = pop_totalE)) + geom_point() +
  gghighlight(grepl("Vermont", NAME))


## COVID Data
## From here: https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/

covid_cases <- read_csv("https://usafactsstatic.blob.core.windows.net/public/data/covid-19/covid_confirmed_usafacts.csv",
                        col_names = TRUE)

covid_cases <- covid_cases %>%
  rename(County_Name = "County Name")

covid_cases_gather <- covid_cases %>%
  select(1:4, ncol(covid_cases)) %>%
  gather(date, cases, 5)%>%
  group_by(countyFIPS) %>%
  mutate(date = as_date(date, format = "%m/%d/%y")) %>%
  filter(date == max(date),
         !grepl("Unallocated", County_Name)) %>%
  mutate(as_of_date = date,
         total_cases = cases) %>%
  spread(date, cases) %>%
  select(-7) %>%
  ungroup()

covid_deaths <- read_csv("https://usafactsstatic.blob.core.windows.net/public/data/covid-19/covid_deaths_usafacts.csv",
                         col_names = TRUE)

covid_deaths <- covid_deaths %>%
  rename(County_Name = "County Name")

covid_deaths_gather <- covid_deaths %>%
  select(1:4, ncol(covid_deaths)) %>%
  gather(date, deaths, 5) %>%
  group_by(countyFIPS) %>%
  mutate(date = as_date(date, format = "%m/%d/%y")) %>%
  filter(date == max(date),
         !grepl("Unallocated", County_Name)) %>%
  mutate(as_of_date = date,
         total_deaths = deaths) %>%
  spread(date, deaths) %>%
  select(-7) %>%
  ungroup()


covid_pop <- read_csv("https://usafactsstatic.blob.core.windows.net/public/data/covid-19/covid_county_population_usafacts.csv",
                      col_names = TRUE)

covid_pop <- covid_pop %>%
  rename(County_Name = "County Name")

covid_cases_deaths <- left_join(covid_cases_gather, covid_deaths_gather,
                                by = c("countyFIPS", "County_Name", "State", "as_of_date", "stateFIPS"))


covid_merge <- left_join(covid_cases_deaths, covid_pop,
                         by = c("countyFIPS", "County_Name", "State")) %>%
  filter(population>0) %>%
  mutate(case_rate = total_cases / population,
         case_rate_per100k = (total_cases * 100000) / population,
         deaths_per100k = (total_deaths * 100000) / population)

summary(covid_merge$case_rate)
summary(covid_merge$case_rate_per100k)
summary(covid_merge$deaths_per100k)

covid_merge <- covid_merge %>%
  mutate(countyFIPS = sprintf("%05d", as.numeric(countyFIPS))) %>%
  rename(GEOID = countyFIPS)

pov_covid <- left_join(pov_cor_clean, covid_merge, by = "GEOID")

pov_covid %>%
  filter(case_rate_per100k < 8200 & poverty_rate < .5) %>%
  ggplot(aes(x = poverty_rate_150, y = case_rate_per100k,
             size = pop_totalE)) + geom_point()

pov_covid %>%
  filter(case_rate_per100k < 8200) %>%
  ggplot(aes(x = giniE, y = case_rate_per100k,
             size = pop_totalE)) + geom_point() + geom_smooth(method = "lm") +
  gghighlight(grepl("Vermont", NAME))

cor(pov_covid$giniE, pov_covid$case_rate_per100k, use = "complete")
wtd.cor(pov_covid$giniE, pov_covid$case_rate_per100k, 
        weight = pov_covid$population)

cor(pov_covid$poverty_rate, pov_covid$case_rate_per100k, use = "complete")
wtd.cor(pov_covid$poverty_rate, pov_covid$case_rate_per100k, 
        weight = pov_covid$population)

cor(pov_covid$poverty_rate_150, pov_covid$case_rate_per100k, use = "complete")
wtd.cor(pov_covid$poverty_rate_150, pov_covid$case_rate_per100k, 
        weight = pov_covid$population)

cor(pov_covid$giniE, pov_covid$deaths_per100k, use = "complete")
wtd.cor(pov_covid$giniE, pov_covid$deaths_per100k, 
        weight = pov_covid$population)



cor(pov_covid$deep_poverty_rate, pov_covid$case_rate_per100k, use = "complete")
wtd.cor(pov_covid$deep_poverty_rate, pov_covid$case_rate_per100k, 
        weight = pov_covid$population)

cor(pov_covid$poverty_in_deep_poverty, pov_covid$case_rate_per100k, use = "complete")
wtd.cor(pov_covid$poverty_in_deep_poverty, pov_covid$case_rate_per100k, 
        weight = pov_covid$population)


wtd.cor(pov_covid$median_hhiE, pov_covid$case_rate_per100k, weight = pov_covid$population)

plot(pov_covid$median_hhiE, pov_covid$case_rate_per100k)

model1 <- lm(case_rate_per100k ~ poverty_rate, data = pov_covid)
summary(model1)

pov_covid %>%
  filter(case_rate>0) %>%
  ggplot(aes(x = poverty_rate, y = median_rent_pct_incomeE,
             size = population)) + geom_point() +
  gghighlight(State == "VT")

plot1 <- ggplot(pov_covid, aes(x = poverty_rate, y = case_rate_per100k,
                               size = population))
plot1 + geom_point() + geom_smooth(method = lm)

pov_covid <- pov_covid %>%
  mutate(case_rate_std = scale(case_rate),
         poverty_rate_std = scale(poverty_rate))

pov_covid %>%
  filter(case_rate>0) %>%
  ggplot(aes(x = giniE, y = case_rate_per100k,
             size = population, color = total_deaths)) + geom_point() 


pov_covid <- pov_covid %>%
  mutate(vermont = ifelse(State == "VT", "Vermont", "All Other States"))

poverty_covid <- pov_covid %>%
  filter(case_rate_per100k > 0) %>%
  rename(gini = giniE) %>%
  select(GEOID, NAME, poverty_rate, poverty_rate_150,
         gini, deep_poverty_rate, as_of_date, case_rate_per100k, total_deaths,
         deaths_per100k,
         population, vermont)

write.csv(poverty_covid, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/poverty_covid.csv",
          row.names = FALSE)

