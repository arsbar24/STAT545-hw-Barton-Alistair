library(purrr)
library(tidyverse)

load(file = "tweets.rda") # load data from last step

tweets <- trump_tweets_df$text
time <- trump_tweets_df$created

# words we're looking for
wordtypes <- c()
Trumpisms <- c()
wordtypes[1] <- "Trumpisms"
Trumpisms[1] <- "huge|wall|crooked|best|believe|win|lose|great again|MAGA|sad|best"
wordtypes[2] <- "Other candidates"
Trumpisms[2] <- "Hillary|Bernie|Ted Cruz|Ben Carson|Bush"
wordtypes[3] <- "Places"
Trumpisms[3] <- "China|Mexico|Canada|America|Europe"



match <- function(words, tweets = tweets){
  matches <- gregexpr(words,tweets)
  nummatches <- map(matches, ~ sum(.x > 0))
  as.numeric(nummatches)
}

# count number of matches in each tweet
nummatch <- lapply(Trumpisms, function(x) match(x,tweets))
nummatch <- data.frame(nummatch)
colnames(nummatch) <- wordtypes

df <- data.frame(time,nummatch)

# re-arrange data for plotting
df2 <- df %>% 
  gather(wordtype, count, colnames(df)[2]:colnames(df)[ncol(df)])

# count number of occurences for each word
total_occ<- df2 %>% 
  group_by(wordtype) %>% 
  summarize('occurences' = sum(count)) %>% 
  data.frame()

write.table(total_occ, "Occ.tsv", sep = "\t", row.names = FALSE)

# save data

write.table(df2, "tweetdata.tsv", quote = FALSE, sep = "\t", qmethod = "double", row.names = FALSE)

# save sets of words we're looking for (for Rmd file)

Trumpisms <- data.frame("wordtype" = wordtypes, "Words" = Trumpisms)

write.table(Trumpisms, "Words.tsv", sep = "\t", row.names = FALSE)

