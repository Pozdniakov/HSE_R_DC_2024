
# Functions tasks ---------------------------------------------------------

n <- 20
factors <- function(x) which(x %% seq_len(x) == 0)
factors(2024)
factors(20)
factors(2017)

is_prime <- function(x) length(factors(x)) == 2
is_prime(2021)

is_prime2 <- function(x) !any(x %% 2:(x-1) == 0)
is_prime2(2017)
mean(1:10)

#is_prime[1]

list(mean, is_prime, `[`, `+`)

A <- matrix(1:12, 3)
A
colSums(A)
colMeans(A)
rowSums(A)
rowMeans(A)


heroes <- read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na.strings = c("NA", "-", "-99", ""))
as.matrix(heroes)

apply(A, 2, sum)

A[2, 2] <- NA
A
apply(A, 2, sum, na.rm = TRUE)

welcome <- c("Welcome", "to", "the", "matrix", "Neo", "!")
B <- matrix(welcome,
       nrow = 2)
sum(nchar(welcome))
sum_nchar <- function(x) sum(nchar(x))
sum_nchar(welcome)
apply(B, 1, sum_nchar)

apply(B, 1, function(x) sum(nchar(x)))
apply(B, 2, \(x) sum(nchar(x)))

some_list <- list(some = 1:10, list = letters)
some_list
length(some_list)
lapply(some_list, length)
sapply(some_list, length)

#install.packages("purrr")
library(purrr)

map(some_list, length)
map(some_list, 2)
map_int(some_list, length)
map_chr(some_list, length)

sq <- map_dbl(1:10000000, sqrt)
sq <- sapply(1:10000000, sqrt)
sq <- sqrt(1:10000000)
is_prime(1:10)
is_prime_vectorized <- Vectorize(is_prime)
is_prime_vectorized(1:10)
sapply(1:10, is_prime)

hist(rlnorm(100))
mean(rlnorm(100))
many_means <- replicate(100000, mean(rlnorm(100)))
hist(many_means)

list3 <- list(
  a = 1:5,
  b = 0:20,
  c = 4:24,
  d = 6:3,
  e = 6:25
)

sapply(list3, length)
max_item <- function(x) x[[which.max(sapply(x, length))]]
max_item(list3)

list_42 <- list(
  1:10,
  iris,
  B,
  A, 
  heroes,
  letters,
  mean
)
max_item(list_42)
length(heroes)
length(iris)
length(mean)

sapply(heroes, class)
class(heroes)
sapply(heroes, function(x) sum(is.na(x)))

#install.packages("data.table")
library(data.table)

heroes_dt <- fread("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                   na = c("NA", "-", "-99", ""))

heroes_dt
heroes
class(heroes_dt)
print
methods(print)
heroes_dt[Alignment == "good",
          .(mean_height = mean(Height, na.rm = TRUE)),
          by = Gender][order(-mean_height),]

install.packages("tidyverse")
library(tidyverse)
 
class(heroes_tbl)
heroes_tbl
dim(heroes_tbl)

heroes_tbl %>%
  filter(Alignment == "good") %>%
  group_by(Gender) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE)) %>%
  arrange(desc(mean_height))
