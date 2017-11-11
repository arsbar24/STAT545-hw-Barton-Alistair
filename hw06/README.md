## Summary
**Question 2**: In this question I continue a bit of my work from hw05. There I explored how to visualize data in maps using the `mapdata` package. I think this is something I'm likely to want to do in the future as well, so I decided to write a function that plots gapminder-style data in a map. This work is located in the ![mapfunction file](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw06/mapfunction.md).

**Question 3**: For my second question, I decided to do some data-wrangling, as I hadn't done any in a while and wanted to revisit it before I got rusty. Here I investigate the correlations between love of candy and age and optimism about how many mints are in the persons hand. This question is located in the ![candy file](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw06/Candy.md).

**Question 5**: I didn't really need the extension, so I decided to play around with this question, in particular with analysis of Trump's tweets. Here my goal was to show how one might calculate the frequency of Trump's usage of different words, and do it myself for some of the more familiar "Trumpisms". This question is located in the ![little bird file](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw06/LittleBird.md).

## Progress Report
This project was pretty fun. I think there might've been easier ways to do some of my work--e.g. counting the number of JOYs in each row, which I did via a very slow function--but I wanted to see how little I could rely on exterior resources (feel free to let me know if you see alternative methods though). 

There were only a couple times I needed to resort to the internet. The first was when defining my map function. I have an argument `varfill` that specifies which variable to use to colour each country that I was trying to pass to the `fill` option in `geom_polygon()`, but it wasn't working. The problem was that my argument was read as a string (e.g. filling in countries according to `"pop"`), so `geom_polygon` was filling in countries according to a single value, resulting in each country having the same colouring. I found a work around in stackoverflow ![here](http://stackoverflow.com/questions/17792929/pass-string-as-name-of-attached-data-column-name).

I also had forgotten how to put plots side-by-side so I had to use some stackoverflow help again, this time ![here](https://stackoverflow.com/questions/1249548/side-by-side-plots-with-ggplot2).

Of course, I also had to figure out how to use the mapdata, but that was done in the last assignment. You can read about my challenges with that ![here](https://github.com/arsbar24/STAT545-hw-barton-alistair/tree/master/hw05). 

For Trump's tweets I finally had the chance to use the density plots I had learnt from reviewing a ![classmates assignment](https://github.com/ZimingY/STAT545-hw-YIN-ZIMING/blob/master/hw2/hw02.md), and referred to the class notes to remind myself how `gather()` worked.
