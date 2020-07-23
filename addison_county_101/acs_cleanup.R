library(tidyverse)
library(tidycensus)

# Add homeless data from here: https://www.housingdata.org/profile/population-household/homelessness
county_homeless <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/homeless_data_2020.csv",
                            header = TRUE)
county_homeless <- rename(county_homeless, homeless_count_gender_men = homeless_count_gender_male)
county_homeless$NAME <- as.character(county_homeless$NAME)
names_county_homeless <- names(county_homeless[,2:23])

county_geo <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/county_lat_lon.csv")
county_geo$GEOID <- as.character(county_geo$GEOID)

acs_vars <- load_variables(year = 2018,
                           dataset = "ACS5",
                           cache = TRUE)

country <- get_acs(geography = "us",
                         survey = "acs1",
                         variables = c("population" = "B01003_001",
                                       "median_hh_income" = "B19013_001",
                                       "poverty_total" = "B17001_001",
                                       "poverty_below" = "B17001_002",
                                       "poverty_level_total" = "C17002_001",
                                       "poverty_level_below_fiftypercent" = "C17002_002",
                                       "poverty_level_above_fiftypercent" = "C17002_003",
                                       "snap_total" = "B22002_001",
                                       "snap_received" = "B22002_002",
                                       "snap_received_children" = "B22002_003",
                                       "snap_not_received_children" = "B22002_016",
                                       "housing_total" = "B25003_001",
                                       "housing_owned" = "B25003_002",
                                       "housing_rented" = "B25003_003",
                                       "educ_total" = "B15003_001",
                                       "educ_hs" = "B15003_017",
                                       "educ_ged" = "B15003_018",
                                       "educ_somecoll_less1" = "B15003_019",
                                       "educ_somecoll_more1" = "B15003_020",
                                       "educ_associates" = "B15003_021",
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
                                       "foreign_born" = "B05002_013",
                                       "insurance_none_06_male" = "B27001_005",
                                       "insurance_none_18_male" = "B27001_008",
                                       "insurance_none_25_male" = "B27001_011",
                                       "insurance_none_34_male" = "B27001_014",
                                       "insurance_none_44_male" = "B27001_017",
                                       "insurance_none_54_male" = "B27001_020",
                                       "insurance_none_64_male" = "B27001_023",
                                       "insurance_none_74_male" = "B27001_026",
                                       "insurance_none_75_male" = "B27001_029",
                                       "insurance_none_06_fmle" = "B27001_033",
                                       "insurance_none_18_fmle" = "B27001_036",
                                       "insurance_none_25_fmle" = "B27001_039",
                                       "insurance_none_34_fmle" = "B27001_042",
                                       "insurance_none_44_fmle" = "B27001_045",
                                       "insurance_none_54_fmle" = "B27001_048",
                                       "insurance_none_64_fmle" = "B27001_051",
                                       "insurance_none_74_fmle" = "B27001_054",
                                       "insurance_none_75_fmle" = "B27001_057",
                                       "insurance_with_06_male" = "B27001_004",
                                       "insurance_with_18_male" = "B27001_007",
                                       "insurance_with_25_male" = "B27001_010",
                                       "insurance_with_34_male" = "B27001_013",
                                       "insurance_with_44_male" = "B27001_016",
                                       "insurance_with_54_male" = "B27001_019",
                                       "insurance_with_64_male" = "B27001_022",
                                       "insurance_with_74_male" = "B27001_025",
                                       "insurance_with_75_male" = "B27001_028",
                                       "insurance_with_06_fmle" = "B27001_032",
                                       "insurance_with_18_fmle" = "B27001_035",
                                       "insurance_with_25_fmle" = "B27001_038",
                                       "insurance_with_34_fmle" = "B27001_041",
                                       "insurance_with_44_fmle" = "B27001_044",
                                       "insurance_with_54_fmle" = "B27001_047",
                                       "insurance_with_64_fmle" = "B27001_050",
                                       "insurance_with_74_fmle" = "B27001_053",
                                       "insurance_with_75_fmle" = "B27001_056",
                                       "total_sex_age" = "B01001_001",
                                       "total_sexm_age05" = "B01001_003",
                                       "total_sexm_age09" = "B01001_004",
                                       "total_sexm_age14" = "B01001_005",
                                       "total_sexm_age17" = "B01001_006",
                                       "total_sexm_age19" = "B01001_007",
                                       "total_sexm_age20" = "B01001_008",
                                       "total_sexm_age21" = "B01001_009",
                                       "total_sexm_age24" = "B01001_010",
                                       "total_sexm_age29" = "B01001_011",
                                       "total_sexm_age34" = "B01001_012",
                                       "total_sexm_age39" = "B01001_013",
                                       "total_sexm_age44" = "B01001_014",
                                       "total_sexm_age49" = "B01001_015",
                                       "total_sexm_age54" = "B01001_016",
                                       "total_sexm_age59" = "B01001_017",
                                       "total_sexm_age61" = "B01001_018",
                                       "total_sexm_age64" = "B01001_019",
                                       "total_sexm_age66" = "B01001_020",
                                       "total_sexm_age69" = "B01001_021",
                                       "total_sexm_age74" = "B01001_022",
                                       "total_sexm_age79" = "B01001_023",
                                       "total_sexm_age84" = "B01001_024",
                                       "total_sexm_age85" = "B01001_025",
                                       "total_sexf_age05" = "B01001_027",
                                       "total_sexf_age09" = "B01001_028",
                                       "total_sexf_age14" = "B01001_029",
                                       "total_sexf_age17" = "B01001_030",
                                       "total_sexf_age19" = "B01001_031",
                                       "total_sexf_age20" = "B01001_032",
                                       "total_sexf_age21" = "B01001_033",
                                       "total_sexf_age24" = "B01001_034",
                                       "total_sexf_age29" = "B01001_035",
                                       "total_sexf_age34" = "B01001_036",
                                       "total_sexf_age39" = "B01001_037",
                                       "total_sexf_age44" = "B01001_038",
                                       "total_sexf_age49" = "B01001_039",
                                       "total_sexf_age54" = "B01001_040",
                                       "total_sexf_age59" = "B01001_041",
                                       "total_sexf_age61" = "B01001_042",
                                       "total_sexf_age64" = "B01001_043",
                                       "total_sexf_age66" = "B01001_044",
                                       "total_sexf_age69" = "B01001_045",
                                       "total_sexf_age74" = "B01001_046",
                                       "total_sexf_age79" = "B01001_047",
                                       "total_sexf_age84" = "B01001_048",
                                       "total_sexf_age85" = "B01001_049"),
                         output = "wide") %>%
  mutate(geography = "us")


