---
output:
  html_document:
    smart: false
---
# Homework 7

## Summary of Homework

In this assignment I automate some of the tasks I did for assignment 6. In particular I automate the analysis of Trump's words for specific words. [Here](Summary.md](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/Summary.md)) is the main md file that summarizes my work.

**A word on organization:** I found my repo getting disorganized with all the files I was keeping, so I moved all of the R scripts into the [MakeFiles](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/MakeFiles) folder and moved all the outputs to the [SummaryFiles](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/SummaryFiles) folder. This made automating the process a little more complicated, but I think it's worth it to have an organized repo (plus I got to learn a bit more about the power of `make`).

I tried moving the `03_summary.Rmd` file into MakeFiles as well, but this didn't work because I couldn't get the path to my image to work with both the location of the Rmd file and the location of the md file after I moved it. Maybe there's a way to do this using some type of non-relative path, but I imagine this might cause problems when I upload the md file to github... If you know any other ways to make this work let me know!

I begin by downloading the data in [`00_download.R`](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/MakeFiles/00_download.R) (the [instructions](https://jennybc.github.io/purrr-tutorial/ls08_trump-tweets.html) for how to do this were given in the last assignment). We then count the occurences of the words in each tweet and build a dataframe in [`01_dataframe.R`](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/MakeFiles/01_dataframe.R) and arrange this data in a dataframe, using `gather()` so that it's ripe for plotting--we also save our the words in the `Words.csv` file so we can input it at the top of this page if we change them. In [`02_plot.R`](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/MakeFiles/02_plot.R) we make a density plot of Trump's usage of these words over time (which we encountered some difficulty with detailed in the README file). And we automate this all in [`Makefile`](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/Makefile) for easy running (which deletes intermediate files), this file also automates the [Rmd file](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw07/03_summary.Rmd) that presents our work.


## Progress Review

* I had an inordinate amount of difficulty managing my saved data. This was because saving had converted my data to integers, and this is incompatible with `geom_density()`. Changing the counts into doubles was simple (`as.double()`), but it took me a while to figure out how to do it with the dates. Eventually I stumbled upon [this file](http://biostat.mc.vanderbilt.edu/wiki/pub/Main/ColeBeck/datestimes.pdf) which was a huge help and introduced me to using `as.POSIXct()` for dates.

* I also had a couple problems automatically knitting my Rmd file. One problem's error message suggested it was caused by an outdated version of pandoc, which was fixed once I downloaded the updated version from [here](https://github.com/jgm/pandoc/releases/tag/2.0.2). The other problem had a much more complex error message, but when I googled it I found [this stackoverflow thread](https://stackoverflow.com/questions/42427481/pandoc-document-conversion-failed-with-error-2) which suggested I needed to put `smart: false` in the preamble of my Rmd file.