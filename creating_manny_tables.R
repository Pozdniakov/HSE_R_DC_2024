library(tidyverse)
heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("NA", "-", "-99", ""))

heroes %>% 
  split(.$Race) %>%
  map(function(x) write_csv(x, file = glue::glue("many_tables/heroes_only_{make.names(x$Race[1])}.csv")))




heroes %>% 
  split(.$Race) %>%
  map_int(nrow) %>%
  sum()
  