states_all <- get_acs(geography = "state",
                         survey = "acs1",
                         variables = c("population" = "B01003_001",
                                       "median_hh_income" = "B19013_001",
                                       "poverty_total" = "B17001_001",
                                       "poverty_below" = "B17001_002",
                                       "poverty_level_total" = "C17002_001",
                                       "poverty_level_below_fiftypercent" = "C17002_002",
                                       "poverty_level_above_fiftypercent" = "C17002_003",
                                       "snap_total" = "B22002_001",
                                       "snap_received" = "B22002_002",
                                       "snap_received_children" = "B22002_003",
                                       "snap_not_received_children" = "B22002_016",
                                       "housing_total" = "B25003_001",
                                       "housing_owned" = "B25003_002",
                                       "housing_rented" = "B25003_003",
                                       "educ_total" = "B15003_001",
                                       "educ_hs" = "B15003_017",
                                       "educ_ged" = "B15003_018",
                                       "educ_somecoll_less1" = "B15003_019",
                                       "educ_somecoll_more1" = "B15003_020",
                                       "educ_associates" = "B15003_021",
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
                                       "foreign_born" = "B05002_013",
                                       "insurance_none_06_male" = "B27001_005",
                                       "insurance_none_18_male" = "B27001_008",
                                       "insurance_none_25_male" = "B27001_011",
                                       "insurance_none_34_male" = "B27001_014",
                                       "insurance_none_44_male" = "B27001_017",
                                       "insurance_none_54_male" = "B27001_020",
                                       "insurance_none_64_male" = "B27001_023",
                                       "insurance_none_74_male" = "B27001_026",
                                       "insurance_none_75_male" = "B27001_029",
                                       "insurance_none_06_fmle" = "B27001_033",
                                       "insurance_none_18_fmle" = "B27001_036",
                                       "insurance_none_25_fmle" = "B27001_039",
                                       "insurance_none_34_fmle" = "B27001_042",
                                       "insurance_none_44_fmle" = "B27001_045",
                                       "insurance_none_54_fmle" = "B27001_048",
                                       "insurance_none_64_fmle" = "B27001_051",
                                       "insurance_none_74_fmle" = "B27001_054",
                                       "insurance_none_75_fmle" = "B27001_057",
                                       "insurance_with_06_male" = "B27001_004",
                                       "insurance_with_18_male" = "B27001_007",
                                       "insurance_with_25_male" = "B27001_010",
                                       "insurance_with_34_male" = "B27001_013",
                                       "insurance_with_44_male" = "B27001_016",
                                       "insurance_with_54_male" = "B27001_019",
                                       "insurance_with_64_male" = "B27001_022",
                                       "insurance_with_74_male" = "B27001_025",
                                       "insurance_with_75_male" = "B27001_028",
                                       "insurance_with_06_fmle" = "B27001_032",
                                       "insurance_with_18_fmle" = "B27001_035",
                                       "insurance_with_25_fmle" = "B27001_038",
                                       "insurance_with_34_fmle" = "B27001_041",
                                       "insurance_with_44_fmle" = "B27001_044",
                                       "insurance_with_54_fmle" = "B27001_047",
                                       "insurance_with_64_fmle" = "B27001_050",
                                       "insurance_with_74_fmle" = "B27001_053",
                                       "insurance_with_75_fmle" = "B27001_056",
                                       "total_sex_age" = "B01001_001",
                                       "total_sexm_age05" = "B01001_003",
                                       "total_sexm_age09" = "B01001_004",
                                       "total_sexm_age14" = "B01001_005",
                                       "total_sexm_age17" = "B01001_006",
                                       "total_sexm_age19" = "B01001_007",
                                       "total_sexm_age20" = "B01001_008",
                                       "total_sexm_age21" = "B01001_009",
                                       "total_sexm_age24" = "B01001_010",
                                       "total_sexm_age29" = "B01001_011",
                                       "total_sexm_age34" = "B01001_012",
                                       "total_sexm_age39" = "B01001_013",
                                       "total_sexm_age44" = "B01001_014",
                                       "total_sexm_age49" = "B01001_015",
                                       "total_sexm_age54" = "B01001_016",
                                       "total_sexm_age59" = "B01001_017",
                                       "total_sexm_age61" = "B01001_018",
                                       "total_sexm_age64" = "B01001_019",
                                       "total_sexm_age66" = "B01001_020",
                                       "total_sexm_age69" = "B01001_021",
                                       "total_sexm_age74" = "B01001_022",
                                       "total_sexm_age79" = "B01001_023",
                                       "total_sexm_age84" = "B01001_024",
                                       "total_sexm_age85" = "B01001_025",
                                       "total_sexf_age05" = "B01001_027",
                                       "total_sexf_age09" = "B01001_028",
                                       "total_sexf_age14" = "B01001_029",
                                       "total_sexf_age17" = "B01001_030",
                                       "total_sexf_age19" = "B01001_031",
                                       "total_sexf_age20" = "B01001_032",
                                       "total_sexf_age21" = "B01001_033",
                                       "total_sexf_age24" = "B01001_034",
                                       "total_sexf_age29" = "B01001_035",
                                       "total_sexf_age34" = "B01001_036",
                                       "total_sexf_age39" = "B01001_037",
                                       "total_sexf_age44" = "B01001_038",
                                       "total_sexf_age49" = "B01001_039",
                                       "total_sexf_age54" = "B01001_040",
                                       "total_sexf_age59" = "B01001_041",
                                       "total_sexf_age61" = "B01001_042",
                                       "total_sexf_age64" = "B01001_043",
                                       "total_sexf_age66" = "B01001_044",
                                       "total_sexf_age69" = "B01001_045",
                                       "total_sexf_age74" = "B01001_046",
                                       "total_sexf_age79" = "B01001_047",
                                       "total_sexf_age84" = "B01001_048",
                                       "total_sexf_age85" = "B01001_049"),
                         output = "wide") %>%
  mutate(geography = "state")



vt_state <- states_all %>%
  filter(NAME == "Vermont") %>%
  mutate(geography = str_replace(geography, "state", "state_vt"))
  

