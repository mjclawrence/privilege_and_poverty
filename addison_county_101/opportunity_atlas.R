library(tidyverse)

vt_counties <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/vt_counties.csv")

counties_subset <- vt_counties %>%
  select(county_name, 
         starts_with("kir_pooled_pooled_"),
         starts_with("kfr_pooled_pooled_"))

vt_counties_kfr_dollars <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/vt_counties_kfr_dollars.csv")

kfr_subset <- vt_counties_kfr_dollars %>%
  select(name,
         starts_with("kfr_rP_gP_"),
         -ends_with("_l"))

vt_counties_kir_dollars <- read.csv("https://raw.githubusercontent.com/mjclawrence/privilege_and_poverty/master/addison_county_101/vt_counties_kir_dollars.csv")

kir_subset <- vt_counties_kir_dollars %>%
  filter(grepl(", VT", name)) %>%
  select(name,
         starts_with("kir_rP_gP_"),
         starts_with("kir_rB_gP_"),
         starts_with("kir_rH_gP_"),
         starts_with("kir_rW_gP_"),
         starts_with("kir_rP_"),
         -ends_with("_l")) %>%
  droplevels() %>%
  arrange(name)

write.csv(kir_subset, "/users/lawrence/desktop/kir_subset.csv")


kir_w_h <- kir_subset %>%
  select(name, kir_rH_gP_p25, kir_rH_gP_p75, kir_rW_gP_p25, kir_rW_gP_p75) %>%
  gather(race, income, 2:5) %>%
  separate(race, c("race", "percentile"), sep = "_gP_") %>%
  mutate(race = ifelse(grepl("_rH", race), "Hispanic", "White")) %>%
  spread(percentile, income)

write.csv(kir_w_h, "/users/lawrence/desktop/kir_w_h.csv")
