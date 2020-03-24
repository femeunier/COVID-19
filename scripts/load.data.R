rm(list = ls())

library(tidyr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(ggplot2)
library(gghighlight)


data.file = "./csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
data <- read.csv(data.file,stringsAsFactors = FALSE) %>%
  pivot_longer(cols = -c("Province.State","Country.Region","Lat","Long"),names_to = "Date",values_to = "Number") %>%
  mutate(Date =  mdy(as.character(gsub("\\.", "/",substring(Date, 2))))) %>%
  group_by(Country.Region,Date) %>% summarise(Number = sum(Number,na.rm = TRUE)) %>% ungroup()

ggplot(data = data) +
  geom_line(aes(x = Date,y = Number,color = Country.Region)) + 
  gghighlight(Country.Region %in% c("Belgium","Italy","US")) +
  scale_y_log10() +
  theme_minimal()
