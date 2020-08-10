library(tidyverse)
library(tidycensus)
library(gganimate)
library(gapminder)
library(lubridate)

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

# ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
#   geom_point(alpha = 0.7, show.legend = FALSE) +
#   scale_colour_manual(values = country_colors) +
#   scale_size(range = c(2, 12)) +
#   scale_x_log10() +
#   facet_wrap(~continent) +
#   # Here comes the gganimate specific bits
#   labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
#   transition_time(year) +
#   ease_aes('linear')



covid_cases <- read_csv("https://usafactsstatic.blob.core.windows.net/public/data/covid-19/covid_confirmed_usafacts.csv",
                        col_names = TRUE)

covid_cases <- covid_cases %>%
  mutate(countyFIPS = sprintf("%05d", as.numeric(countyFIPS))) %>%
  rename(County_Name = "County Name",
         GEOID = "countyFIPS") 

covid_poverty <- left_join(pov_cor_clean, covid_cases, by = "GEOID")

covid_poverty_gather <- covid_poverty %>%
  filter(pop_totalE>0) %>%
  gather(date, cases, 37:236) %>%
  mutate(date2 = mdy(date),
         case_rate = cases / pop_totalE,
         case_rate_per100k = (cases * 100000) / pop_totalE)
         
covid_poverty_gather %>%
  filter(date2 == max(date2)) %>%
  ggplot(aes(giniE, case_rate_per100k)) + geom_point()

covid_gini_animation <- covid_poverty_gather %>%
  group_by(GEOID) %>%
  #filter(max(case_rate_per100k) < 6500) %>%
  ungroup() %>%
  ggplot(aes(giniE, case_rate_per100k, size = pop_totalE)) + geom_point() +
  labs(title = 'Date: {frame_time}', x = 'Gini', y = 'Cases Per 100K') +
  transition_time(date2) +
  ease_aes('linear') +
  enter_fade() + exit_shrink()

animate(covid_gini_animation, renderer = gifski_renderer(loop = F))



