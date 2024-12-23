library(tidyverse)
library(httr)
library(glue)
token <- "c03c1ffb426d4c4064237f73e4ded8d3"
id <- 346
max_id <- 731
paste0("https://superheroapi.com/api/", token, "/",  id, "/appearance")
paste("https://superheroapi.com/api", token, id, "appearance", sep = "/")
req <- glue("https://superheroapi.com/api/{token}/{id}/appearance")
req 

resp <- GET(req)

class(resp)
status_code(resp)
content(resp)
#jsonlite::fromJSON() -- альтернатива импорту JSON

cont <- content(resp)
str(cont)
cont %>%
  as_tibble()

cont$id
cont$name
cont$gender
cont$race
cont$height[2]
cont$height[[2]]

get_appearance_tbl <- function(request) {
  response <- GET(request)
  status_code <- status_code(response)
  if (status_code == 200) {print("Server replied with something")
  } else {
      stop(glue("WRONG request {request}: status code is {status_code}"))}
  con <- content(response)
  if(con$response == "error") {
    stop(glue("WRONG request {request}: status is ok but: {con$error}"))}
  tibble(
    id = con$id,
    name = con$name,
    race = con$race,
    height = con$height[[2]],
    weight = con$weight[[2]]
  )
}

get_appearance_tbl(req)
#invalid request
get_appearance_tbl(glue("https://superheroapi.com/apii/{token}/{id}/appearance"))
get_appearance_tbl(glue("https://superheroapi.com/api/{token}/{id*100}/appearance"))

wrong_resp <- GET(glue("https://superheroapi.com/api/{token}/{id*10}/appearance"))
content(wrong_resp)
content(resp)

if(content(resp)$response == "error") {
  stop(glue("WRONG request {request}: status is ok but: {content(resp)$error}"))}

get_appearance_tbl2 <- function(request){
  response <- GET(request)
  status_code <- status_code(response)
  if (status_code == 200) {print("Server replied with something")
  } else {
    stop(glue("WRONG request {request}: status code is {status_code}"))}
  con <- content(response)
  if(con$response == "error") {
    stop(glue("WRONG request {request}: status is ok but: {con$error}"))}
  con %>%
    list_flatten() %>%
    as_tibble()
}

get_appearance_tbl2(req)
get_appearance_tbl2(glue("https://superheroapi.com/apii/{token}/{id}/appearance"))
get_appearance_tbl2(glue("https://superheroapi.com/api/{token}/{id*100}/appearance"))

get_appearance_tbl2(glue("https://superheroapi.com/api/{token}/38/appearance"))


# Multiple requests -------------------------------------------------------

reqs <- glue("https://superheroapi.com/api/{token}/{1:10}/appearance")
GET(reqs)


# For loops ---------------------------------------------------------------

#while, repeat, for
letters
for (l in letters) {
  print(glue("letter {l}"))
}

for (i in seq_along(letters)) {
  print(glue("letter {letters[i]} has number {i}"))
}

character(10)
integer(20)

# is.vector(1:10)
# is.vector(letters)
# is.vector(list())
# is.atomic(1:10)
# is.atomic(letters)
# is.atomic(list())
is.recursive(list())
is.recursive(letters)

class(resp$content)

letters_info <- vector(mode = "list", length = length(letters))
for (i in seq_along(letters)) {
  letters_info[i] <- glue("letter {letters[i]} has number {i}")
}
letters_info
#glue("letter {letters}")

lapply(letters, function(x) glue("letter {x}"))
map(letters, function(x) glue("letter {x}"))
map(letters, ~glue("letter {.x}"))
map2(letters, 1:26, function(x, y) glue("letter {x} has number {y}"))
map2(letters, seq_along(letters), ~glue("letter {.x} has number {.y}"))
imap(letters, ~glue("letters {.x} has number {.y}"))

map_chr(letters, ~glue("letter {.x}"))
imap_chr(letters, ~glue("letters {.x} has number {.y}"))

#Задание
reqs <- glue("https://superheroapi.com/api/{token}/{1:10}/appearance") 
GET(reqs)
#прочитать в список из тибблов в каждом из которых будет по одной строчке

for (r in reqs) {
  print(get_appearance_tbl2(r))
}

for(i in seq_along(reqs)) {
  print(get_appearance_tbl2(reqs[i]))
}

