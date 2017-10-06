# Homework Summary

### Task 1 (Activity 2)

Comparison of neighbouring countries life expectancies:

- [X] Choose countries
- [X] Spread their life expectancies into a `knitr::kable`
- [X] Scatter their life expectancies

### Task 2 (Activity 1 & 3)

Compare weighted mean life expectancies in different continents. Add Antarctica to the mix and see how `_join()` functions apply.

- [X] create dataframe from gapminder
- [X] fully explore `_join()`s
- [X] sort out `knitr::kable()`
- [X] explore `merge()`
- [X] explore `match()`


## Progress Report

* I was pleasantly surprised that `left_join()` worked when I had two variables to join with (year and continent).

* Found out how to label the different colour scales via StackOverflow.

* Learnt how to do checkmarks on md files via a [github blog post](https://github.com/blog/1375-task-lists-in-gfm-issues-pulls-comments) (I found this really cool).

* Learnt a lot from Jenny Bryan's [join cheatsheet](http://stat545.com/bit001_dplyr-cheatsheet.html#anti_joinsuperheroes-publishers) for integrating my `_join()` functions.

* (Finally) learnt how to incorporate `knitr::kable()` from an [old github discussion](https://github.com/STAT545-UBC/Discussion/issues/136) from this course (that I came across via google).

* Didn't know how to plot 45 degree line so cheated by plotting `geom_line(Nicaragua, Nicaragua)`

* Didn't know how to refer to columns with a space in their title (e.g. if I used South Africa in part 1), so avoided countries like that.
