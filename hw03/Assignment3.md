# Assignment 3




Loading packages:


```r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gapminder))
```

>Get the maximum and minimum of GDP per capita for all continents.


```r
gapminder %>% 
  group_by(continent) %>% 
  summarise(maxGDPpcap = max(gdpPercap), minGDPpcap = min(gdpPercap))
```

```
## # A tibble: 5 x 3
##   continent maxGDPpcap minGDPpcap
##      <fctr>      <dbl>      <dbl>
## 1    Africa   21951.21   241.1659
## 2  Americas   42951.65  1201.6372
## 3      Asia  113523.13   331.0000
## 4    Europe   49357.19   973.5332
## 5   Oceania   34435.37 10039.5956
```

> Look at the spread of GDP per capita within the continents.


```r
gapminder %>% 
  group_by(continent) %>% 
  summarise(GDPspread = max(gdpPercap) - min(gdpPercap))
```

```
## # A tibble: 5 x 2
##   continent GDPspread
##      <fctr>     <dbl>
## 1    Africa  21710.05
## 2  Americas  41750.02
## 3      Asia 113192.13
## 4    Europe  48383.66
## 5   Oceania  24395.77
```

To illustrate the GDP spread from the past two questions, I used a boxplot:


```r
p <- ggplot(gapminder, aes(x = continent, y = gdpPercap)) + geom_boxplot(alpha = 0.5)
p + labs(title = 'Distribution of GDP per Capita') # labels
```

