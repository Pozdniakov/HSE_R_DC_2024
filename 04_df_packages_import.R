list1 = list(numbers = 1:5, letters = letters, logic = TRUE)
class(list1[1])
length(list1[1])
length(list1[[1]])

# Dataframes --------------------------------------------------------------

list_of_people <- list(
  name = c("Oleg", "Olga", "Anna", "Veronika", "Ivan"),
  age = 18:22,
  student = c(FALSE, TRUE, FALSE, TRUE, FALSE))

list_of_people
str(list_of_people)

df <- data.frame(
  name = c("Oleg", "Olga", "Anna", "Veronika", "Ivan"),
  age = 18:22,
  student = c(FALSE, TRUE, FALSE, TRUE, FALSE))
str(df)
df
df[2, 1]
df[1:2, 2:3]
df[1:2, "age"]
df[2:3, c("student", "name")]
str(df)
rm(df)
str(df)
df$name
df$lovesR <- TRUE
df
df[df$age > mean(df$age),]
df$name[df$age > mean(df$age)]

mtcars[,c("hp", "mpg", "cyl")]
sum(mtcars$cyl == 4)
mean(mtcars$cyl == 4)
mtcars[11]

# Пакеты ------------------------------------------------------------------

install.packages("beepr")
library(beepr)

beep(11)

beep()
beepr::beep()
beepr::beep()
beep()

install.packages("rdracor")
library(rdracor)
emilia <- get_net_cooccur_igraph(play = "lessing-emilia-galotti", corpus = "ger")
plot(emilia)

install.packages("remotes")
remotes::install_github("brooke-watson/BRRR")
library(BRRR)
skrrrahh()

skrrrahh_list()
skrrrahh(47)

# Импорт данных -----------------------------------------------------------

read.csv("/Users/ivan/Library/Mobile Documents/com~apple~CloudDocs/Downloads/heroes_information.csv")
getwd()
read.csv("heroes_information.csv")

read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv")

