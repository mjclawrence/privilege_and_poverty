library(tidyverse)
library(tidycensus)

states_all <- get_acs(geography = "state",
                        dataset = "acs5",
                        year = 2018,
                        variables = c("population" = "B01003_001",
                                      "median_hh_income" = "B19013_001",
                                      "poverty_total" = "B17001_001",
                                      "poverty_below" = "B17001_002",
                                      "poverty_level_total" = "C17002_001",
                                      "poverty_level_050" = "C17002_002",
                                      "poverty_level_099" = "C17002_003",
                                      "poverty_level_124" = "C17002_004",
                                      "poverty_level_149" = "C17002_005",
                                      "poverty_level_184" = "C17002_006",
                                      "poverty_level_199" = "C17002_007",
                                      "poverty_level_200" = "C17002_008",
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
                                      "total_sexf_age85" = "B01001_049",
                                      "poverty_level_age06_total" = "B17024_002",
                                      "poverty_level_050_age06" = "B17024_003",
                                      "poverty_level_074_age06" = "B17024_004",
                                      "poverty_level_099_age06" = "B17024_005",
                                      "poverty_level_age11_total" = "B17024_015",
                                      "poverty_level_050_age11" = "B17024_016",
                                      "poverty_level_074_age11" = "B17024_017",
                                      "poverty_level_099_age11" = "B17024_018",
                                      "poverty_level_age17_total" = "B17024_028",
                                      "poverty_level_050_age17" = "B17024_029",
                                      "poverty_level_074_age17" = "B17024_030",
                                      "poverty_level_099_age17" = "B17024_031",
                                      "poverty_race_white_total" = "B17001H_001",
                                      "poverty_race_black_total" = "B17001B_001",
                                      "poverty_race_amindian_total" = "B17001C_001",
                                      "poverty_race_asian_total" = "B17001D_001",
                                      "poverty_race_nhpi_total" = "B17001E_001",
                                      "poverty_race_other_total" = "B17001F_001",
                                      "poverty_race_twoplus_total" = "B17001G_001",
                                      "poverty_race_hispanic_total" = "B17001I_001",
                                      "poverty_race_white_below" = "B17001H_002",
                                      "poverty_race_black_below" = "B17001B_002",
                                      "poverty_race_amindian_below" = "B17001C_002",
                                      "poverty_race_asian_below" = "B17001D_002",
                                      "poverty_race_nhpi_below" = "B17001E_002",
                                      "poverty_race_other_below" = "B17001F_002",
                                      "poverty_race_twoplus_below" = "B17001G_002",
                                      "poverty_race_hispanic_below" = "B17001I_002",
                                      "poverty_below_sexm_total" = "B17001_003",
                                      "poverty_above_sexm_total" = "B17001_032",
                                      "poverty_below_sexf_total" = "B17001_017",
                                      "poverty_above_sexf_total" = "B17001_046",
                                      "poverty_below_family_related_children_married_couple" = "B17006_003",
                                      "poverty_below_family_related_children_unmarried_male" = "B17006_008",
                                      "poverty_below_family_related_children_unmarried_female" = "B17006_012",
                                      "poverty_above_family_related_children_married_couple" = "B17006_017",
                                      "poverty_above_family_related_children_unmarried_male" = "B17006_022",
                                      "poverty_above_family_related_children_unmarried_female" = "B17006_026"),
                        output = "wide") %>%
  mutate(geography = "state")