vt_county <- get_acs(geography = "county",
                           state = "VT",
                     variables = c("population" = "B01003_001",
                                   "median_hh_income" = "B19013_001",
                                   "poverty_total" = "B17001_001",
                                   "poverty_below" = "B17001_002",
                                   "poverty_level_total" = "C17002_001",
                                   "poverty_level_below_fiftypercent" = "C17002_002",
                                   "poverty_level_above_fiftypercent" = "C17002_003",
                                   "snap_total" = "B22002_001",
                                   "snap_received" = "B22002_002",
                                   "snap_received_children" = "B22002_003",
                                   "snap_not_received_children" = "B22002_016",
                                   "housing_total" = "B25003_001",
                                   "housing_owned" = "B25003_002",
                                   "housing_rented" = "B25003_003",
                                   "educ_total" = "B15003_001",
                                   "educ_hs" = "B15003_017",
                                   "educ_ged" = "B15003_018",
                                   "educ_somecoll_less1" = "B15003_019",
                                   "educ_somecoll_more1" = "B15003_020",
                                   "educ_associates" = "B15003_021",
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
                                   "foreign_born" = "B05002_013",
                                   "insurance_none_06_male" = "B27001_005",
                                   "insurance_none_18_male" = "B27001_008",
                                   "insurance_none_25_male" = "B27001_011",
                                   "insurance_none_34_male" = "B27001_014",
                                   "insurance_none_44_male" = "B27001_017",
                                   "insurance_none_54_male" = "B27001_020",
                                   "insurance_none_64_male" = "B27001_023",
                                   "insurance_none_74_male" = "B27001_026",
                                   "insurance_none_75_male" = "B27001_029",
                                   "insurance_none_06_fmle" = "B27001_033",
                                   "insurance_none_18_fmle" = "B27001_036",
                                   "insurance_none_25_fmle" = "B27001_039",
                                   "insurance_none_34_fmle" = "B27001_042",
                                   "insurance_none_44_fmle" = "B27001_045",
                                   "insurance_none_54_fmle" = "B27001_048",
                                   "insurance_none_64_fmle" = "B27001_051",
                                   "insurance_none_74_fmle" = "B27001_054",
                                   "insurance_none_75_fmle" = "B27001_057",
                                   "insurance_with_06_male" = "B27001_004",
                                   "insurance_with_18_male" = "B27001_007",
                                   "insurance_with_25_male" = "B27001_010",
                                   "insurance_with_34_male" = "B27001_013",
                                   "insurance_with_44_male" = "B27001_016",
                                   "insurance_with_54_male" = "B27001_019",
                                   "insurance_with_64_male" = "B27001_022",
                                   "insurance_with_74_male" = "B27001_025",
                                   "insurance_with_75_male" = "B27001_028",
                                   "insurance_with_06_fmle" = "B27001_032",
                                   "insurance_with_18_fmle" = "B27001_035",
                                   "insurance_with_25_fmle" = "B27001_038",
                                   "insurance_with_34_fmle" = "B27001_041",
                                   "insurance_with_44_fmle" = "B27001_044",
                                   "insurance_with_54_fmle" = "B27001_047",
                                   "insurance_with_64_fmle" = "B27001_050",
                                   "insurance_with_74_fmle" = "B27001_053",
                                   "insurance_with_75_fmle" = "B27001_056",
                                   "total_sex_age" = "B01001_001",
                                   "total_sexm_age05" = "B01001_003",
                                   "total_sexm_age09" = "B01001_004",
                                   "total_sexm_age14" = "B01001_005",
                                   "total_sexm_age17" = "B01001_006",
                                   "total_sexm_age19" = "B01001_007",
                                   "total_sexm_age20" = "B01001_008",
                                   "total_sexm_age21" = "B01001_009",
                                   "total_sexm_age24" = "B01001_010",
                                   "total_sexm_age29" = "B01001_011",
                                   "total_sexm_age34" = "B01001_012",
                                   "total_sexm_age39" = "B01001_013",
                                   "total_sexm_age44" = "B01001_014",
                                   "total_sexm_age49" = "B01001_015",
                                   "total_sexm_age54" = "B01001_016",
                                   "total_sexm_age59" = "B01001_017",
                                   "total_sexm_age61" = "B01001_018",
                                   "total_sexm_age64" = "B01001_019",
                                   "total_sexm_age66" = "B01001_020",
                                   "total_sexm_age69" = "B01001_021",
                                   "total_sexm_age74" = "B01001_022",
                                   "total_sexm_age79" = "B01001_023",
                                   "total_sexm_age84" = "B01001_024",
                                   "total_sexm_age85" = "B01001_025",
                                   "total_sexf_age05" = "B01001_027",
                                   "total_sexf_age09" = "B01001_028",
                                   "total_sexf_age14" = "B01001_029",
                                   "total_sexf_age17" = "B01001_030",
                                   "total_sexf_age19" = "B01001_031",
                                   "total_sexf_age20" = "B01001_032",
                                   "total_sexf_age21" = "B01001_033",
                                   "total_sexf_age24" = "B01001_034",
                                   "total_sexf_age29" = "B01001_035",
                                   "total_sexf_age34" = "B01001_036",
                                   "total_sexf_age39" = "B01001_037",
                                   "total_sexf_age44" = "B01001_038",
                                   "total_sexf_age49" = "B01001_039",
                                   "total_sexf_age54" = "B01001_040",
                                   "total_sexf_age59" = "B01001_041",
                                   "total_sexf_age61" = "B01001_042",
                                   "total_sexf_age64" = "B01001_043",
                                   "total_sexf_age66" = "B01001_044",
                                   "total_sexf_age69" = "B01001_045",
                                   "total_sexf_age74" = "B01001_046",
                                   "total_sexf_age79" = "B01001_047",
                                   "total_sexf_age84" = "B01001_048",
                                   "total_sexf_age85" = "B01001_049"),
                           output = "wide") %>%
  mutate(geography = "county")

