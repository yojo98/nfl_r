library(tidyverse)
library(nflfastR)

seasons <- 1999:2020
pbp <- nflfastR::load_pbp(seasons)

glimpse(pbp)

pbp %>%
  sample_n(20)  %>% select(desc)

shot_run <- pbp %>%
  filter(shotgun == "1", posteam == "PIT", play_type == 'run')

shot_run %>%
  select(desc) %>%
  head(10)

#test make sure it's all shotgun

shot_run %>%
  filter(shotgun == "0") %>%
  head(10)

#all good it seems!

shot_run %>%
  group_by(rusher) %>%
  summarise(mean_epa = mean(epa), success_rate = mean(success), ypa=mean(yards_gained), plays=n()) %>%
  filter(plays >= 10) %>%
  arrange(-mean_epa)