counties_all <- get_acs(geography = "county",
                     variables = c("population" = "B01003_001",
                                   "median_hh_income" = "B19013_001",
                                   "poverty_total" = "B17001_001",
                                   "poverty_below" = "B17001_002",
                                   "poverty_level_total" = "C17002_001",
                                   "poverty_level_050" = "C17002_002",
                                   "poverty_level_099" = "C17002_003",
                                   "poverty_level_124" = "C17002_004",
                                   "poverty_level_149" = "C17002_005",
                                   "poverty_level_184" = "C17002_006",
                                   "poverty_level_199" = "C17002_007",
                                   "poverty_level_200" = "C17002_008",
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
                                   "total_sexf_age85" = "B01001_049",
                                   "poverty_level_age06_total" = "B17024_002",
                                   "poverty_level_050_age06" = "B17024_003",
                                   "poverty_level_074_age06" = "B17024_004",
                                   "poverty_level_099_age06" = "B17024_005",
                                   "poverty_level_age11_total" = "B17024_015",
                                   "poverty_level_050_age11" = "B17024_016",
                                   "poverty_level_074_age11" = "B17024_017",
                                   "poverty_level_099_age11" = "B17024_018",
                                   "poverty_level_age17_total" = "B17024_028",
                                   "poverty_level_050_age17" = "B17024_029",
                                   "poverty_level_074_age17" = "B17024_030",
                                   "poverty_level_099_age17" = "B17024_031",
                                   "poverty_race_white_total" = "B17001H_001",
                                   "poverty_race_black_total" = "B17001B_001",
                                   "poverty_race_amindian_total" = "B17001C_001",
                                   "poverty_race_asian_total" = "B17001D_001",
                                   "poverty_race_nhpi_total" = "B17001E_001",
                                   "poverty_race_other_total" = "B17001F_001",
                                   "poverty_race_twoplus_total" = "B17001G_001",
                                   "poverty_race_hispanic_total" = "B17001I_001",
                                   "poverty_race_white_below" = "B17001H_002",
                                   "poverty_race_black_below" = "B17001B_002",
                                   "poverty_race_amindian_below" = "B17001C_002",
                                   "poverty_race_asian_below" = "B17001D_002",
                                   "poverty_race_nhpi_below" = "B17001E_002",
                                   "poverty_race_other_below" = "B17001F_002",
                                   "poverty_race_twoplus_below" = "B17001G_002",
                                   "poverty_race_hispanic_below" = "B17001I_002",
                                   "poverty_below_sexm_total" = "B17001_003",
                                   "poverty_above_sexm_total" = "B17001_032",
                                   "poverty_below_sexf_total" = "B17001_017",
                                   "poverty_above_sexf_total" = "B17001_046",
                                   "poverty_below_family_related_children_married_couple" = "B17006_003",
                                   "poverty_below_family_related_children_unmarried_male" = "B17006_008",
                                   "poverty_below_family_related_children_unmarried_female" = "B17006_012",
                                   "poverty_above_family_related_children_married_couple" = "B17006_017",
                                   "poverty_above_family_related_children_unmarried_male" = "B17006_022",
                                   "poverty_above_family_related_children_unmarried_female" = "B17006_026"),
                     output = "wide") %>%
  mutate(geography = "county")

towns_all <- get_acs(geography = "county subdivision",
                     state = "VT",
                        variables = c("population" = "B01003_001",
                                      "median_hh_income" = "B19013_001",
                                      "poverty_total" = "B17001_001",
                                      "poverty_below" = "B17001_002",
                                      "poverty_level_total" = "C17002_001",
                                      "poverty_level_050" = "C17002_002",
                                      "poverty_level_099" = "C17002_003",
                                      "poverty_level_124" = "C17002_004",
                                      "poverty_level_149" = "C17002_005",
                                      "poverty_level_184" = "C17002_006",
                                      "poverty_level_199" = "C17002_007",
                                      "poverty_level_200" = "C17002_008",
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
                                      "total_sexf_age85" = "B01001_049",
                                      "poverty_level_age06_total" = "B17024_002",
                                      "poverty_level_050_age06" = "B17024_003",
                                      "poverty_level_074_age06" = "B17024_004",
                                      "poverty_level_099_age06" = "B17024_005",
                                      "poverty_level_age11_total" = "B17024_015",
                                      "poverty_level_050_age11" = "B17024_016",
                                      "poverty_level_074_age11" = "B17024_017",
                                      "poverty_level_099_age11" = "B17024_018",
                                      "poverty_level_age17_total" = "B17024_028",
                                      "poverty_level_050_age17" = "B17024_029",
                                      "poverty_level_074_age17" = "B17024_030",
                                      "poverty_level_099_age17" = "B17024_031",
                                      "poverty_race_white_total" = "B17001H_001",
                                      "poverty_race_black_total" = "B17001B_001",
                                      "poverty_race_amindian_total" = "B17001C_001",
                                      "poverty_race_asian_total" = "B17001D_001",
                                      "poverty_race_nhpi_total" = "B17001E_001",
                                      "poverty_race_other_total" = "B17001F_001",
                                      "poverty_race_twoplus_total" = "B17001G_001",
                                      "poverty_race_hispanic_total" = "B17001I_001",
                                      "poverty_race_white_below" = "B17001H_002",
                                      "poverty_race_black_below" = "B17001B_002",
                                      "poverty_race_amindian_below" = "B17001C_002",
                                      "poverty_race_asian_below" = "B17001D_002",
                                      "poverty_race_nhpi_below" = "B17001E_002",
                                      "poverty_race_other_below" = "B17001F_002",
                                      "poverty_race_twoplus_below" = "B17001G_002",
                                      "poverty_race_hispanic_below" = "B17001I_002",
                                      "poverty_below_sexm_total" = "B17001_003",
                                      "poverty_above_sexm_total" = "B17001_032",
                                      "poverty_below_sexf_total" = "B17001_017",
                                      "poverty_above_sexf_total" = "B17001_046",
                                      "poverty_below_family_related_children_married_couple" = "B17006_003",
                                      "poverty_below_family_related_children_unmarried_male" = "B17006_008",
                                      "poverty_below_family_related_children_unmarried_female" = "B17006_012",
                                      "poverty_above_family_related_children_married_couple" = "B17006_017",
                                      "poverty_above_family_related_children_unmarried_male" = "B17006_022",
                                      "poverty_above_family_related_children_unmarried_female" = "B17006_026"),
                        output = "wide") %>%
  mutate(geography = "county subdivision")