vt_county_subdivisions <- get_acs(geography = "county subdivision",
                     state = "VT",
                     county = "Addison",
                     variables = c("population" = "B01003_001",
                                   "median_hh_income" = "B19013_001",
                                   "poverty_total" = "B17001_001",
                                   "poverty_below" = "B17001_002",
                                   "poverty_level_total" = "C17002_001",
                                   "poverty_level_below_fiftypercent" = "C17002_002",
                                   "poverty_level_above_fiftypercent" = "C17002_003",
                                   "snap_total" = "B22002_001",
                                   "snap_received" = "B22002_002",
                                   "snap_received_children" = "B22002_003",
                                   "snap_not_received_children" = "B22002_016",
                                   "housing_total" = "B25003_001",
                                   "housing_owned" = "B25003_002",
                                   "housing_rented" = "B25003_003",
                                   "educ_total" = "B15003_001",
                                   "educ_hs" = "B15003_017",
                                   "educ_ged" = "B15003_018",
                                   "educ_somecoll_less1" = "B15003_019",
                                   "educ_somecoll_more1" = "B15003_020",
                                   "educ_associates" = "B15003_021",
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
                                   "foreign_born" = "B05002_013",
                                   "insurance_none_06_male" = "B27001_005",
                                   "insurance_none_18_male" = "B27001_008",
                                   "insurance_none_25_male" = "B27001_011",
                                   "insurance_none_34_male" = "B27001_014",
                                   "insurance_none_44_male" = "B27001_017",
                                   "insurance_none_54_male" = "B27001_020",
                                   "insurance_none_64_male" = "B27001_023",
                                   "insurance_none_74_male" = "B27001_026",
                                   "insurance_none_75_male" = "B27001_029",
                                   "insurance_none_06_fmle" = "B27001_033",
                                   "insurance_none_18_fmle" = "B27001_036",
                                   "insurance_none_25_fmle" = "B27001_039",
                                   "insurance_none_34_fmle" = "B27001_042",
                                   "insurance_none_44_fmle" = "B27001_045",
                                   "insurance_none_54_fmle" = "B27001_048",
                                   "insurance_none_64_fmle" = "B27001_051",
                                   "insurance_none_74_fmle" = "B27001_054",
                                   "insurance_none_75_fmle" = "B27001_057",
                                   "insurance_with_06_male" = "B27001_004",
                                   "insurance_with_18_male" = "B27001_007",
                                   "insurance_with_25_male" = "B27001_010",
                                   "insurance_with_34_male" = "B27001_013",
                                   "insurance_with_44_male" = "B27001_016",
                                   "insurance_with_54_male" = "B27001_019",
                                   "insurance_with_64_male" = "B27001_022",
                                   "insurance_with_74_male" = "B27001_025",
                                   "insurance_with_75_male" = "B27001_028",
                                   "insurance_with_06_fmle" = "B27001_032",
                                   "insurance_with_18_fmle" = "B27001_035",
                                   "insurance_with_25_fmle" = "B27001_038",
                                   "insurance_with_34_fmle" = "B27001_041",
                                   "insurance_with_44_fmle" = "B27001_044",
                                   "insurance_with_54_fmle" = "B27001_047",
                                   "insurance_with_64_fmle" = "B27001_050",
                                   "insurance_with_74_fmle" = "B27001_053",
                                   "insurance_with_75_fmle" = "B27001_056",
                                   "total_sex_age" = "B01001_001",
                                   "total_sexm_age05" = "B01001_003",
                                   "total_sexm_age09" = "B01001_004",
                                   "total_sexm_age14" = "B01001_005",
                                   "total_sexm_age17" = "B01001_006",
                                   "total_sexm_age19" = "B01001_007",
                                   "total_sexm_age20" = "B01001_008",
                                   "total_sexm_age21" = "B01001_009",
                                   "total_sexm_age24" = "B01001_010",
                                   "total_sexm_age29" = "B01001_011",
                                   "total_sexm_age34" = "B01001_012",
                                   "total_sexm_age39" = "B01001_013",
                                   "total_sexm_age44" = "B01001_014",
                                   "total_sexm_age49" = "B01001_015",
                                   "total_sexm_age54" = "B01001_016",
                                   "total_sexm_age59" = "B01001_017",
                                   "total_sexm_age61" = "B01001_018",
                                   "total_sexm_age64" = "B01001_019",
                                   "total_sexm_age66" = "B01001_020",
                                   "total_sexm_age69" = "B01001_021",
                                   "total_sexm_age74" = "B01001_022",
                                   "total_sexm_age79" = "B01001_023",
                                   "total_sexm_age84" = "B01001_024",
                                   "total_sexm_age85" = "B01001_025",
                                   "total_sexf_age05" = "B01001_027",
                                   "total_sexf_age09" = "B01001_028",
                                   "total_sexf_age14" = "B01001_029",
                                   "total_sexf_age17" = "B01001_030",
                                   "total_sexf_age19" = "B01001_031",
                                   "total_sexf_age20" = "B01001_032",
                                   "total_sexf_age21" = "B01001_033",
                                   "total_sexf_age24" = "B01001_034",
                                   "total_sexf_age29" = "B01001_035",
                                   "total_sexf_age34" = "B01001_036",
                                   "total_sexf_age39" = "B01001_037",
                                   "total_sexf_age44" = "B01001_038",
                                   "total_sexf_age49" = "B01001_039",
                                   "total_sexf_age54" = "B01001_040",
                                   "total_sexf_age59" = "B01001_041",
                                   "total_sexf_age61" = "B01001_042",
                                   "total_sexf_age64" = "B01001_043",
                                   "total_sexf_age66" = "B01001_044",
                                   "total_sexf_age69" = "B01001_045",
                                   "total_sexf_age74" = "B01001_046",
                                   "total_sexf_age79" = "B01001_047",
                                   "total_sexf_age84" = "B01001_048",
                                   "total_sexf_age85" = "B01001_049"),
                     output = "wide") %>%
  mutate(geography = "county subdivision")


