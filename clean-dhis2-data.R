#install.packages("tidyverse")

library(tidyverse)

# the read.csv is from base R
dhis2_data <- read.csv("data/dhis2data.csv")

#str(dhis2_data)

## readr package
## the read_csv comes from readr package from the tidyverse 
dhis2_data2 <- read_csv("data/dhis2data.csv") 

## dpylr package = Manipulation of data 
select(dhis2_data2, orgunitlevel2, periodname)

## drop columns

select(dhis2_data2, 1: 3)

select(dhis2_data2, 5,2, 1)


dhis2_data3 <- select(dhis2_data2, 
       c(orgunitlevel2, orgunitlevel3,  periodid, `EPI - DPT-HepB-HIB 1 doses given <1 year`:`EPI - HPV1 doses given` ))


## Rename 
dhis2_data4 <- rename(dhis2_data3, 
                      "region" = orgunitlevel2,
                      "district" = orgunitlevel3, 
                      "period" = periodid,
                      "DPT1" = `EPI - DPT-HepB-HIB 1 doses given <1 year`, 
                      "DPT3" = `EPI - DPT-HepB-HIB 3 doses given <1 year`,
                      "YF" =  `105-EP11. Yellow Fever`,
                       "MR1" =  `EPI - MR 1 doses given <1 year`,
                      "MR2" = `EPI - Measles 2 (MR2) doses_1-4 yrs`,
                      "Rota3" = `HMIS 105Bc: CL 29: Rota Virus 3`, 
                       "HPV1" = `EPI - HPV1 doses given`)

### The pipe (shortcut : Ctrl + Shift + M)


dhis2_clean <- dhis2_data2 |> 
  select(c(orgunitlevel2, orgunitlevel3,  periodid, 
           `EPI - DPT-HepB-HIB 1 doses given <1 year`:`EPI - HPV1 doses given` )) |> 
  rename("region" = orgunitlevel2,
         "district" = orgunitlevel3, 
         "period" = periodid,
         "DPT1" = `EPI - DPT-HepB-HIB 1 doses given <1 year`, 
         "DPT3" = `EPI - DPT-HepB-HIB 3 doses given <1 year`,
         "YF" =  `105-EP11. Yellow Fever`,
         "MR1" =  `EPI - MR 1 doses given <1 year`,
         "MR2" = `EPI - Measles 2 (MR2) doses_1-4 yrs`,
         "Rota3" = `HMIS 105Bc: CL 29: Rota Virus 3`, 
         "HPV1" = `EPI - HPV1 doses given`)

## Regional DPT1 performance 2024 01

dhis2_clean |> 
  filter(period == "202401") |> 
  group_by(region) |> 
  summarise( DPT1 = sum( DPT1), 
             YF = sum( YF, na.rm = T)) |> 
  arrange(desc(DPT1))

## Group by District and period and sum up all antigens 
## You can use the across function in the summarise function
  

## 23 - 10- 2024###
## The across function###

dhis2_clean |> 
  filter(period == "202401") |> 
  group_by(region) |> 
  summarise( DPT1 = sum( DPT1), 
             DPT3 = sum( DPT3),
             YF = sum( YF, na.rm = T)) |> 
  arrange(desc(DPT1))

## using across

dhis2_clean |> 
  filter(period == "202401") |> 
  group_by(region) |> 
  summarise( across(c(DPT1, DPT3, MR1,MR2, YF), sum ) ) |> 
  arrange(desc(DPT1))

dhis2_clean |> 
  filter(period == "202401") |> 
  group_by(region) |> 
  summarise( across(DPT1:HPV1, sum ) ) |> 
  arrange(desc(DPT1))

dhis2_clean |> 
  filter(period == "202401") |> 
  group_by(region) |> 
  summarise(across(where(is.numeric), sum )) |> 
  arrange(desc(DPT1))

### Handling expections in across ###

dhis2_clean |> 
  filter(period == "202401") |> 
  mutate(period = as.character(period)) |> 
  group_by(region) |> 
  summarise(across(where(is.numeric), sum )) |> 
  arrange(desc(DPT1))


dhis2_clean |> 
  filter(period == "202401") |> 
  mutate(period = as.character(period)) |> 
  group_by(region) |> 
  summarise(across(!c(where(is.numeric)), count )) |> 
  arrange(desc(DPT1))


#### stringr package #####

stringr::str_c("Robinson", "Amanyiraho", sep = ",")

dhis2_clean |> 
  mutate(region = str_to_upper(region),
         district = str_remove(string = district, pattern = " District" ),
         district = str_remove(string = district, pattern = " City" ),
         district = str_to_lower(district)) |> 
  #filter(str_detect(district, "a")) |> View()
#filter(str_detect(district, "^bu")) |> View()
filter(str_detect(district, "*a")) |> View()




### Change the period column from "202401" to "2024-01-01"