all_counties_states <- rbind(states_all, counties_all, towns_all)

all_counties_states <- select(all_counties_states, !ends_with("M"))


all_counties_states_nomoe <- all_counties_states %>%
  mutate(poverty_rate_total = round(((poverty_belowE / poverty_totalE) * 100),1),
         poverty_rate_deep = round(((poverty_level_050E / poverty_level_totalE) * 100),1),
         poverty_rate_notdeep = round(((poverty_level_099E / poverty_level_totalE) * 100),1),
         poverty_level_below_050 = round(((poverty_level_050E / poverty_level_totalE) * 100), 1),
         poverty_level_050_099 = round(((poverty_level_099E / poverty_level_totalE) * 100), 1),
         poverty_level_100_124 = round(((poverty_level_124E / poverty_level_totalE) * 100), 1),
         poverty_level_125_149 = round(((poverty_level_149E / poverty_level_totalE) * 100), 1),
         poverty_level_150_184 = round(((poverty_level_184E / poverty_level_totalE) * 100), 1),
         poverty_level_185_199 = round(((poverty_level_199E / poverty_level_totalE) * 100), 1),
         poverty_level_above_200 = round(((poverty_level_200E / poverty_level_totalE) * 100), 1),
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
         has_health_insurance = round(((rowSums(.[64:81]) / rowSums(.[46:81])) * 100),1),
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
                                total_sex_ageE)*100),1),
         child_poverty_rate_total = round((((poverty_level_050_age06E + poverty_level_074_age06E + poverty_level_099_age06E +
                                               poverty_level_050_age11E + poverty_level_074_age11E + poverty_level_099_age11E +
                                               poverty_level_050_age17E + poverty_level_074_age17E + poverty_level_099_age17E) /
                                              (poverty_level_age06_totalE + 
                                                 poverty_level_age11_totalE + 
                                                 poverty_level_age17_totalE)) * 100),1),
         child_poverty_rate_deep = round((((poverty_level_050_age06E + poverty_level_050_age11E + poverty_level_050_age17E) /
                                             (poverty_level_age06_totalE + 
                                                poverty_level_age11_totalE + 
                                                poverty_level_age17_totalE)) * 100),1),
         child_poverty_rate_notdeep = round((((poverty_level_074_age06E + poverty_level_099_age06E +
                                                 poverty_level_074_age11E + poverty_level_099_age11E +
                                                 poverty_level_074_age17E + poverty_level_099_age17E) /
                                                (poverty_level_age06_totalE + 
                                                   poverty_level_age11_totalE + 
                                                   poverty_level_age17_totalE)) * 100),1),
         poverty_rate_race_white = round(((poverty_race_white_belowE / poverty_race_white_totalE)*100),1),
         poverty_rate_race_black = round(((poverty_race_black_belowE / poverty_race_black_totalE)*100),1),
         poverty_rate_race_nhpi_amind = round(((poverty_race_nhpi_belowE + poverty_race_amindian_belowE) / 
                                                 (poverty_race_nhpi_totalE + poverty_race_amindian_totalE)*100),1),
         poverty_rate_race_asian = round(((poverty_race_asian_belowE / poverty_race_asian_totalE)*100),1),
         poverty_rate_race_other = round(((poverty_race_other_belowE / poverty_race_other_totalE)*100),1),
         poverty_rate_race_twoplus = round(((poverty_race_twoplus_belowE / poverty_race_twoplus_totalE)*100),1),
         poverty_rate_race_hispanic = round(((poverty_race_hispanic_belowE / poverty_race_hispanic_totalE)*100),1),
         poverty_rate_sex_male = round(((poverty_below_sexm_totalE / 
                                           (poverty_below_sexm_totalE + poverty_above_sexm_totalE))*100),1),
         poverty_rate_sex_female = round(((poverty_below_sexf_totalE / 
                                             (poverty_below_sexf_totalE + poverty_above_sexf_totalE))*100),1),
         child_poverty_family_married_couple = round(((poverty_below_family_related_children_married_coupleE/
                                                         (poverty_below_family_related_children_married_coupleE +
                                                            poverty_above_family_related_children_married_coupleE))*100),1),
         child_poverty_family_unmarried_male = round(((poverty_below_family_related_children_unmarried_maleE/
                                                         (poverty_below_family_related_children_unmarried_maleE +
                                                            poverty_above_family_related_children_unmarried_maleE))*100),1),
         child_poverty_family_unmarried_female = round(((poverty_below_family_related_children_unmarried_femaleE/
                                                           (poverty_below_family_related_children_unmarried_femaleE +
                                                              poverty_above_family_related_children_unmarried_femaleE))*100),1),
         poverty_rate_race_notwhite = round((((poverty_race_black_belowE + poverty_race_nhpi_belowE + 
                                                poverty_race_asian_belowE + poverty_race_other_belowE +
                                                poverty_race_twoplus_belowE + poverty_race_hispanic_belowE) /
                                               (poverty_race_black_totalE + poverty_race_nhpi_totalE + 
                                               poverty_race_asian_totalE + poverty_race_other_totalE +
                                               poverty_race_twoplus_totalE + poverty_race_hispanic_totalE)) * 100), 1),
         poverty_rate_notwhite_vs_white = round((poverty_rate_race_notwhite - poverty_rate_race_white),1)) %>%
  rename(population = populationE,
         median_hh_income = median_hh_incomeE) %>%
  mutate(short_name = NAME) %>%
  mutate(datawrapper_id = GEOID) %>%
  mutate(datawrapper_id = ifelse(geography=="county", str_sub(GEOID, 3, 6), 
                                 ifelse(geography=="census tract", str_sub(GEOID, 3, 11), GEOID))) %>%
  select(GEOID, datawrapper_id, geography, NAME, short_name, population, age_under18:age_over65, median_hh_income,
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep, poverty_level_below_050:poverty_level_above_200, snap_rate_total, snap_rate_children,
         housing_owner_occupied, educ_hs_plus, educ_ba_plus, employment_rate_civilian,
         race_white:race_hispanic, foreign_born, has_health_insurance,
         child_poverty_rate_total:child_poverty_rate_notdeep,
         poverty_rate_race_white:poverty_rate_race_hispanic, poverty_rate_sex_male, poverty_rate_sex_female,
         child_poverty_family_married_couple, child_poverty_family_unmarried_male, child_poverty_family_unmarried_female,
         poverty_belowE, poverty_level_050E, poverty_rate_race_notwhite, poverty_rate_notwhite_vs_white) %>%
  arrange(desc(geography), datawrapper_id)

