#install.packages("tidyverse")
library(tidyverse)

heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                       na = c("NA", "-", "-99", ""))
#install.packages("skimr")
skimr::skim(heroes)

sum(log(abs(sin(1:20)), base = 2))

1:20 %>% 
  sin() %>% 
  abs() %>% 
  log(x = 2, base = .) %>% 
  sum()

#`%>%`(1:20, sin)

1:20 |>
  sin() |>
  abs() |>
  log(x = 2, base = _) |>
  sum()

2 %>%
  c("Корень из", ., "равен", sqrt(.))

B <- matrix(10:39, nrow = 5)
apply(B, 1, mean)

10:39 %>%
  matrix(nrow = 5) %>%
  apply(1, mean)

heroes %>%
  select(1, 5)

select(heroes, 1, 5)


heroes_selected_columns <- heroes %>%
  select(1, 5)

heroes_selected_columns
heroes
heroes %>%
  select(name, Race, Publisher, `Hair color`)

heroes %>%
  select(name:`Eye color`, Publisher:Height)

heroes %>%
  select(!...1)

heroes %>%
  select(!(Gender:Height))
heroes %>%
  select(name:last_col())
heroes %>%
  select(everything())
heroes %>%
  select(superhero = name, Publisher, everything())

heroes %>%
  rename(id = ...1)

heroes %>%
  select(id = ...1)

heroes %>%
  relocate(superhero = name, Publisher, .before = Race)

heroes %>%
  rename_with(make.names)
heroes %>%
  rename_with(toupper)

heroes %>%
  select(ends_with("color"))
heroes %>%
  select(starts_with("H") | ends_with("color"))

heroes %>% 
  select(contains("eigh"))

heroes %>%
  select(where(is.character))

heroes %>%
  select(where(function(x) !any(is.na(x)) ))

heroes %>%
  select(where(function(x) mean(is.na(x)) < .5 ))

heroes %>%
  select(name)

B[,1, drop = FALSE]
#`[`(B, ,1, drop = FALSE)

heroes %>%
  select(name) %>%
  pull()

heroes %>%
  pull(name)

heroes %>%
  pull(Height, name)

heroes %>%
  relocate(name, where(is.numeric))


# Работа со строчками -----------------------------------------------------

heroes %>%
  slice(c(100, 200, 500))

heroes %>%
  slice(300:310)

heroes %>%
  filter(Publisher == "Marvel Comics")

heroes %>%
  filter(Weight > 200 & Weight < 300)
heroes %>%
  filter(Weight > 200, Weight < 300)
heroes %>%
  filter(Weight > 200) %>%
  filter(Weight < 300)

heroes %>%
  slice_max(Weight, n = 10, with_ties = FALSE)

heroes %>%
  slice_min(Weight, n = 3)

heroes %>%
  slice_sample(n = 3)

heroes %>%
  slice_sample(prop = .01)

heroes %>%
  slice_sample(prop = 1)

heroes %>%
  drop_na()

heroes %>%
  drop_na(Height, Weight)

heroes %>%
  arrange(Weight)

heroes %>%
  arrange(desc(Weight))

heroes %>%
  arrange(Gender, desc(Weight))

#heroes$new_column <- heroes$Weight ^ 2
heroes %>%
  mutate(imt = Weight/(Height/100)^2)

heroes_with_new_columns %>%
  select(name, Weight, imt)

heroes %>%
  transmute(name, imt = Weight/(Height/100)^2)

heroes %>%
  mutate(imt = Weight/(Height/100)^2, .before = name)

#heroes$hair <- if_else(heroes$`Hair color` == "No Hair", "Bold", "Hairy")

heroes %>%
  mutate(hair = if_else(`Hair color` == "No Hair", "Bold", "Hairy")) %>%
  select(name, `Hair color`, hair)

heroes %>%
  transmute(name, `Hair color`, hair = if_else(`Hair color` == "No Hair", "Bold", "Hairy"))

heroes %>%
  summarise(mean_weight = mean(Weight, na.rm = TRUE),
            max_weight = max(Weight, na.rm = TRUE),
            min_weight = min(Weight, na.rm = TRUE))

heroes %>%
  summarise(first_name = first(name),
            last_name = last(name),
            tenth_name = nth(name, 10))

# heroes %>%
#   summarise(name[1], name[nrow(.)])

heroes %>%
  summarise(range(Weight, na.rm = TRUE))

heroes %>%
  reframe(range(Weight, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>% str()

heroes %>%
  group_by(Gender) %>%
  summarise(mean_weight = mean(Weight, na.rm = TRUE),
            max_weight = max(Weight, na.rm = TRUE),
            min_weight = min(Weight, na.rm = TRUE),
            n = n())

heroes %>%
  group_by(Gender, Alignment, Weight > 100) %>%
  summarise(n = n())

heroes %>%
  count(Gender, Alignment)

heroes %>%
  count(Race, sort = TRUE) %>% View()

heroes %>%
  group_by(Race) %>%
  filter(n() > 10) %>% View()

heroes %>%
  group_by(Race) %>%
  filter(n() == 1) %>% View()

heroes %>%
  group_by(Gender) %>%
  mutate(mean_weight = mean(Weight, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(Weight_diff_by_gender = Weight - mean_weight) %>% View()

library(haven)
?read_sav

install.packages("foreign")
?foreign::read.spss()
