ui <- fluidPage(
  titlePanel("Trump's Tweets"),
  "This site will show you the frequency of Trump's tweets on certain topics. Note that it is based on a recent database and should contain all of his tweets at least since 2016 (and most preceding that). You can enter multiple phrases by using commas, and look for variants of the same phrase using the pipe key \"|\".",
  br(),
  "I include some information on inspiration at the bottom of the page that I encourage you to look at if you're interested. This is part of an assignment for STAT 545 at UBC, as such the source code is located at ",
  a("my GitHub.", target = "_blank", href = "https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw08/TrumpTweets"),
  sidebarLayout(
    sidebarPanel(
      checkboxInput("all_tweets", "Include graph of all tweets (at 1/10th scale)?", TRUE),
      dateRangeInput("time_range", "Choose a time range for tweets:", start = as.Date("2015-06-16"), end = as.Date(Sys.Date())),
      textInput("words","Enter words/phrases", "Hillary, America|USA"),
      textInput("wordtypes","Enter Labels for above phrases", "Hillary Clinton, Country"),
      selectInput("ranked", "Sort tweets by", choices = c("Retweets", "Favourites"))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      h2("Top tweets using selected phrases"),
      tableOutput("top_tweets")
    )
  ),
  "Data taken from",
  a("this website", target = "_blank", href = "http://www.trumptwitterarchive.com/archive"),
  "on November 19th.",
  "If this data analysis of Trump's tweets looks familiar, it's probably because of this very excellent comparison of tweets on Trump's account by himself and by his staff at",
  a("this site", target = "_blank", href = "http://varianceexplained.org/r/trump-tweets/"),
  "(which served as some inspiration for me)."
)