![](Assignment3_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

> Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean.


```r
gapminder %>% 
  mutate(yearslived = lifeExp*pop) %>% # total years lived in each country
  group_by(year) %>% 
  summarise(meanlifeExp = sum(as.numeric(yearslived))/sum(as.numeric(pop))) # weighted average
```

```
## # A tibble: 12 x 2
##     year meanlifeExp
##    <int>       <dbl>
##  1  1952    48.94424
##  2  1957    52.12189
##  3  1962    52.32438
##  4  1967    56.98431
##  5  1972    59.51478
##  6  1977    61.23726
##  7  1982    62.88176
##  8  1987    64.41635
##  9  1992    65.64590
## 10  1997    66.84934
## 11  2002    67.83904
## 12  2007    68.91909
```

For my accompanying graph I decided to plot the distribution of life expectancy with a curve fitted to it through the `geom_smooth()` function---it won't be a weighted average, but it should be close:


```r
p <- ggplot(gapminder, aes(x = year, y = lifeExp)) + geom_point(alpha = 0.1) + labs(title = 'Life expectancy over time')
p + geom_smooth(method = 'auto') # fitted curve 
```

```
## `geom_smooth()` using method = 'gam'
```

![](Assignment3_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


> How is life expectancy changing over time on different continents?

To investigate this we use two plots, one of the average life expectancy (to show short term trends and for easy comparison) and one of the distribution for each continent (to show outliers and long-term trends):


```r
# create dataset with continent, year, and weighted average of life expectancy 
conts <- gapminder %>% 
  mutate(yearslived = lifeExp*pop) %>%
  group_by(continent,year) %>% 
  summarise(meanlifeExp = sum(as.numeric(yearslived))/sum(as.numeric(pop))) 

# plot with colours indicating continent
p <- ggplot(conts, aes(x = year, y = meanlifeExp)) + labs(title = 'Mean life expectancy over time')
p + geom_point(aes(colour = continent))
```

![](Assignment3_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
# plot distribution for each continent
p <- ggplot(gapminder,aes(y = lifeExp, x = year)) + labs(title = 'Life expectancy on each continent')
p <- p + facet_wrap(~ continent) + geom_point(alpha = 0.2) # separate graphs for each continent
p + geom_smooth(method = 'loess', lwd = 0.5, se = T) # trend lines
```

![](Assignment3_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

We can see that all the continents have improved significantly, especially Asia (aside from a brief fall in life expectancy in 1962) with Africa's improvement slowing down significantly since 1990. We can also see the disparities between countries on each continent, oceania seems to be consistently high (although it may be benefited from having few countries) and European countries seems to be converging, while diverging Africa has a few outliers with life expectancy over 70 and Asia seems to have medium life expectancy except one outlier with life expectancy around 40 (I suspect Afghanistan).

> Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.

I will choose the benchmark of my father's age of 57. This makes the data more meaningful as it's difficult to imagine living in a country where most people my age have lost a parent (although this may be offset by younger ages of new parents). 


```r
# create dataset with continent, year, and number of countries with 'low' life expectancy
conts <- gapminder %>% 
  group_by(continent, year) %>% 
  summarise(lowLifeExppcent = sum(lifeExp < 57)/length(lifeExp))

ggplot(conts,aes(y = lowLifeExppcent, x = year)) + geom_line(aes(colour = continent)) + labs(title = "Countries with low life expectancy over time", y = "Percent with low life expectancy") 
```

![](Assignment3_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


We can see that Oceania hasn't had such countries during the range of this dataset while Europe and the Americas no longer have any such countries. Asia has also raised the life expectancy above 57 in almost every country (aside from, I suspect, only Afghanistan). Unfortunately Africa remains the only continent far away from this level: while at the beginning of the dataset every single african country had a 'low' life expectancy, today about two thirds of african countries still have a 'low' life expectancy! 

In fact the number of african countries with a 'low' life expectancy has actually increased since 1992! This regress is somewhat obscured in the prior graph, although it does correspond to the flattening out of Africa's mean life expectancy.

> Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class.

# Zimbabwe

I find this regress concerning and perplexing, so I'm going to make a case study of what I estimate to be the prototype of this trend: Zimbabwe.


```r
gapminder %>% 
  filter(continent == 'Africa', year > 1990, year < 2005) %>% 
  group_by(country) %>% 
  summarise(delta = lifeExp[3]-lifeExp[1], population = pop[1]) %>% # change in life expectancy over these years
  arrange(delta) %>% # list with worst decreases first
  head()
```

```
## # A tibble: 6 x 3
##        country   delta population
##         <fctr>   <dbl>      <int>
## 1     Zimbabwe -20.388   10704340
## 2     Botswana -16.111    1342614
## 3      Lesotho -15.092    1803195
## 4    Swaziland -14.605     962344
## 5      Namibia -10.520    1554253
## 6 South Africa  -8.523   39964159
```

As we can see, Zimbabwe had the worst change in life expectancy during the regress. Furthermore many of its neighbours join it near the top of the list, in fact each of the worst six changes in life expectancy are in southern Africa. Thus Zimbabwe is not only the worst affected, but the locus of the regress.

Next, we look at how the living standards in Zimbabwe have changed over time:


```r
zimbData <- filter(gapminder, country == 'Zimbabwe') 

ggplot(zimbData, aes(x = year, y = lifeExp)) + geom_point(aes(size = gdpPercap)) + labs(title = "Zimbabwe QoL over time") 
```

![](Assignment3_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

We can see that there seems to be a somewhat normal progression (albeit slow GDP growth) until 1990 where this calamity hits, at which point life expectancy decreased to the lowest level since data collection began, and remains around there at the end of our data collection (culminating in a drop of almost 40% over 15 years). Interestingly GDP per capita doesn't seem to take a significant hit until 15 years after the disaster.

This downturn may be attributed to the [HIV epidemic in the region in the 90s](https://en.wikipedia.org/wiki/HIV/AIDS_in_Africa#Southern_Africa), which also affected neighbouring countries. The crash in GDP per capita in the mid-2000s seems to correlate with the worst periods of the [infamous Zimbabwe hyperinflation](https://en.wikipedia.org/wiki/Hyperinflation_in_Zimbabwe#Inflation_rate) and may also have something to do with the land reform policies around the turn of the century that (quoting wikipedia) "put [land] in the hands of inexperienced people".