vt_tracts <- get_acs(geography = "tract",
                     state = "VT",
                     county = "Addison",
                     variables = c("population" = "B01003_001",
                                   "median_hh_income" = "B19013_001",
                                   "poverty_total" = "B17001_001",
                                   "poverty_below" = "B17001_002",
                                   "poverty_level_total" = "C17002_001",
                                   "poverty_level_below_fiftypercent" = "C17002_002",
                                   "poverty_level_above_fiftypercent" = "C17002_003",
                                   "snap_total" = "B22002_001",
                                   "snap_received" = "B22002_002",
                                   "snap_received_children" = "B22002_003",
                                   "snap_not_received_children" = "B22002_016",
                                   "housing_total" = "B25003_001",
                                   "housing_owned" = "B25003_002",
                                   "housing_rented" = "B25003_003",
                                   "educ_total" = "B15003_001",
                                   "educ_hs" = "B15003_017",
                                   "educ_ged" = "B15003_018",
                                   "educ_somecoll_less1" = "B15003_019",
                                   "educ_somecoll_more1" = "B15003_020",
                                   "educ_associates" = "B15003_021",
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
                                   "foreign_born" = "B05002_013",
                                   "insurance_none_06_male" = "B27001_005",
                                   "insurance_none_18_male" = "B27001_008",
                                   "insurance_none_25_male" = "B27001_011",
                                   "insurance_none_34_male" = "B27001_014",
                                   "insurance_none_44_male" = "B27001_017",
                                   "insurance_none_54_male" = "B27001_020",
                                   "insurance_none_64_male" = "B27001_023",
                                   "insurance_none_74_male" = "B27001_026",
                                   "insurance_none_75_male" = "B27001_029",
                                   "insurance_none_06_fmle" = "B27001_033",
                                   "insurance_none_18_fmle" = "B27001_036",
                                   "insurance_none_25_fmle" = "B27001_039",
                                   "insurance_none_34_fmle" = "B27001_042",
                                   "insurance_none_44_fmle" = "B27001_045",
                                   "insurance_none_54_fmle" = "B27001_048",
                                   "insurance_none_64_fmle" = "B27001_051",
                                   "insurance_none_74_fmle" = "B27001_054",
                                   "insurance_none_75_fmle" = "B27001_057",
                                   "insurance_with_06_male" = "B27001_004",
                                   "insurance_with_18_male" = "B27001_007",
                                   "insurance_with_25_male" = "B27001_010",
                                   "insurance_with_34_male" = "B27001_013",
                                   "insurance_with_44_male" = "B27001_016",
                                   "insurance_with_54_male" = "B27001_019",
                                   "insurance_with_64_male" = "B27001_022",
                                   "insurance_with_74_male" = "B27001_025",
                                   "insurance_with_75_male" = "B27001_028",
                                   "insurance_with_06_fmle" = "B27001_032",
                                   "insurance_with_18_fmle" = "B27001_035",
                                   "insurance_with_25_fmle" = "B27001_038",
                                   "insurance_with_34_fmle" = "B27001_041",
                                   "insurance_with_44_fmle" = "B27001_044",
                                   "insurance_with_54_fmle" = "B27001_047",
                                   "insurance_with_64_fmle" = "B27001_050",
                                   "insurance_with_74_fmle" = "B27001_053",
                                   "insurance_with_75_fmle" = "B27001_056",
                                   "total_sex_age" = "B01001_001",
                                   "total_sexm_age05" = "B01001_003",
                                   "total_sexm_age09" = "B01001_004",
                                   "total_sexm_age14" = "B01001_005",
                                   "total_sexm_age17" = "B01001_006",
                                   "total_sexm_age19" = "B01001_007",
                                   "total_sexm_age20" = "B01001_008",
                                   "total_sexm_age21" = "B01001_009",
                                   "total_sexm_age24" = "B01001_010",
                                   "total_sexm_age29" = "B01001_011",
                                   "total_sexm_age34" = "B01001_012",
                                   "total_sexm_age39" = "B01001_013",
                                   "total_sexm_age44" = "B01001_014",
                                   "total_sexm_age49" = "B01001_015",
                                   "total_sexm_age54" = "B01001_016",
                                   "total_sexm_age59" = "B01001_017",
                                   "total_sexm_age61" = "B01001_018",
                                   "total_sexm_age64" = "B01001_019",
                                   "total_sexm_age66" = "B01001_020",
                                   "total_sexm_age69" = "B01001_021",
                                   "total_sexm_age74" = "B01001_022",
                                   "total_sexm_age79" = "B01001_023",
                                   "total_sexm_age84" = "B01001_024",
                                   "total_sexm_age85" = "B01001_025",
                                   "total_sexf_age05" = "B01001_027",
                                   "total_sexf_age09" = "B01001_028",
                                   "total_sexf_age14" = "B01001_029",
                                   "total_sexf_age17" = "B01001_030",
                                   "total_sexf_age19" = "B01001_031",
                                   "total_sexf_age20" = "B01001_032",
                                   "total_sexf_age21" = "B01001_033",
                                   "total_sexf_age24" = "B01001_034",
                                   "total_sexf_age29" = "B01001_035",
                                   "total_sexf_age34" = "B01001_036",
                                   "total_sexf_age39" = "B01001_037",
                                   "total_sexf_age44" = "B01001_038",
                                   "total_sexf_age49" = "B01001_039",
                                   "total_sexf_age54" = "B01001_040",
                                   "total_sexf_age59" = "B01001_041",
                                   "total_sexf_age61" = "B01001_042",
                                   "total_sexf_age64" = "B01001_043",
                                   "total_sexf_age66" = "B01001_044",
                                   "total_sexf_age69" = "B01001_045",
                                   "total_sexf_age74" = "B01001_046",
                                   "total_sexf_age79" = "B01001_047",
                                   "total_sexf_age84" = "B01001_048",
                                   "total_sexf_age85" = "B01001_049"),
                     output = "wide") %>%
  mutate(geography = "census tract")


vermont_us <- rbind(country, states_all, vt_state, vt_county, vt_county_subdivisions, vt_tracts)

vermont_us <- select(vermont_us, !ends_with("M"))

vermont_us <- left_join(vermont_us, county_homeless, by = "NAME")

vermont_us <- left_join(vermont_us, county_geo, by = "GEOID")


vermont_us_nomoe <- vermont_us %>%
  mutate(poverty_rate_total = round(((poverty_belowE / poverty_totalE) * 100),1),
         poverty_rate_deep = round(((poverty_level_below_fiftypercentE / poverty_level_totalE) * 100),1),
         poverty_rate_notdeep = round(((poverty_level_above_fiftypercentE / poverty_level_totalE) * 100),1),
         snap_rate_total = round(((snap_receivedE / snap_totalE) * 100),1),
         snap_rate_children = round(((snap_received_childrenE / (snap_received_childrenE + 
                                                           snap_not_received_childrenE)) * 100),1),
         housing_owner_occupied = round(((housing_ownedE / housing_totalE) * 100),1),
         educ_hs_plus = round((((educ_hsE + educ_gedE + educ_somecoll_less1E + educ_somecoll_more1E +
                                   educ_associatesE + educ_bachelorsE + educ_mastersE + educ_professionalE + educ_doctorateE) / 
                                  educ_totalE) * 100),1),
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
         foreign_born = round(((foreign_bornE / foreign_born_totalE)*100),1),
         has_health_insurance = round(((rowSums(.[59:76]) / rowSums(.[41:76])) * 100),1),
         age_under18 = round((((total_sexm_age05E + total_sexm_age09E + total_sexm_age14E + total_sexm_age17E +
                                 total_sexf_age05E + total_sexf_age09E + total_sexf_age14E + total_sexf_age17E) / 
                                 total_sex_ageE)*100),1),
         age_18_24 = round((((total_sexm_age19E + total_sexm_age20E + total_sexm_age21E + total_sexm_age24E +
                                total_sexf_age19E + total_sexf_age20E + total_sexf_age21E + total_sexf_age24E) /
                               total_sex_ageE)*100),1),
         age_25_34 = round((((total_sexm_age29E + total_sexm_age34E + total_sexf_age29E + total_sexf_age34E) /
                               total_sex_ageE)*100),1),
         age_35_54 = round((((total_sexm_age39E + total_sexm_age44E + total_sexm_age49E + total_sexm_age54E +
                                total_sexf_age39E + total_sexf_age44E + total_sexf_age49E + total_sexf_age54E) /
                               total_sex_ageE)*100),1),
         age_55_64 = round((((total_sexm_age59E + total_sexm_age61E + total_sexm_age64E  +
                                total_sexf_age59E + total_sexf_age61E + total_sexf_age64E) /
                               total_sex_ageE)*100),1),
         age_over65 = round((((total_sexm_age66E + total_sexm_age69E + total_sexm_age74E + 
                                 total_sexm_age79E + total_sexm_age84E + total_sexm_age85E +
                                 total_sexf_age66E + total_sexf_age69E + total_sexf_age74E + 
                                 total_sexf_age79E + total_sexf_age84E + total_sexf_age85E) /
                                total_sex_ageE)*100),1)) %>%
         rename(population = populationE,
         median_hh_income = median_hh_incomeE) %>%
         mutate(short_name = NAME) %>%
  separate(short_name, c("short_name", "extra"), sep = " town") %>%
  separate(short_name, c("short_name", "extra"), sep = " city") %>%
  separate(short_name, c("short_name", "extra"), sep = ", Vermont") %>%
  separate(short_name, c("short_name", "extra"), sep = ", Addison") %>%
  separate(short_name, c("short_name", "extra"), sep = " County") %>%
  select(-extra) %>%
  mutate(short_name = ifelse(grepl("9601", short_name), "Starksboro, Monkton", 
                             ifelse(grepl("9602", short_name), "Ferrisburgh",
                                    ifelse(grepl("9603", short_name), "Vergennes",
                                                 ifelse(grepl("9604", short_name), "Panton, Addison, Weybridge, New Haven", 
                                                              ifelse(grepl("9605", short_name), "Bristol",
                                                                     ifelse(grepl("9606", short_name), "Lincoln, Ripton, Granville, Hancock, Goshen", 
                                                                            ifelse(grepl("9607", short_name), "Middlebury East of Route 7", 
                                                                                   ifelse(grepl("9608", short_name), "Middlebury West of Route 7",
                                                                                          ifelse(grepl("9609", short_name), "Cornwall, Shoreham, Bridport, Orwell, Whiting",
                                                                                                 ifelse(grepl("9610", short_name), "Salisbury, Leicster", short_name))))))))))) %>%
   mutate(datawrapper_id = GEOID) %>%
  mutate(datawrapper_id = ifelse(geography=="county", str_sub(GEOID, 3, 6), 
                                 ifelse(geography=="census tract", str_sub(GEOID, 3, 11), GEOID))) %>%
  select(GEOID, datawrapper_id, geography, NAME, short_name, latitude, longitude, population, age_under18:age_over65, median_hh_income,
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep, snap_rate_total, snap_rate_children,
         housing_owner_occupied, educ_hs_plus, educ_ba_plus, employment_rate_civilian,
         race_white:race_hispanic, foreign_born, has_health_insurance,
         all_of(names_county_homeless)) %>%
  arrange(desc(geography), datawrapper_id) %>%
  filter(short_name != "East Middlebury")

