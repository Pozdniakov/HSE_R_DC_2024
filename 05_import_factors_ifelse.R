read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv")
?read.csv2

heroes <- read.table(file = "https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
                     header = TRUE, sep = ",", quote = '"', dec = ".",
                     na.strings = c("NA", "-", "-99", ""))
mean(heroes$Height, na.rm = TRUE)

heroes <- read.csv("https://raw.githubusercontent.com/Pozdniakov/tidy_stats/refs/heads/master/data/heroes_information.csv",
         na.strings = c("NA", "-", "-99", ""))

#install.packages("haven")
library(haven)
mental <- read_sav("mental_health.sav")
mental_df <- data.frame(mental)

well_being <- read_sav("well_being.sav")
class(well_being$Gender)
attributes(well_being$Gender)
as_factor(well_being$Gender)
wb <- as_factor(well_being)

wb$FinancialStatus
str(wb$FinancialStatus)
attributes(wb$FinancialStatus)
class(wb)
wb 
#plot(mental$AGE, mental$CS)
#plot(mental)
plot
class(wb)

t <- t.test(rnorm(30), rnorm(30))
t
class(t)
str(t)
t$p.value

unclass(t)
unclass(wb$FinancialStatus)

as.character(wb$FinancialStatus)
as.numeric(wb$FinancialStatus)

as.numeric(factor(c(3, 4, 7, 2, 0, 3, 4)))
as.numeric(as.character(factor(c(3, 4, 7, 2, 0, 3, 4))))

library(dplyr)
mutate(wb, across(where(is.factor), as.character))           
mutate(wb, across(where(is.factor), as.numeric))   

# if else -----------------------------------------------------------------

number <- -1
if (number > 0) {
  "Positive number"
} else if (number < 0) {
  "Negative number"
} else {
  "zero"
}

number <- -2:2
ifelse(number > 0, "positive number", "negative number or zero")
ifelse(number > 0,
       "positive number",
       ifelse(number < 0,
              "negative number",
              "zero"))
#install.packages("dplyr")
dplyr::case_when(number > 0 ~ "positive number", #if
                 number < 0 ~ "negative number", #else if
                 .default = "zero") #else

heroes$weight_group <- ifelse(heroes$Weight > 120, "overweight", "not overweight")

heroes$weight_group <- 
  dplyr::case_when(is.na(heroes$Weight) ~ NA_character_,
                 heroes$Weight > 140 ~ "obese",
                 heroes$Weight > 120 ~ "overweight",
                 heroes$Weight < 40 ~ "underweight",
                 .default = "normal weight")


# Creating functions ------------------------------------------------------


pow <- function(x, p = 2) x ^ p
pow <- function(x, p) {
  x ^ p
}

pow(2, 10)
pow(8, 2)

strange_f <- function(whatever) {
  t
}

strange_f()

more_strange_f <- function(x, wtf = a ^ 2){
  a <- x/2
  wtf
}
more_strange_f(10)

mass <- 80
height <- 1.86

imt <- function(m, h) m/h^2
imt(mass, height)
imt(100, 1.90)
bb 