---
output:
  html_document:
    smart: false
---

# Homework 8

## Summary of Project

In the last two assignments I both worked with analyzing Trump's tweets. I decided to continue this because I find it fun and it's something I can share with friends and family. My goal for this project is to create something that they'd enjoy playing around with. Here is the [link to project](https://arsbar.shinyapps.io/sitefiles/) so you can decide how successful I was.

The major change here from the last assignment is the inclusion of a larger data set that I found from [this site](http://www.trumptwitterarchive.com/) (that saved me from having to navigate twitter API)---this is different from the linked dataset provided two assignments ago which only covered around 6 months. This dataset presented its own set of difficulties detailed below. I also make use of the scalability I introduced in the last assignment: one can add more and more sets of phrases without significantly slowing down the site.

I also plot the number of total tweets (scaled down by 10 so as not to ruin the scale) to form a reference point. Ideally I would've preferred to have the `weight` parameter for `geom_density` take into account how many tweets there are in the time range (so that I plot phrase usage per tweet, and peaks/troughs are less indicative of Trump's general tweeting pattern than what's on his mind), but I'm not sure if there's an easy way to do that in R.

## Table of contents

All the files necessary to create the site are in the [SiteFiles](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw08/TrumpTweets) folder. However I also included my data download files in this folder. Trumpto2017 is the database of Trump's tweets until this year, while [DataManagement.R](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw08/DataManagement.R) cleans data (which may be re-downloaded) and saves it as the `tweets.rda` file in the TrumpTweets folder (originally it also downloaded new data, but this proved quite complicated merge so I cut this part out).

## Progress Report

I found this project quite challenging, with numerous difficulties I often had to brute force.

* I had some challenges managing the time format again. I found that it's possible to convert strings of general time formats from [stack overflow](https://stackoverflow.com/questions/21667212/converting-datetime-string-to-posixct-date-time-format-in-r).

* There was some problem managing the data. A lot of it was improperly handled by `read.csv()`. Originally I tried filtering all those whose text was over the tweet limit, but then I found I was reading my csv file wrong thanks to [stack overflow](https://stackoverflow.com/questions/17414776/read-csv-warning-eof-within-quoted-string-prevents-complete-reading-of-file).

* I resorted to calculating a bunch of stuff in each render in `server`. I tried defining the functions to be reactive, but this resulted in a lot of things going wrong (many different things needed to be reactive) and problems to solve, so I decided not to do it. It would've been easier if I had started with them reactive from the beginning.
