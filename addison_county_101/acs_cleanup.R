library(tidyverse)
library(tidycensus)

acs_vars <- load_variables(year = 2018,
                           dataset = "ACS5",
                           cache = TRUE)


country_total <- get_acs(geography = "us",
                         survey = "acs1",
                         variables = c("median_hh_income" = "B19013_001",
                                       "poverty_total" = "B17001_001",
                                       "poverty_below" = "B17001_002",
                                       "snap_total" = "B22002_001",
                                       "snap_received" = "B22002_002",
                                       "snap_received_children" = "B22002_003",
                                       "snap_not_received_children" = "B22002_016",
                                       "housing_total" = "B25003_001",
                                       "housing_owned" = "B25003_002",
                                       "housing_rented" = "B25003_003",
                                       "educ_total" = "B15003_001",
                                       "educ_bachelors" = "B15003_022",
                                       "educ_masters" = "B15003_023",
                                       "educ_professional" = "B15003_024",
                                       "educ_doctorate" = "B15003_025",
                                       "laborforce_civilian_total" = "B23025_003",
                                       "laborforce_civilian_employed" = "B23025_004",
                                       "laborforce_civilian_unemployed" = "B23025_005",
                                       "race_total" = "B03002_001",
                                       "race_white" = "B03002_003",
                                       "race_black" = "B03002_004",
                                       "race_amindian" = "B03002_005",
                                       "race_asian" = "B03002_006",
                                       "race_nhpi" = "B03002_007",
                                       "race_other" = "B03002_008",
                                       "race_twoplus" = "B03002_011",
                                       "race_hispanic" = "B03002_012",
                                       "foreign_born_total" = "B05002_001",
                                       "foreign_born" = "B05002_013"),
                         output = "wide") %>%
  mutate(geography = "us")


vt_state <- get_acs(geography = "state",
                    state = "VT",
                    survey = "acs1",
                    variables = c("median_hh_income" = "B19013_001",
                                  "poverty_total" = "B17001_001",
                                  "poverty_below" = "B17001_002",
                                  "snap_total" = "B22002_001",
                                  "snap_received" = "B22002_002",
                                  "snap_received_children" = "B22002_003",
                                  "snap_not_received_children" = "B22002_016",
                                  "housing_total" = "B25003_001",
                                  "housing_owned" = "B25003_002",
                                  "housing_rented" = "B25003_003",
                                  "educ_total" = "B15003_001",
                                  "educ_bachelors" = "B15003_022",
                                  "educ_masters" = "B15003_023",
                                  "educ_professional" = "B15003_024",
                                  "educ_doctorate" = "B15003_025",
                                  "laborforce_civilian_total" = "B23025_003",
                                  "laborforce_civilian_employed" = "B23025_004",
                                  "laborforce_civilian_unemployed" = "B23025_005",
                                  "race_total" = "B03002_001",
                                  "race_white" = "B03002_003",
                                  "race_black" = "B03002_004",
                                  "race_amindian" = "B03002_005",
                                  "race_asian" = "B03002_006",
                                  "race_nhpi" = "B03002_007",
                                  "race_other" = "B03002_008",
                                  "race_twoplus" = "B03002_011",
                                  "race_hispanic" = "B03002_012",
                                  "foreign_born_total" = "B05002_001",
                                  "foreign_born" = "B05002_013"),
                    output = "wide") %>%
  mutate(geography = "state")



vt_county <- get_acs(geography = "county",
                           state = "VT",
                           variables = c("median_hh_income" = "B19013_001",
                                         "poverty_total" = "B17001_001",
                                         "poverty_below" = "B17001_002",
                                         "snap_total" = "B22002_001",
                                         "snap_received" = "B22002_002",
                                         "snap_received_children" = "B22002_003",
                                         "snap_not_received_children" = "B22002_016",
                                         "housing_total" = "B25003_001",
                                         "housing_owned" = "B25003_002",
                                         "housing_rented" = "B25003_003",
                                         "educ_total" = "B15003_001",
                                         "educ_bachelors" = "B15003_022",
                                         "educ_masters" = "B15003_023",
                                         "educ_professional" = "B15003_024",
                                         "educ_doctorate" = "B15003_025",
                                         "laborforce_civilian_total" = "B23025_003",
                                         "laborforce_civilian_employed" = "B23025_004",
                                         "laborforce_civilian_unemployed" = "B23025_005",
                                         "race_total" = "B03002_001",
                                         "race_white" = "B03002_003",
                                         "race_black" = "B03002_004",
                                         "race_amindian" = "B03002_005",
                                         "race_asian" = "B03002_006",
                                         "race_nhpi" = "B03002_007",
                                         "race_other" = "B03002_008",
                                         "race_twoplus" = "B03002_011",
                                         "race_hispanic" = "B03002_012",
                                         "foreign_born_total" = "B05002_001",
                                         "foreign_born" = "B05002_013"),
                           output = "wide") %>%
  mutate(geography = "county")


