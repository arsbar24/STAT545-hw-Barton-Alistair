library(purrr)
suppressMessages(library(dplyr))
library(tibble)
suppressPackageStartupMessages(library(tidyverse))

df <- read.delim("tweetdata.tsv")

df$time <- as.POSIXct(df$time)
df$count <- as.double(df$count)

p <- ggplot(df, aes(x=time)) + 
  geom_density()

ggsave("tweet_freq.png", device = "png")
