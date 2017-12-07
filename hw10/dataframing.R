library(tidyverse)
library(magrittr)
library(purrr)
library(glue)
library(stringr)

library(rvest)
library(xml2)


frame_prof <- function(number = 7543){
  if(number < 7543 || number > 14937){
    stop("Page not found, try number between 7543 and 14937")
  } # found these are the range in which professors exist

url <- paste0('http://www.ratemyprofessors.com/ShowRatings.jsp?tid=',as.character(number))

webpage <- read_html(url)


netlikes <- webpage %>% 
  html_nodes(".count") %>% 
  html_text(trim = TRUE)  

dislikes <- netlikes[seq(2,length(netlikes),2)]
likes <- netlikes[seq(1,length(netlikes),2)]

date <- webpage %>% 
  html_nodes(".date") %>% 
  html_text(trim = TRUE) %>% 
  as.Date(format="%m/%d/%Y") # time format



ratings <- webpage %>% 
  html_nodes(".score") %>% 
  html_text(trim = TRUE)

difficulty <- ratings[seq(2,length(ratings),2)]
overall <- ratings[seq(1,length(ratings),2)]

comments <- webpage %>% 
  html_nodes(".commentsParagraph") %>% 
  html_text(trim = TRUE)

response <- webpage %>% 
  html_nodes(".response") %>% 
  html_text(trim = TRUE)

course <- response[seq(1,length(response),6)]
grade <- response[seq(6,length(response),6)]


dep <- webpage %>% 
  html_nodes(".result-title") %>% 
  html_text(trim = TRUE)

dep <- gsub("", "Professor in the ", dep)
dep <- gsub("", " department", dep)

title <- webpage %>% 
  html_nodes("title") %>% 
  html_text(trim = TRUE)

prof <- rep(str_split(title," at ")[[1]][1], length(course))
uni <- gsub(" - RateMyProfessors.com", "", str_split(title," at ")[[1]][-1]) %>%
  paste0(collapse=" at ") %>% # in case " at " appears in university name
  rep(length(course))


df <- data_frame(University = uni,
                 Professor = prof,
                 Course = course,
                 Difficulty = difficulty,
                 OverallRating = overall,
                 Comments = comments,
                 Date = date,
                 Unhelpful = dislikes,
                 Helpful = likes,
                 Grade = grade
)
}

df <- c()
for(i in 7543:7550){
  df2 <- frame_prof(i) 
  df <- rbind(df, df2)
}

write.csv(df, file = "rmp_data.csv")
