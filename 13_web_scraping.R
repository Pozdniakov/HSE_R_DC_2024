library(tidyverse)
#Задания:
#1. Создать еще один заголовок второго уровня
#2. Добавить еще один абзац с текстом
#3. Добавить пронумерованный список с тремя элементами
#4. Добавить таблицу

install.packages("rvest")
library(rvest)

page <- read_html("my_webpage.html", encoding = "UTF-8")

html_element(page, xpath = "/html/body/h2[3]") %>% html_text()

#Задание:
#Извлеките второй элемент списка
page %>%
  html_element(xpath = "/html/body/ol/li[2]") %>%
  html_text()

page %>%
  html_elements(xpath = "/html/body/ol/li") %>%
  html_text()

page %>%
  html_element(xpath = "//li[2]") %>%
  html_text()

page %>%
  html_element(xpath = "//ol/li[2]") %>%
  html_text()

#Задание: извлеките текст третьего параграфа (<p>)
page %>% html_element(xpath = "//p[3]") %>% html_text()

##Задание: извлеките таблицу (с помощью html_table() вместо html_text())

page %>% html_element(xpath = "//table") %>% html_table()

page %>% html_element(xpath = "/html/body/p[2]/a") %>% html_text()
page %>% html_element(xpath = "/html/body/p[2]/a") %>% html_attr("href")
page %>% html_element(xpath = "/html/body/p[2]/a/@href") %>% html_text()

page %>% 
  html_element(xpath = "/html/body/ol/li[@class='working_class']") %>% 
  html_text()

page %>% 
  html_element(xpath = "//*[@class='working_class']") %>% 
  html_text()


page %>% 
  html_elements(xpath = "//*[@class='working_class']") %>% 
  html_text()

wiki_marvel <- read_html("https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
wiki_marvel %>%
  html_element(xpath = '//*[@id="mw-content-text"]/div[1]/table[3]') %>%
  html_table()

wiki_marvel %>%
  html_element(xpath = "//table[8]") %>%
  html_table()

tibble_list <- wiki_marvel %>%
  html_elements(xpath = "//table") %>%
  html_table()

tibble_list[[3]]
tibble_list %>%
  pluck(3)

tibble_list %>%
  keep_at(3:7)

tibble_list %>%
  keep(function(x) names(x)[1] == "Film[30]") %>%
  bind_rows(.id = "Phase")

invalid_names <- tibble_list %>%
  pluck(3) %>%
  names()

str_remove(invalid_names, "\\(s\\)")
str_remove(invalid_names, fixed("(s)"))

tibble_list %>%
  keep(function(x) names(x)[1] == "Film[30]") %>%
  map(function(x) rename_with(x, function(y) str_remove(y, "\\(s\\)") )) %>%
  bind_rows(.id = "Phase") %>% View()
