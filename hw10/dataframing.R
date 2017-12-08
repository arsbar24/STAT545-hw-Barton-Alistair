library(tidyverse)
library(magrittr)
library(purrr)
library(glue)
library(stringr)

library(rvest)
library(xml2)


DataSize = 7393 # parameter for how much data we want, should be <7394

# function to convert grades to GPA (for ordering purposes)
grade2GPA <- function(letter){
  if(letter == "A+"){4.3}
  else if(letter == "A"){4}
  else if(letter == "A-"){3.7}
  else if(letter == "B+"){3.3}
  else if(letter == "B"){3}
  else if(letter == "B-"){2.7}
  else if(letter == "C+"){2.3}
  else if(letter == "C"){2}
  else if(letter == "C-"){1.7}
  else if(letter == "D+"){1.3}
  else if(letter == "D"){1}
  else if(letter == "D-"){0.7}
  else if(letter == "N/A"){NA}
  else{0}
}

frame_prof <- function(number = 7543, Grade = "GPA"){
  if(number < 7543 || number > 14937){
    stop("Page not found, try number between 7543 and 14937")
  } # found these are the range in which professors exist
  
  url <- paste0('http://www.ratemyprofessors.com/ShowRatings.jsp?tid=',as.character(number))

  webpage <- read_html(url)


  netlikes <- webpage %>% 
    html_nodes(".count") %>% 
    html_text(trim = TRUE)  

  # catch case when no reviews of a professor
  if(length(netlikes)==0){
    return(c())
  }
  dislikes <- netlikes[seq(2,length(netlikes),2)]
  likes <- netlikes[seq(1,length(netlikes),2)]

  date <- webpage %>% 
    html_nodes(".date") %>% 
    html_text(trim = TRUE) %>% 
    as.Date(format="%m/%d/%Y", tz = GMT) # time format



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

  if(Grade == "GPA"){
    grade = mapply(grade2GPA, grade)
  }

  dep <- webpage %>% 
    html_nodes(".result-title") %>% 
    html_text(trim = TRUE)

  dep <- substr(dep, 18, gregexpr("department", dep)[[1]][1]-2)

  title <- webpage %>% 
    html_nodes("title") %>% 
    html_text(trim = TRUE)

  prof <- rep(str_split(title," at ")[[1]][1], length(course))
  uni <- gsub(" - RateMyProfessors.com", "", str_split(title," at ")[[1]][-1]) %>%
    paste0(collapse=" at ") %>% # in case " at " appears in university name
    rep(length(course))


  df <- data_frame(University = uni,
                   Department = dep,
                   Professor = prof,
                   Course = course,
                   Difficulty = difficulty,
                   Rating = overall,
                   Comments = comments,
                   Date = date,
                   Unhelpful = dislikes,
                   Helpful = likes,
                   Grade = grade)
}

df <- c()
for(i in 7543:(7543 + DataSize)){
  df2 <- frame_prof(i) 
  df <- rbind(df, df2 )
}


write.csv(df, file = "rmp_data.csv" )
