ui <- fluidPage(
  titlePanel("Trump's Tweets"),
  "This site will show you the frequency of Trump's tweets on certain topics (the graph make take a few seconds to load so be patient). Note that it is based on a recent database and should contain all of his tweets from 2016 to Nov 19 2017 (and most preceding that). You can enter multiple phrases by using commas, and look for variants of the same phrase using the pipe key \"|\".",
  br(),
  br(),
  "I include some information on inspiration at the bottom of the page that I encourage you to look at if you're interested.",
  br(),
  "This is part of an assignment for STAT 545 at UBC, as such the source code is located at ",
  a("my GitHub.", target = "_blank", href = "https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw08/TrumpTweets"),
  sidebarLayout(
    sidebarPanel(
      checkboxInput("all_tweets", "Include plot of all tweets (at 1/10th scale)?", FALSE),
      dateRangeInput("time_range", "Choose a time range for tweets:", start = as.Date("2015-06-16"), end = as.Date(Sys.Date())),
      "(The default time range is from start of his candidacy to today. Other interesting dates are his inauguration (Jan 20 2017), and Super Tuesday (March 1 2016).)",
      textInput("words","Enter words/phrases (case sensitive)", "MAGA|Great Again, Fake News|fake news|Fake news"),
      textInput("wordtypes","Enter Labels for above phrases", "MAGA, Fake News"),
      selectInput("ranked", "Sort tweets by", choices = c("Retweets", "Favourites"))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(),
      "Some interesting search phrases beyond the defaults are his fellow presidential candidates (e.g. \"Hillary\"), ", 
      "some of his policy (\"Tax|tax\", \"Wall|wall\"--the bar is necessary due to case sensitivity), \"Fox\".", 
      br(),
      "Interesting patterns I noticed:",
      tags$ul(
        tags$li("he stopped talking about Obamacare and started talking about first Russia, then Fake news after inauguration."),
        tags$li("Trump recently started talking about his tax plan (\"tax\") a lot more."),
        tags$li("His mentions of Bernie Sanders reached a sharp peaked last July, before quickly fizzling out.")
      ),
      br(),
      h2("Top tweets using selected phrases"),
      tableOutput("top_tweets")
    )
  ),
  "Data taken from",
  a("this website", target = "_blank", href = "http://www.trumptwitterarchive.com/archive"),
  "on November 19th.",
  "If this data analysis of Trump's tweets looks familiar, it's probably because of this very excellent comparison of tweets on his account by himself and those composed by his staff at",
  a("this site", target = "_blank", href = "http://varianceexplained.org/r/trump-tweets/"),
  "(which served as some inspiration for me)."
)