names(vermont_us_nomoe) <- tolower(names(vermont_us_nomoe))

vermont_us_nomoe$geoid <- as.character(vermont_us_nomoe$geoid)

vermont_us_nomoe$datawrapper_id <- as.character(vermont_us_nomoe$datawrapper_id)

write.csv(vermont_us_nomoe, "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/acs_stats.csv",
          row.names = FALSE)


## StoryMap Data Links

geography_variables <- c("geoid", "geography", "name", "short_name", 
                         "latitude", "longitude")

# Population for US, Vermont, Counties
population_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), population)

write.csv(population_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/population_us_vt_counties.csv",
          row.names = FALSE)

# Population for Counties
population_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("county")) %>% 
  select(all_of(geography_variables), population)

write.csv(population_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/population_counties.csv",
          row.names = FALSE)

# Population by age for US, Vermont, Counties
population_age_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), age_under18:age_over65)

write.csv(population_age_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/population_age_us_vt_counties.csv",
          row.names = FALSE)

# Race for US, Vermont, Counties
race_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), race_white:race_hispanic)

write.csv(race_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/race_age_us_vt_counties.csv",
          row.names = FALSE)

# Foreign born for US, Vermont, Counties
foreign_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), foreign_born)

write.csv(foreign_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/foreign_age_us_vt_counties.csv",
          row.names = FALSE)

# Median Income for Counties
income_county <- vermont_us_nomoe %>%
  filter(geography == "county") %>%
  select(all_of(geography_variables), median_hh_income)

write.csv(income_county, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/income_county.csv",
          row.names = FALSE)

# Poverty rate for US, Vermont, Counties
poverty_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), 
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep)

write.csv(poverty_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/poverty_us_vt_counties.csv",
          row.names = FALSE)

# Education for US, Vermont, Counties
education_us_vt_counties <- vermont_us_nomoe %>%
  filter(geography %in% c("us", "state_vt", "county")) %>% 
  select(all_of(geography_variables), 
         educ_hs_plus, educ_ba_plus)

write.csv(education_us_vt_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/education_us_vt_counties.csv",
          row.names = FALSE)

# Homeless for Counties
homeless_counties <- vermont_us_nomoe %>%
  filter(geography == "county") %>% 
  select(all_of(geography_variables), homeless_count_total_individuals,
         homeless_count_total_adults, homeless_count_total_children,
         starts_with("homeless_count_gender"), starts_with("homeless_count_location"))

write.csv(homeless_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/homeless_counties.csv",
          row.names = FALSE)

# Population for Towns
population_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), population)

write.csv(population_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/population_towns.csv",
          row.names = FALSE)

# Population by age for towns
population_age_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), age_under18:age_over65)

write.csv(population_age_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/population_age_towns.csv",
          row.names = FALSE)

# Race for towns
race_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), race_white:race_hispanic)

write.csv(race_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/race_towns.csv",
          row.names = FALSE)

# Foreign born for towns
foreign_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), foreign_born)

write.csv(foreign_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/foreign_towns.csv",
          row.names = FALSE)
  
# Median Income for Towns
income_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>%
  select(all_of(geography_variables), median_hh_income)

write.csv(income_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/income_towns.csv",
          row.names = FALSE)


# Umployment Rate for Towns
unemployment_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>%
  mutate(unemployment_rate = 100 - employment_rate_civilian) %>%
  select(all_of(geography_variables), unemployment_rate) 

write.csv(unemployment_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/unemployment_towns.csv",
          row.names = FALSE)

# Poverty rate for towns
poverty_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), 
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep)

write.csv(poverty_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/poverty_towns.csv",
          row.names = FALSE)

# Education for towns
education_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), 
         educ_hs_plus, educ_ba_plus)

write.csv(education_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/education_towns.csv",
          row.names = FALSE)

# SNAP for towns
snap_towns <- vermont_us_nomoe %>%
  filter(geography == "county subdivision") %>% 
  select(all_of(geography_variables), 
         snap_rate_total, snap_rate_children)

write.csv(snap_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/snap_towns.csv",
          row.names = FALSE)



vermont_us_race <- vermont_us_nomoe %>%
  select(geoid, datawrapper_id, geography, name, short_name, race_white:race_hispanic) %>%
  gather(race, percent, race_white:race_hispanic) %>%
  separate(race, c("race", "category", sep = "race_")) %>%
  select(-c("race", "race_")) %>%
  arrange(desc(geography), datawrapper_id)

vermont_us_race$geoid <- as.character(vermont_us_race$geoid)

vermont_us_race$datawrapper_id <- as.character(vermont_us_race$datawrapper_id)


write.csv(vermont_us_race, "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/acs_stats_race_long.csv")










## Housing

