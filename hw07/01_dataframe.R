library(purrr)
library(tidyverse)

load(file = "tweets.rda") # load data from last step

tweets <- trump_tweets_df$text
time <- trump_tweets_df$created

# words we're looking for
Trumpisms <- "huge|wall|crooked|best|believe|win|lose|make america|sad"

matches <- gregexpr(Trumpisms, tweets) 

nummatch <- map(matches, ~ sum(.x > 0)) # count number of matches in each tweet

nummatch <- as.numeric(nummatch)

df <- data.frame(time,nummatch)

df2 <- df %>% 
  gather(wordtype, count, nummatch) # re-arrange data for plotting

# save data

write.table(df2, "tweetdata.tsv", quote = FALSE, sep = "\t", qmethod = "double", row.names = FALSE)

# save sets of words we're looking for (for Rmd file)

Trumpisms <- data.frame(Trumpisms)

colnames(Trumpisms) <- "Words"

write.table(Trumpisms, "Words.csv", row.names = FALSE)

