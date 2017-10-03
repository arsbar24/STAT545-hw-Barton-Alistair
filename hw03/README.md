## Homework 3 Process Report

* Had trouble using `sum()` with the `yearslived` and `pop` variables due to overflow. Followed R's instructions to use `sum(as.numeric())`.

* I took inspiration for many of my graphs from from [Jenny Bryan's deck on ggplot](https://speakerdeck.com/jennybc/ggplot2-tutorial). In particular for examples of how to use `facet_wrap()` and `geom_smooth()`.

* I chose the `method` for `geom_smooth()` either by using `auto` or whichever method gave me a fitting line.

* I figured out how to label my graphs from one of the students I peer reviewed for Assignment 2 (Ziming Yin).

* I tried to add a line corresponding to my weighted mean life expectancy to my __Life expectancy over time__ graph. I found some help on StackOverflow, but ran into problems as the data sets were different lengths (weighted mean life expectancy has one value for each year, whereas gapminder has ~150) and used a trend line instead. Unsure how I would make it work otherwise.

* Tried to do the layout stretch goal but couldn't find a way to make it look good without using `echo = FALSE`.
