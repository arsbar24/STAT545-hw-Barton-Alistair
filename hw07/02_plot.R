library(purrr)
suppressMessages(library(dplyr))
library(tibble)
suppressPackageStartupMessages(library(tidyverse))

df <- read.delim("tweetdata.tsv")

df$time <- as.POSIXct(df$time)
df$count <- as.double(df$count)

p <- ggplot(df, aes(x=time, fill = wordtype)) + 
  geom_density(aes(weight = count), alpha = 0.2)

ggsave("tweet_freq.png", device = "png")