housing_variables <- get_acs(geography = "county",
                             state = "VT",
                             variables = c(
                             hhinc_renttot = "B25074_001",
                             hhinc10_rentall = "B25074_002",
                             hhinc10_rent200 = "B25074_003",
                             hhinc10_rent249 = "B25074_004",
                             hhinc10_rent299 = "B25074_005",
                             hhinc10_rent349 = "B25074_006",
                             hhinc10_rent399 = "B25074_007",
                             hhinc10_rent499 = "B25074_008",
                             hhinc10_rent500 = "B25074_009",
                             hhinc10_rentnot = "B25074_010",
                             hhinc19_rentall = "B25074_011",
                             hhinc19_rent200 = "B25074_012",
                             hhinc19_rent249 = "B25074_013",
                             hhinc19_rent299 = "B25074_014",
                             hhinc19_rent349 = "B25074_015",
                             hhinc19_rent399 = "B25074_016",
                             hhinc19_rent499 = "B25074_017",
                             hhinc19_rent500 = "B25074_018",
                             hhinc19_rentnot = "B25074_019",
                             hhinc34_rentall = "B25074_020",
                             hhinc34_rent200 = "B25074_021",
                             hhinc34_rent249 = "B25074_022",
                             hhinc34_rent299 = "B25074_023",
                             hhinc34_rent349 = "B25074_024",
                             hhinc34_rent399 = "B25074_025",
                             hhinc34_rent499 = "B25074_026",
                             hhinc34_rent500 = "B25074_027",
                             hhinc34_rentnot = "B25074_028",
                             hhinc49_rentall = "B25074_029",
                             hhinc49_rent200 = "B25074_030",
                             hhinc49_rent249 = "B25074_031",
                             hhinc49_rent299 = "B25074_032",
                             hhinc49_rent349 = "B25074_033",
                             hhinc49_rent399 = "B25074_034",
                             hhinc49_rent499 = "B25074_035",
                             hhinc49_rent500 = "B25074_036",
                             hhinc49_rentnot = "B25074_037",
                             hhinc74_rentall = "B25074_038",
                             hhinc74_rent200 = "B25074_039",
                             hhinc74_rent249 = "B25074_040",
                             hhinc74_rent299 = "B25074_041",
                             hhinc74_rent349 = "B25074_042",
                             hhinc74_rent399 = "B25074_043",
                             hhinc74_rent499 = "B25074_044",
                             hhinc74_rent500 = "B25074_045",
                             hhinc74_rentnot = "B25074_046",
                             hhinc99_rentall = "B25074_047",
                             hhinc99_rent200 = "B25074_048",
                             hhinc99_rent249 = "B25074_049",
                             hhinc99_rent299 = "B25074_050",
                             hhinc99_rent349 = "B25074_051",
                             hhinc99_rent399 = "B25074_052",
                             hhinc99_rent499 = "B25074_053",
                             hhinc99_rent500 = "B25074_054",
                             hhinc99_rentnot = "B25074_055",
                             hhinc100_rentall = "B25074_056",
                             hhinc100_rent200 = "B25074_057",
                             hhinc100_rent249 = "B25074_058",
                             hhinc100_rent299 = "B25074_059",
                             hhinc100_rent349 = "B25074_060",
                             hhinc100_rent399 = "B25074_061",
                             hhinc100_rent499 = "B25074_062",
                             hhinc100_rent500 = "B25074_063",
                             hhinc100_rentnot = "B25074_064",
                             hhinc_owndtot = "B25095_001",
                             hhinc10_owndall = "B25095_002",
                             hhinc10_ownd200 = "B25095_003",
                             hhinc10_ownd249 = "B25095_004",
                             hhinc10_ownd299 = "B25095_005",
                             hhinc10_ownd349 = "B25095_006",
                             hhinc10_ownd399 = "B25095_007",
                             hhinc10_ownd499 = "B25095_008",
                             hhinc10_ownd500 = "B25095_009",
                             hhinc10_owndnot = "B25095_010",
                             hhinc19_owndall = "B25095_011",
                             hhinc19_ownd200 = "B25095_012",
                             hhinc19_ownd249 = "B25095_013",
                             hhinc19_ownd299 = "B25095_014",
                             hhinc19_ownd349 = "B25095_015",
                             hhinc19_ownd399 = "B25095_016",
                             hhinc19_ownd499 = "B25095_017",
                             hhinc19_ownd500 = "B25095_018",
                             hhinc19_owndnot = "B25095_019",
                             hhinc34_owndall = "B25095_020",
                             hhinc34_ownd200 = "B25095_021",
                             hhinc34_ownd249 = "B25095_022",
                             hhinc34_ownd299 = "B25095_023",
                             hhinc34_ownd349 = "B25095_024",
                             hhinc34_ownd399 = "B25095_025",
                             hhinc34_ownd499 = "B25095_026",
                             hhinc34_ownd500 = "B25095_027",
                             hhinc34_owndnot = "B25095_028",
                             hhinc49_owndall = "B25095_029",
                             hhinc49_ownd200 = "B25095_030",
                             hhinc49_ownd249 = "B25095_031",
                             hhinc49_ownd299 = "B25095_032",
                             hhinc49_ownd349 = "B25095_033",
                             hhinc49_ownd399 = "B25095_034",
                             hhinc49_ownd499 = "B25095_035",
                             hhinc49_ownd500 = "B25095_036",
                             hhinc49_owndnot = "B25095_037",
                             hhinc74_owndall = "B25095_038",
                             hhinc74_ownd200 = "B25095_039",
                             hhinc74_ownd249 = "B25095_040",
                             hhinc74_ownd299 = "B25095_041",
                             hhinc74_ownd349 = "B25095_042",
                             hhinc74_ownd399 = "B25095_043",
                             hhinc74_ownd499 = "B25095_044",
                             hhinc74_ownd500 = "B25095_045",
                             hhinc74_owndnot = "B25095_046",
                             hhinc99_owndall = "B25095_047",
                             hhinc99_ownd200 = "B25095_048",
                             hhinc99_ownd249 = "B25095_049",
                             hhinc99_ownd299 = "B25095_050",
                             hhinc99_ownd349 = "B25095_051",
                             hhinc99_ownd399 = "B25095_052",
                             hhinc99_ownd499 = "B25095_053",
                             hhinc99_ownd500 = "B25095_054",
                             hhinc99_owndnot = "B25095_055",
                             hhinc100_owndall = "B25095_056",
                             hhinc100_ownd200 = "B25095_057",
                             hhinc100_ownd249 = "B25095_058",
                             hhinc100_ownd299 = "B25095_059",
                             hhinc100_ownd349 = "B25095_060",
                             hhinc100_ownd399 = "B25095_061",
                             hhinc100_ownd499 = "B25095_062",
                             hhinc100_ownd500 = "B25095_063",
                             hhinc100_owndnot = "B25095_064",
                             hhinc150_owndall = "B25095_065",
                             hhinc150_ownd200 = "B25095_066",
                             hhinc150_ownd249 = "B25095_067",
                             hhinc150_ownd299 = "B25095_068",
                             hhinc150_ownd349 = "B25095_069",
                             hhinc150_ownd399 = "B25095_070",
                             hhinc150_ownd499 = "B25095_071",
                             hhinc150_ownd500 = "B25095_072",
                             hhinc150_owndnot = "B25095_073"
                             ))


