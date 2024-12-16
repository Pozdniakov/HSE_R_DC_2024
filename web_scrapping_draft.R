library(tidyverse)
library(rvest)

read_html("my_webpage.html")
read_html("my_webpage.html", encoding = "UTF-8")
page <- read_html("my_webpage.html", encoding = "UTF-8")

html_element(page, xpath = "/html/body/h2")
html_element(page, xpath = "/html/body/h2") %>% html_text()

html_element(page, xpath = "/html/body/h2[1]") %>% html_text()

#Задача: извлеките второй и третий заголовок второго уровня
#Задача: извлечь второй элемент списка
html_element(page, xpath = "/html/body/ol/li[2]")
html_element(page, xpath = "/html/body/ol/li[2]") %>% html_text()
html_element(page, xpath = "//li[2]") %>% html_text()
html_element(page, xpath = "//ol/li[2]") %>% html_text()
#Задача: извлеките текст третьего параграфа
html_element(page, xpath = "//p[3]") %>% html_text()
#Задача: извлеките таблицу html_table()

html_element(page, xpath = "/html/body/table") %>% html_table()
#Задача: извлеките ссылку с помощью html_attr()
html_element(page, xpath = "//p[2]/a") %>% html_attr("href")
html_element(page, xpath = "//p[2]/a/@href") %>% html_text()

html_element(page, xpath = "//p[@class='working_class']") %>% html_text()
html_elements(page, xpath = "//*[@class='working_class']") %>% html_text()

####
html_elements(page, xpath = "/html/body/h2") %>% html_text()


#####

wiki <- read_html("https://en.wikipedia.org/wiki/Category:Marvel_Comics_superheroes")
html_element(wiki, xpath = '//*[@id="mw-pages"]/div/div/div[2]/ul/li[1]') 

html_element(wiki, xpath = '//*[@id="mw-pages"]/div/div/div[2]/ul/li[1]') %>%
  html_text()
map(glue::glue('//*[@id="mw-pages"]/div/div/div[2]/ul/li[{1:50}]'),
    function(x) html_element(wiki, xpath = x)) %>%
  map_chr(html_text)

map(glue::glue('//*[@id="mw-pages"]/div/div/div[1]/ul/li[{1:50}]'),
    function(x) html_element(wiki, xpath = x)) %>%
  map_chr(html_text)

wiki_marvel <- read_html("https://en.wikipedia.org/wiki/List_of_Marvel_Cinematic_Universe_films")
html_element(wiki_marvel, xpath = '//*[@id="mw-content-text"]/div[1]/table[3]') %>% html_table()
html_element(wiki_marvel, xpath = '//table') %>% html_table()
html_elements(wiki_marvel, xpath = '//table') %>% html_table() %>% pluck(3)
html_elements(wiki_marvel, xpath = '//table') %>% html_table() %>% keep_at(3:7)
html_elements(wiki_marvel, xpath = '//table') %>% html_table() %>% keep(function(x) names(x)[1] == "Film[30]") %>%
  bind_rows()

######
######
######


ecsoc_deviant <- read_html("https://ecsoc.hse.ru/2024-25-4/968284217.html")

html_element(ecsoc_deviant, xpath = "//h2") %>%
  html_text()

html_element(ecsoc_deviant, xpath = "//h2") %>%
  html_text()

html_element(ecsoc_deviant, xpath = "//h2[@class='article-header']") %>% html_text()
