# Assignment4




```r
library(gapminder)
suppressPackageStartupMessages(library(tidyverse))
```


## General data reshaping and relationship to aggregation


## Join, merge, look up (Activity #1)

In the last assignment I had wanted to superimpose a line plot corresponding to the weighted mean of the life expectancy on top of a graph of life expectancy. I didn't know how to do it at the time, but I bet I can use a join function to do it now!

### Step 1: create complementary dataframe

The first step is to create a dataframe that lists the weighted mean life expectancy for each continent and year:


```r
weightLifeExp <- gapminder %>%
  mutate(yearsLived = lifeExp*pop) %>% 
  group_by(year,continent) %>% 
  summarise(meanLifeExp = sum(as.numeric(yearsLived))
            /sum(as.numeric(pop)))

head(weightLifeExp)
```

```
## # A tibble: 6 x 3
## # Groups:   year [2]
##    year continent meanLifeExp
##   <int>    <fctr>       <dbl>
## 1  1952    Africa    38.79973
## 2  1952  Americas    60.23599
## 3  1952      Asia    42.94114
## 4  1952    Europe    64.90540
## 5  1952   Oceania    69.17040
## 6  1957    Africa    40.94031
```

For fun, I will also include (via a `_join` function!) Antarctica with life expectancy *N/A* in the dataset (to make the different types of joins non-trivial).


```r
# create Antarctica
Antarctica <- gapminder %>% 
  filter(country == "Canada") %>% 
  select(year) %>% 
  mutate(continent = factor('Antarctica'))

# integrate Antarctica into the data
weightLifeExp <- weightLifeExp %>% 
  full_join(Antarctica) %>% 
  arrange(year, continent)
```

```
## Joining, by = c("year", "continent")
```

```
## Warning: Column `continent` joining factors with different levels, coercing
## to character vector
```

```r
head(weightLifeExp)
```

```
## # A tibble: 6 x 3
## # Groups:   year [1]
##    year  continent meanLifeExp
##   <int>      <chr>       <dbl>
## 1  1952     Africa    38.79973
## 2  1952   Americas    60.23599
## 3  1952 Antarctica          NA
## 4  1952       Asia    42.94114
## 5  1952     Europe    64.90540
## 6  1952    Oceania    69.17040
```



### Step 2: join data frames

Now we can join the two dataframes using `_join` functions (I also remove the GDP column for compactness):

```r
meanlifegap <- gapminder %>% 
  full_join(weightLifeExp) %>% 
  select(-gdpPercap)
```

```
## Joining, by = c("continent", "year")
```

```
## Warning: Column `continent` joining factor and character vector, coercing
## into character vector
```

```r
head(meanlifegap)
```

```
## # A tibble: 6 x 6
##       country continent  year lifeExp      pop meanLifeExp
##        <fctr>     <chr> <int>   <dbl>    <int>       <dbl>
## 1 Afghanistan      Asia  1952  28.801  8425333    42.94114
## 2 Afghanistan      Asia  1957  30.332  9240934    47.28835
## 3 Afghanistan      Asia  1962  31.997 10267083    46.57369
## 4 Afghanistan      Asia  1967  34.020 11537966    53.88261
## 5 Afghanistan      Asia  1972  36.088 13079460    57.52159
## 6 Afghanistan      Asia  1977  38.438 14880372    59.55648
```


### Step 3: make plot

Not one of the steps suggested by the assignment, but I personally wanted to redo the plot from my last assignment and see how the weighted mean compared to the `loess` trend line:


```r
ggplot(meanlifegap, aes(year, lifeExp)) + facet_wrap(~ continent) +
  geom_smooth(aes(color = 'blue'), method = loess, show.legend = T) +
  geom_point(alpha = 0.1) + 
  geom_line(aes(x = year, y = meanLifeExp, color = 'red'), show.legend = T) +
  labs(title = 'Life expectancy on each continent', y = 'Life Expectancy') +
  scale_color_discrete(name = "Trend Lines", labels = c("Loess trend line", "Weighted mean")) +
  theme(plot.title = element_text(hjust = 0.5))
```

```
## Warning: Removed 12 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 12 rows containing missing values (geom_point).
```

![](Assignment4_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

We can see that they generally agree, but diverge pretty badly in the Americas and Asia at the beginning of the dataset. We can also see that the use of `full_join()` created an empty Antarctica graph (because all of those values are *NA*), and gave us the error message. 

### Step 4: explore different types of joins

If we wanted to get rid of the empty antarctica plot we could use `left_join()`:
