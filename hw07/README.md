# Homework 7

## Summary of Homework

## Progress Review

* I had an inordinate amount of difficulty managing my saved data. This was because saving had converted my data to integers, and this is incompatible with `geom_density()`. Changing the counts into doubles was simple (`as.double()`), but it took me a while to figure out how to do it with the dates. Eventually I stumbled upon ![this file](http://biostat.mc.vanderbilt.edu/wiki/pub/Main/ColeBeck/datestimes.pdf) which was a huge help and introduced me to using `as.POSIXct()`.

* I also had a couple problems automatically knitting my Rmd file. One problem's error message suggested it was caused by an outdated version of pandoc, which was fixed once I downloaded the updated version from ![here](https://github.com/jgm/pandoc/releases/tag/2.0.2). The other problem had a much more complex error message, but when I googled it I found ![this stackoverflow thread](https://stackoverflow.com/questions/42427481/pandoc-document-conversion-failed-with-error-2) which suggested I needed to put `smart: false` in the preamble of my Rmd file.