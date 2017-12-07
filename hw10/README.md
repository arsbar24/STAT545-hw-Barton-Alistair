# Homework README

## Summary
For this assignment, I decided that I would like to scrape data from [RateMyProfessor](http://www.ratemyprofessors.com/), mainly to see if there are any interesting patterns there (for the unfamiliar RMP is a site where students can review professors they've taken courses from, these reviews include ratings and various other pieces of information, see screenshot below). 

![](figures/SampleReview.png)

The function I used is in the [dataframing.R](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw10/dataframing.R) file, and collects various pieces of information pertaining to the review (in particular: the University, Department, Professor, Course, Difficulty, the overall rating, their comments, Date of review, how many people found it helpful/unhelpful, and the grade obtained by the reviewer).

## [Scraping function](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw10/dataframing.R)

Most of these were pretty simple to get, but there were a few exceptions:

* The university, department, and professor are not included in `class` tags, but had to be obtained from other html tags and parsed from longer strings using `substr()`.

* The grade is shown in letter grade form. This is fine, but I found it easier to convert to GPA for comparison purposes (I also replaced withdrawn and similar cases with `NA`)--same for difficulty and overall rating.

* The number of people who found a review helpful/unhelpful were listed in the same class, so I had to sort that out by even/odd indices.

* I also had to exit the function if there were no reviews of a professor, otherwise it would throw a spanner in the works as finding the odd/even indices would not work.

* Only up to 20 reviews are automatically listed for each professor; you can click to load more at the bottom of the screen. I couldn't find where this information was listed in the html, so I just took the 20 reviews. If anyone reading this knows how to get around this I would be interested in hearing.

## Scraping data

Once I had the function, I used a loop to cycle through the data corresponding to a few hundred professors. I managed this by noticing that each page is linked by a `tid` number, which covers a range between 7543 and 14937. I used `rbind()` to concatenate the data into one dataframe, then saved it to the [`rmp_data.csv`](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw10/rmp_data.csv) file. This is also included in the [dataframing.R](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw10/dataframing.R) file.

## [RMD file](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw10/ScrapingBy.Rmd)

This file showcases a couple of ways to use the data.

## Makefile

I used a makefile in order to update my project to make it consistent before any uploads, but my project ended up having a much simpler structure than I anticipated, so I don't think it was necessary strictly speaking.