appearance_list <- vector(mode = "list", length = length(reqs))
for(i in seq_along(reqs)) {
  appearance_list[[i]] <- get_appearance_tbl2(reqs[i])
}
appearance_list %>% bind_rows()

class(reqs)
map(reqs, get_appearance_tbl2) %>%
  bind_rows()

map_dfr(reqs, get_appearance_tbl2) 
reqs %>%
  map_dfr(get_appearance_tbl2)

reqs %>%
  map(GET) %>%
  walk(~print(status_code(.x))) %>%
  map(content) %>%
  map(list_flatten) %>%
  map(as_tibble) %>%
  bind_rows()

wrong_reqs <- glue("https://superheroapi.com/api/{token}/{-1:10}/appearance")

map(wrong_reqs, get_appearance_tbl2)
tryCatch(get_appearance_tbl2(wrong_reqs[1]), error = function(e) NULL )

appearance_list <- vector(mode = "list", length = length(wrong_reqs))
for(i in seq_along(wrong_reqs)) {
  appearance_list[[i]] <- tryCatch(get_appearance_tbl2(wrong_reqs[i]), error = function(e) NULL)
}
appearance_list %>% bind_rows()

map(wrong_reqs, possibly(get_appearance_tbl2))

wrong_results <- map(wrong_reqs, safely(get_appearance_tbl2))
wrong_results %>%
  map("result") %>%
  bind_rows()

wrong_results %>%
  map("error")

full_reqs <- glue("https://superheroapi.com/api/{token}/{seq_len(max_id)}/appearance") 

full_appearance_list <- map(full_reqs, possibly(get_appearance_tbl2))
api_heroes <- full_appearance_list %>%
  bind_rows() 

api_heroes %>%
  filter(!is.na(height))

glue("https://superheroapi.com/api/{token}/198/appearance") %>%
  GET() %>%
  content()

api_heroes <- full_appearance_list %>%
  bind_rows() %>%
  select(!c(height, height_1, weight_1)) %>%
  rename(height = height_2, weight = weight_2) %>%
  separate(height, into = c("height_value", "height_units"), sep = " ", convert = TRUE) %>%
  mutate(race = race %>% str_replace("-", " / "),
         height_cm = if_else(height_units == "meters", height_value * 100, height_value)) %>%
  select(!c(height_value, height_units)) %>%
  mutate(weight = weight %>% str_remove(",")) %>%
  separate(weight, into = c("weight_value", "weight_units"), sep = " ", convert = TRUE) %>%
  mutate(weight_kg = if_else(weight_units == "tons", weight_value * 1000, weight_value)) %>%
  select(!c(weight_value, weight_units)) %>%
  mutate(`hair-color` = if_else(`hair-color` == "Brownn", "Brown", `hair-color`)) %>%
  mutate(across(where(is.numeric), ~na_if(., 0))) %>%
  mutate(across(where(is.character), ~na_if(., "null"))) %>%
  mutate(across(where(is.character), ~na_if(., "-")))

skimr::skim(api_heroes)

api_heroes %>%
  count(response)


api_heroes %>%
  filter(name %in% possible_nas)
api_heroes %>%
  count(gender)
api_heroes %>%
  count(race, sort = TRUE) %>% View()

api_heroes %>%
  separate(height, into = c("height_value", "height_units"), sep = " ", convert = TRUE) %>%
  count(height_units)

api_heroes %>%
  separate(weight, into = c("weight_value", "weight_units"), sep = " ", convert = TRUE) %>%
  filter(is.na(as.numeric(weight_value)))

as.numeric(c("1", "2", "3,"))

api_heroes %>%
  separate(weight, into = c("weight_value", "weight_units"), sep = " ", convert = TRUE) %>%
  mutate(weight_kg = if_else(weight_units == "tons", weight_value * 1000, weight_value))

api_heroes %>%
  count(`eye-color`, sort = TRUE) %>% View()
api_heroes %>%
  count(`hair-color`, sort = TRUE) %>% View()

api_heroes %>%
  filter(`hair-color` == "Strawberry Blond")

?na_if()

possible_nas <- c("null", "-")

api_heroes %>%
  mutate(across(where(is.numeric), ~na_if(., 0))) %>%
  mutate(across(where(is.character), ~na_if(., "null"))) %>%
  mutate(across(where(is.character), ~na_if(., "-")))

api_heroes
rank(4:10)
