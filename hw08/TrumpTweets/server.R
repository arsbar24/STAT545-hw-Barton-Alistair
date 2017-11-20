library(shiny)
library(ggplot2)
library(dplyr)
library(purrr)
library(tidyverse)
library(scales)

load(file = "tweets.rda")

# drop unnecessary columns
Trump_tweets <- trump_tweets_df %>% 
  mutate(time = created, favourites = favoriteCount, retweets = retweetCount) %>% 
  select(time, text, favourites, retweets)

# function that counts the number of times a word appears in each tweet
matchword <- function(words, tweets = tweets){
  matches <- gregexpr(words,tweets)
  nummatches <- map(matches, ~ sum(.x > 0))
  as.numeric(nummatches)
}

server <- function(input, output) {
  output$coolplot <- renderPlot({
    # split entries into vectors
    words <- unlist(strsplit(input$words,", "))
    wordtypes <- unlist(strsplit(input$wordtypes,", "))
    if(length(words) != length(wordtypes)){
      stop("Must have label for each word category")
    }
    
    # apply time constraint
    filtered <- Trump_tweets %>%
      filter(time >= input$time_range[1],
             time <= input$time_range[2])
    
    # find tweets with requested words in them
    nummatch <- lapply(words, function(x) matchword(x,filtered$text))
    # make data frame
    if(input$all_tweets == TRUE){    # add column for all tweets
      wordtypes <- c(wordtypes, "All tweets (1/10 scale)")
      nummatch <- data.frame(nummatch, rep(1/10,nrow(filtered)))
    }
    else{
      nummatch <- data.frame(nummatch)
    }
    
    # change name of columns
    colnames(nummatch) <- wordtypes
    df <- data.frame(filtered,nummatch, check.names = FALSE)
    # re-arrange data for plotting
    df2 <- df %>% 
      gather(wordtype, count, colnames(df)[5]:colnames(df)[ncol(df)])
    
    ggplot(df2, aes(x=time, fill = wordtype)) + 
      geom_density(aes(weight = count), alpha = 0.2)
  })
  output$top_tweets <- renderTable({
    # same as above
    words <- unlist(strsplit(input$words,", "))
    wordtypes <- unlist(strsplit(input$wordtypes,", "))
    filtered <- Trump_tweets %>%
      filter(time >= input$time_range[1],
             time <= input$time_range[2])
    nummatch <- lapply(words, function(x) matchword(x,filtered$text))
    nummatch <- data.frame(nummatch)
    colnames(nummatch) <- wordtypes
    df <- data.frame(filtered,nummatch)   
    # find tweets with one of the requested words
    if(ncol(df) == 5){
      relevant <- df %>% 
        filter(df[5] > 0)
    }
    else{
      relevant <- df %>% 
        filter(rowSums(df[,colnames(df[5:ncol(df)])]) > 0)
    }
    # find most favourited or retweeted tweets with said words
    if(input$ranked == "Favourites"){
      topTweets <- arrange(relevant, desc(favourites))
    }
    else{
      topTweets <- arrange(relevant, desc(retweets))
    }
    # make data print friendly
    topTweets$time <- as.character(topTweets$time)
    topTweets[3:4] <- mapply(as.integer,topTweets[3:4])
    head(topTweets[1:4])
  })
}