names(all_counties_states_nomoe) <- tolower(names(all_counties_states_nomoe))

all_counties_states_nomoe$geoid <- as.character(all_counties_states_nomoe$geoid)

all_counties_states_nomoe$datawrapper_id <- as.character(all_counties_states_nomoe$datawrapper_id)


nopr <- all_counties_states_nomoe %>%
  filter(!grepl("Puerto Rico", name),
         geography == "county")

summary(nopr$poverty_rate_total)

nopr %>%
  filter(grepl("Vermont", name)) %>%
  select(name, poverty_rate_deep) %>%
  arrange(poverty_rate_deep)

vermont <- all_counties_states_nomoe %>%
  filter(grepl("Vermont", name) & geography == "county") %>%
  select(name, geoid, poverty_rate_race_notwhite, poverty_rate_notwhite_vs_white,
         poverty_rate_race_white, poverty_rate_race_black, poverty_rate_race_asian, poverty_rate_race_nhpi_amind,
         poverty_rate_race_hispanic, poverty_rate_race_other, poverty_rate_race_twoplus)

vermont_gather <- vermont %>%
  gather(race, poverty_rate, poverty_rate_race_white:poverty_rate_race_twoplus) %>%
  group_by(name) %>%
  filter(poverty_rate == max(poverty_rate)) %>%
  ungroup() %>%
  mutate(poverty_rate_race_high = race) %>%
  select(geoid, poverty_rate_race_high)


