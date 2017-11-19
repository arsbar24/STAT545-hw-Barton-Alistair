library(dplyr)
library(stringr)

# Turns csv file into RDA while removing unneeded data

oldtweets <- read.csv("Trumpto2017.csv", quote = "")

oldtweets <- select(oldtweets, -id_str, -is_retweet, -source)
oldtweets$retweet_count <- as.integer(oldtweets$retweet_count)
oldtweets$text <- as.character(oldtweets$text)
oldtweets$created_at <- as.POSIXct(oldtweets$created_at, format="%m-%d-%Y %H:%M:%S")

JSON <- fromJSON(file= "http://www.trumptwitterarchive.com/data/realdonaldtrump/2017.json")

json_file <- lapply(JSON, unlist)
newtweets <- as.data.frame(do.call("rbind", json_file)) %>% 
  na.omit() %>% 
  select(-in_reply_to_user_id_str)

newtweets <- select(newtweets, -id_str, -is_retweet, -source)

newtweets$text <- as.character(newtweets$text)
newtweets$retweet_count <- as.integer(newtweets$retweet_count)
newtweets$created_at <- as.POSIXct(newtweets$created_at, format="%a %b %d %H:%M:%S %z %Y")

Trump <- rbind(newtweets,oldtweets)
# change into time from string to a time format

Trump$text <- Trump$text %>% 
  as.character()

# now remove unnecessary data
trump_tweets_df <- na.omit(Trump)

colnames(trump_tweets_df) <- c("text", "created", "retweetCount", "favoriteCount")

saveRDS(trump_tweets_df, file = "TrumpTweets/tweets.rda")