housing_variables_cat <- housing_variables %>%
  mutate(variable_rev = variable) %>%
  mutate(variable_rev = str_replace(variable_rev, "hhinc10_", "hhinc19_"),
         variable_rev = str_replace(variable_rev, "hhinc99_", "hhinc75_"),
         variable_rev = str_replace(variable_rev, "hhinc100_", "hhinc75_"),
         variable_rev = str_replace(variable_rev, "hhinc150_", "hhinc75_")) %>%
  mutate(variable_rev = str_replace(variable_rev, "_rent249", "_rent299"),
         variable_rev = str_replace(variable_rev, "_rent349", "_rent300"),
         variable_rev = str_replace(variable_rev, "_rent399", "_rent300"),
         variable_rev = str_replace(variable_rev, "_rent499", "_rent300"),
         variable_rev = str_replace(variable_rev, "_rent500", "_rent300"),
         variable_rev = str_replace(variable_rev, "_ownd249", "_ownd299"),
         variable_rev = str_replace(variable_rev, "_ownd349", "_ownd300"),
         variable_rev = str_replace(variable_rev, "_ownd399", "_ownd300"),
         variable_rev = str_replace(variable_rev, "_ownd499", "_ownd300"),
         variable_rev = str_replace(variable_rev, "_ownd500", "_ownd300")) %>%
  separate(variable_rev, c("hhinc_cat", "type_pct"), sep = "_") %>%
  mutate(hhtype = str_sub(type_pct, 1, 4),
         pct = str_sub(type_pct, 5, 7)) %>%
  group_by(GEOID, hhinc_cat, pct) %>%
  mutate(estimate_cat = sum(estimate)) %>%
  ungroup()





#vt_zips <- c("05443", "05456", "05469", "05472", "05473", "05487", "05491", "05669", "05734", "05740", "05747", "05748", "05753", "05760", "05766", "05769", "05770", "05778")

# vt_zipcodes <- get_acs(geography = "zcta",
#                        variables = c("population" = "B01003_001",
#                                      "median_hh_income" = "B19013_001",
#                                      "poverty_total" = "B17001_001",
#                                      "poverty_below" = "B17001_002",
#                                      "poverty_level_total" = "C17002_001",
#                                      "poverty_level_below_fiftypercent" = "C17002_002",
#                                      "poverty_level_above_fiftypercent" = "C17002_003",
#                                      "snap_total" = "B22002_001",
#                                      "snap_received" = "B22002_002",
#                                      "snap_received_children" = "B22002_003",
#                                      "snap_not_received_children" = "B22002_016",
#                                      "housing_total" = "B25003_001",
#                                      "housing_owned" = "B25003_002",
#                                      "housing_rented" = "B25003_003",
#                                      "educ_total" = "B15003_001",
#                                      "educ_hs" = "B15003_017",
#                                      "educ_ged" = "B15003_018",
#                                      "educ_somecoll_less1" = "B15003_019",
#                                      "educ_somecoll_more1" = "B15003_020",
#                                      "educ_associates" = "B15003_021",
#                                      "educ_bachelors" = "B15003_022",
#                                      "educ_masters" = "B15003_023",
#                                      "educ_professional" = "B15003_024",
#                                      "educ_doctorate" = "B15003_025",
#                                      "laborforce_civilian_total" = "B23025_003",
#                                      "laborforce_civilian_employed" = "B23025_004",
#                                      "laborforce_civilian_unemployed" = "B23025_005",
#                                      "race_total" = "B03002_001",
#                                      "race_white" = "B03002_003",
#                                      "race_black" = "B03002_004",
#                                      "race_amindian" = "B03002_005",
#                                      "race_asian" = "B03002_006",
#                                      "race_nhpi" = "B03002_007",
#                                      "race_other" = "B03002_008",
#                                      "race_twoplus" = "B03002_011",
#                                      "race_hispanic" = "B03002_012",
#                                      "foreign_born_total" = "B05002_001",
#                                      "foreign_born" = "B05002_013",
#                                      "insurance_none_06_male" = "B27001_005",
#                                      "insurance_none_18_male" = "B27001_008",
#                                      "insurance_none_25_male" = "B27001_011",
#                                      "insurance_none_34_male" = "B27001_014",
#                                      "insurance_none_44_male" = "B27001_017",
#                                      "insurance_none_54_male" = "B27001_020",
#                                      "insurance_none_64_male" = "B27001_023",
#                                      "insurance_none_74_male" = "B27001_026",
#                                      "insurance_none_75_male" = "B27001_029",
#                                      "insurance_none_06_fmle" = "B27001_033",
#                                      "insurance_none_18_fmle" = "B27001_036",
#                                      "insurance_none_25_fmle" = "B27001_039",
#                                      "insurance_none_34_fmle" = "B27001_042",
#                                      "insurance_none_44_fmle" = "B27001_045",
#                                      "insurance_none_54_fmle" = "B27001_048",
#                                      "insurance_none_64_fmle" = "B27001_051",
#                                      "insurance_none_74_fmle" = "B27001_054",
#                                      "insurance_none_75_fmle" = "B27001_057",
#                                      "insurance_with_06_male" = "B27001_004",
#                                      "insurance_with_18_male" = "B27001_007",
#                                      "insurance_with_25_male" = "B27001_010",
#                                      "insurance_with_34_male" = "B27001_013",
#                                      "insurance_with_44_male" = "B27001_016",
#                                      "insurance_with_54_male" = "B27001_019",
#                                      "insurance_with_64_male" = "B27001_022",
#                                      "insurance_with_74_male" = "B27001_025",
#                                      "insurance_with_75_male" = "B27001_028",
#                                      "insurance_with_06_fmle" = "B27001_032",
#                                      "insurance_with_18_fmle" = "B27001_035",
#                                      "insurance_with_25_fmle" = "B27001_038",
#                                      "insurance_with_34_fmle" = "B27001_041",
#                                      "insurance_with_44_fmle" = "B27001_044",
#                                      "insurance_with_54_fmle" = "B27001_047",
#                                      "insurance_with_64_fmle" = "B27001_050",
#                                      "insurance_with_74_fmle" = "B27001_053",
#                                      "insurance_with_75_fmle" = "B27001_056"),
#                      output = "wide") %>%
#   filter(GEOID %in% vt_zips) %>%
#   mutate(geography = "zipcode")