all_towns <- all_counties_states_nomoe %>%
  filter(geography == "county subdivision") %>%
  separate(name, c("short_name", "county", "state"), sep = ",") %>%
  separate(short_name, c("short_name", "town"), sep = "town") %>%
  separate(short_name, c("short_name", "town"), sep = "city")


## StoryMap Data Links

geography_variables <- c("geoid", "geography", "name")


# Poverty rate for Vermont towns

poverty_all_towns <- all_towns %>%
  select(geoid, geography, short_name, county,
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep,
         child_poverty_rate_total, child_poverty_rate_deep, child_poverty_rate_notdeep) %>%
  mutate(poverty_rate_total = ifelse(is.na(poverty_rate_total) | poverty_rate_total==0, "", poverty_rate_total),
         poverty_rate_deep = ifelse(is.na(poverty_rate_deep) | poverty_rate_deep==0, "", poverty_rate_deep),
         poverty_rate_notdeep = ifelse(is.na(poverty_rate_notdeep) | poverty_rate_notdeep==0, "", poverty_rate_notdeep),
         child_poverty_rate_total = ifelse(is.na(child_poverty_rate_total) | child_poverty_rate_total==0, "", child_poverty_rate_total),
         child_poverty_rate_deep = ifelse(is.na(child_poverty_rate_deep) | child_poverty_rate_deep==0, "", child_poverty_rate_deep),
         child_poverty_rate_notdeep = ifelse(is.na(child_poverty_rate_notdeep) | child_poverty_rate_notdeep==0, "", child_poverty_rate_notdeep),
         )

poverty_all_towns <- poverty_all_towns %>%
  mutate(poverty_rate_total = as.numeric(poverty_rate_total))

summary(poverty_all_towns$poverty_rate_total)

write.csv(poverty_all_towns, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/poverty_all_towns.csv",
          row.names = FALSE)


# Poverty rate for US states
poverty_all_counties <- counties_all_nomoe %>%
  filter(geography == "county") %>%
  filter(!grepl("Puerto Rico", name)) %>%
  filter(geoid != "35039") %>%
  select(all_of(geography_variables), 
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep,
         poverty_rate_race_notwhite, poverty_rate_notwhite_vs_white,
         poverty_rate_race_white,
         poverty_rate_race_black, poverty_rate_race_asian, poverty_rate_race_nhpi_amind,
         poverty_rate_race_hispanic, poverty_rate_race_other, poverty_rate_race_twoplus) %>%
  mutate(poverty_rate_notwhite_higher = ifelse(poverty_rate_notwhite_vs_white>0, 1, 0))


## State High

poverty_race_high <- poverty_all_counties %>%
  select(all_of(geography_variables), 
         poverty_rate_total, poverty_rate_deep, poverty_rate_notdeep,
         poverty_rate_race_notwhite, poverty_rate_notwhite_vs_white,
         poverty_rate_race_white,
         poverty_rate_race_black, poverty_rate_race_asian, poverty_rate_race_nhpi_amind,
         poverty_rate_race_hispanic, poverty_rate_race_other, poverty_rate_race_twoplus) %>%
  mutate(poverty_rate_notwhite_higher = ifelse(poverty_rate_notwhite_vs_white>0, 1, 0)) %>%
  gather(race, poverty_rate, poverty_rate_race_white:poverty_rate_race_twoplus) %>%
  group_by(geoid) %>%
  filter(poverty_rate == max(poverty_rate, na.rm=TRUE)) %>%
  ungroup() %>%
  mutate(poverty_rate_race_high = race) %>%
  select(geoid, poverty_rate_race_high)

poverty_all_counties <- left_join(poverty_all_counties, poverty_race_high, by = "geoid")

poverty_all_counties <- poverty_all_counties %>%
  mutate(poverty_rate_race_high_cat = ifelse(grepl("asian", poverty_rate_race_high), "Asian",
                                                   ifelse(grepl("black", poverty_rate_race_high), "Black",
                                                                ifelse(grepl("hispanic", poverty_rate_race_high), "Hispanic",
                                                                             ifelse(grepl("two", poverty_rate_race_high), "Two or more",
                                                                                          ifelse(grepl("white", poverty_rate_race_high), "White",
                                                                                                       ifelse(grepl("nhpi", poverty_rate_race_high), "NH/PI/Am Indian",
                                                                                                       "Other")))))))

write.csv(poverty_all_counties, 
          "/Users/lawrence/Documents/GitHub/privilege_and_poverty/addison_county_101/storymap_data/poverty_all_counties.csv",
          row.names = FALSE)