vt_tracts <- get_acs(geography = "tract",
                     state = "VT",
                     county = "Addison",
                     variables = c("median_hh_income" = "B19013_001",
                                   "poverty_total" = "B17001_001",
                                   "poverty_below" = "B17001_002",
                                   "snap_total" = "B22002_001",
                                   "snap_received" = "B22002_002",
                                   "snap_received_children" = "B22002_003",
                                   "snap_not_received_children" = "B22002_016",
                                   "housing_total" = "B25003_001",
                                   "housing_owned" = "B25003_002",
                                   "housing_rented" = "B25003_003",
                                   "educ_total" = "B15003_001",
                                   "educ_bachelors" = "B15003_022",
                                   "educ_masters" = "B15003_023",
                                   "educ_professional" = "B15003_024",
                                   "educ_doctorate" = "B15003_025",
                                   "laborforce_civilian_total" = "B23025_003",
                                   "laborforce_civilian_employed" = "B23025_004",
                                   "laborforce_civilian_unemployed" = "B23025_005",
                                   "race_total" = "B03002_001",
                                   "race_white" = "B03002_003",
                                   "race_black" = "B03002_004",
                                   "race_amindian" = "B03002_005",
                                   "race_asian" = "B03002_006",
                                   "race_nhpi" = "B03002_007",
                                   "race_other" = "B03002_008",
                                   "race_twoplus" = "B03002_011",
                                   "race_hispanic" = "B03002_012",
                                   "foreign_born_total" = "B05002_001",
                                   "foreign_born" = "B05002_013"),
                     output = "wide") %>%
  mutate(geography = "census tract")



vermont_us <- rbind(country_total, vt_state, vt_county, vt_tracts)

vermont_us <- select(vermont_us, !ends_with("M"))

vermont_us_nomoe <- vermont_us %>%
  mutate(poverty_rate_total = round(((poverty_belowE / poverty_totalE) * 100),1),
         snap_rate_total = round(((snap_receivedE / snap_totalE) * 100),1),
         snap_rate_children = round(((snap_received_childrenE / (snap_received_childrenE + 
                                                           snap_not_received_childrenE)) * 100),1),
         housing_owner_occupied = round(((housing_ownedE / housing_totalE) * 100),1),
         educ_ba_plus = round((((educ_bachelorsE + educ_mastersE + educ_professionalE + educ_doctorateE) / 
                           educ_totalE) * 100),1),
         employment_rate_civilian = round(((laborforce_civilian_employedE / laborforce_civilian_totalE) * 100),1),
         race_white = round(((race_whiteE / race_totalE)*100),1),
         race_black = round(((race_blackE / race_totalE)*100),1),
         race_nhpi_amind = round((((race_nhpiE + race_amindianE) / race_totalE)*100),1),
         race_asian = round(((race_asianE / race_totalE)*100),1),
         race_other = round(((race_otherE / race_totalE)*100),1),
         race_twoplus = round(((race_twoplusE / race_totalE)*100),1),
         race_hispanic = round(((race_hispanicE / race_totalE)*100),1),
         foreign_born = round(((foreign_bornE / foreign_born_totalE)*100),1)) %>%
  rename(median_hh_income = median_hh_incomeE) %>%
  mutate(short_name = NAME) %>%
  separate(short_name, c("short_name", "extra"), sep = ",") %>%
  separate(short_name, c("short_name", "extra"), sep = " County") %>%
  select(-extra) %>%
  mutate(short_name = ifelse(grepl("9601", short_name), "Starksboro", 
                             ifelse(grepl("9602", short_name), "Ferrisburgh",
                                    ifelse(grepl("9603", short_name), "Vergennes",
                                                 ifelse(grepl("9604", short_name), "Panton, Addison, Weybridge, New Haven", 
                                                              ifelse(grepl("9605", short_name), "Bristol",
                                                                     ifelse(grepl("9606", short_name), "Lincoln, Ripton, Granville, Hancock, Goshen", 
                                                                            ifelse(grepl("9607", short_name), "Middlebury 1", 
                                                                                   ifelse(grepl("9608", short_name), "Middlebury 2",
                                                                                          ifelse(grepl("9609", short_name), "Cornwall, Shoreham, Whiting",
                                                                                                 ifelse(grepl("9610", short_name), "Salisbury, Leicster", short_name))))))))))) %>%
  mutate(datawrapper_id = GEOID) %>%
  mutate(datawrapper_id = ifelse(geography=="county", str_sub(GEOID, 3, 6), 
                                 ifelse(geography=="census tract", str_sub(GEOID, 3, 11), GEOID))) %>%
  select(GEOID, datawrapper_id, geography, NAME, short_name, median_hh_income,
         poverty_rate_total, snap_rate_total, snap_rate_children,
         housing_owner_occupied, educ_ba_plus, employment_rate_civilian,
         race_white:race_hispanic, foreign_born) %>%
  arrange(desc(geography), datawrapper_id)

names(vermont_us_nomoe) <- tolower(names(vermont_us_nomoe))

write.csv(vermont_us_nomoe, "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/acs_stats.csv")

vermont_us_race <- vermont_us_nomoe %>%
  select(geoid, datawrapper_id, geography, name, short_name, race_white:race_hispanic) %>%
  gather(race, percent, race_white:race_hispanic) %>%
  separate(race, c("race", "category", sep = "race_")) %>%
  select(-c("race", "race_")) %>%
  arrange(desc(geography), datawrapper_id)

write.csv(vermont_us_race, "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/acs_stats_race_long.csv")


