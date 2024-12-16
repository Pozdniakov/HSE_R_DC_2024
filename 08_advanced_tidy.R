library(tidyverse)

heroes <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("NA", "-", "-99", ""))


# Соединение датафреймов --------------------------------------------------


dc <- heroes %>%
  filter(Publisher == "DC Comics") %>%
  group_by(Gender) %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE))
dc

marvel <- heroes %>%
  filter(Publisher == "Marvel Comics") %>%
  group_by(Gender) %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE))
marvel

other_publishers <- heroes %>%
  filter(!(Publisher %in% c("DC Comics","Marvel Comics"))) %>%
  group_by(Gender) %>%
  summarise(weight_mean = mean(Weight, na.rm = TRUE))
other_publishers

#cbind(), rbind()

bind_cols(marvel, dc)
bind_rows(marvel, dc)
bind_rows(marvel, dc, other_publishers)
list_of_tibbles <- list(Marvel = marvel, DC = dc, Others = other_publishers)

bind_rows(list_of_tibbles, .id = "where_it_comes_from")
class(marvel)
nrow(marvel)
nrow
dim(marvel)
marvel %>%
  group_by(Gender) %>% class()
iris %>%
  as_tibble()

iris %>%
  select(where(is.numeric)) %>%
  filter(Sepal.Length > 5) 

iris %>%
  group_by(Species) %>%
  summarise(mean(Petal.Width))

iris %>%
  count(Species)

paste0("many_tables/", dir("many_tables"))

paths <- dir("many_tables", full.names = TRUE)
all(str_ends(paths, "csv"))
paths <- paths[str_ends(paths, "csv")]
read_csv(paths)
list_of_imported_tibbles <- lapply(paths, read_csv)
names(list_of_imported_tibbles) <- paths
list_of_imported_tibbles
whole_tibble <- bind_rows(list_of_imported_tibbles, .id = "path")
whole_tibble %>%
  mutate(path = path %>%
           str_remove("many_tables/heroes_only_") %>%
           str_remove(".csv"))

list_of_imported_tibbles <- map(paths, read_csv)
map_df(paths, read_csv)
?map_df

A <- matrix(1:12, nrow = 3)
attributes(A)
attributes(A) <- NULL
A
attr(A, "dim") <- c(4, 3)
A
apply(A, 2, sum)


lapply(iris, class)
map(iris, class)

band_members
band_instruments

left_join(band_members, band_instruments)
right_join(band_members, band_instruments)
left_join(band_instruments, band_members)

band_members %>%
  left_join(band_instruments, by = "name")
band_instruments2 %>%
  rename(name = artist)

band_members %>%
  left_join(band_instruments2, by = c("name" = "artist"))

band_members %>%
  full_join(band_instruments)
band_members %>%
  inner_join(band_instruments)

band_members %>%
  semi_join(band_instruments)

band_members %>%
  filter(name %in% unique(band_instruments$name))
band_instruments %>%
  semi_join(band_members)
band_members %>%
  anti_join(band_instruments)
band_instruments %>%
  anti_join(band_members)

powers <- read_csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/master/data/super_hero_powers.csv")
powers
powers$`Web Creation`
powers_web <- powers %>%
  select(hero_names, `Web Creation`) %>%
  filter(`Web Creation`)

heroes %>%
  semi_join(powers_web, by = c("name" = "hero_names"))

install.packages("janitor")
heroes %>%
  janitor::get_dupes()

heroes %>%
  janitor::get_dupes(name)

heroes %>%
  anti_join(powers, by = c("name" = "hero_names")) %>%
  pull(name)

# long and wide data ------------------------------------------------------

new_diet <- tibble(
  student = c("Маша", "Рома", "Антонина"),
  before_r_course = c(70, 80, 86),
  after_r_course = c(63, 74, 71)
)
new_diet %>%
  pivot_longer(cols = before_r_course:after_r_course,
               names_to = "time",
               values_to = "weight") %>%
  pivot_wider(names_from = "time", values_from = "weight")

new_diet %>%
  pivot_longer(cols = before_r_course:after_r_course,
               names_to = "time",
               values_to = "weight") %>%
  pivot_wider(names_from = "student", values_from = "weight")


# across ------------------------------------------------------------------

heroes %>%
  drop_na(Weight, Height) %>%
  group_by(Gender) %>%
  summarise(mean_height = mean(Height),
            mean_weight = mean(Weight))
  
heroes %>%
  drop_na(Weight, Height) %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), mean))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.numeric), function(x) mean(x, na.rm = TRUE)))

heroes %>%
  group_by(Gender) %>%
  summarise(across(where(is.character), function(x) mean(nchar(x), na.rm = TRUE)))

heroes %>%
  group_by(Alignment) %>%
  summarise(across(where(is.numeric), function(x) mean(x, na.rm = TRUE)),
            across(where(is.character), function(x) mean(nchar(x), na.rm = TRUE)))

heroes %>%
  drop_na(Height, Weight) %>%
  group_by(Alignment) %>%
  summarise(across(c(Height, Weight),
                   list(minimum = min,
                        average = mean,
                        maximum = max,
                        na_n = function(x) sum(is.na(x)))))

heroes %>%
  mutate(across(where(is.character), as.factor)) %>%
  mutate(across(where(is.factor), as.integer))

iris %>%
  mutate(across(where(is.numeric), function(x) (x - mean(x))/sd(x))) %>%
  summarise(across(where(is.numeric), list(average = mean, SD = sd) ))

iris %>%
  mutate(across(where(is.numeric), round))

heroes %>%
  nest(!Gender) %>%
  pull(data)

heroes %>%
  nest(!Gender)

heroes_nested <- heroes %>%
  group_by(Gender) %>%
  nest() %>%
  ungroup() %>%
  mutate(dim = map(data, dim))

heroes %>%
  group_by(Gender) %>%
  nest() %>%
  ungroup() %>%
  mutate(dim = map(data, dim)) %>%
  unnest_wider(dim, names_sep = "_")  %>%
  select(!data)

films <- tribble(
  ~film, ~genres,
  "Ирония Судьбы", "comedy, drama",
  "1+1", "comedy, drama",
  "Я - робот", "sci-fi",
  "Властелин Колец", "fantasy, drama",
  "Поворот не туда", "horror",
  "Interstellar", "sci-fi, drama",
  "Баллада о сексуальной зависимости", "drama, documentary"
)
films %>%
  filter(genres == "drama")
films %>%
  filter(str_detect(genres, "drama"))

str_split(films$genres, ", ")

films %>%
  mutate(genres = strsplit(genres, ", ")) %>%
  unnest() %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres, values_from = value, values_fill = FALSE)

films %>%
  separate_rows(genres, sep = ", ") %>%
  mutate(value = TRUE) %>%
  pivot_wider(names_from = genres, values_from = value, values_fill = FALSE)
