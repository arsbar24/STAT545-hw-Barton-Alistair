# Gapminder Exploration

This is my first time using RMarkdown. Let's see how it goes.

First I will download the Gapminder dataset and the Tidyverse package:


```r
library(gapminder)
library(tidyverse)
```

```
## Loading tidyverse: ggplot2
## Loading tidyverse: tibble
## Loading tidyverse: tidyr
## Loading tidyverse: readr
## Loading tidyverse: purrr
## Loading tidyverse: dplyr
```

```
## Conflicts with tidy packages ----------------------------------------------
```

```
## filter(): dplyr, stats
## lag():    dplyr, stats
```

Now let's see what this package is about:

```r
glimpse(gapminder)
```

```
## Observations: 1,704
## Variables: 6
## $ country   <fctr> Afghanistan, Afghanistan, Afghanistan, Afghanistan,...
## $ continent <fctr> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asi...
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```

Hmmm, it seems to be a rough statistical profile of the standards of living in various countries over time. Let's see what different insights we can get from this. We expect living conditions in general to improve over time, is this true? We can test this expectation by plotting GDP per capita and live expectancy against time:

```r
plot(lifeExp ~ year, gapminder)
```

![](gapminder-exploration_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
plot(gdpPercap ~ year, gapminder)
```

![](gapminder-exploration_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

The life expectancy graph looks pretty promising, but the GDP plot is distorted by a couple outliers, let's try to take them out.

```r
# find outlier
outlier <- filter(gapminder, gdpPercap == max(gdpPercap))
Outcountry  <- outlier$country
# remove outlier
GdpTable <- filter(gapminder, country != Outcountry)

plot(GdpTable$gdpPercap~GdpTable$year)
```

![](gapminder-exploration_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

The improvement becomes clearer, but it looks like it's mostly restricted to wealthier countries. Let's see how much improvement there is for the median country:

```r
gapminder %>%
    group_by(year) %>%
    summarise(median(gdpPercap))
```

```
## # A tibble: 12 x 2
##     year `median(gdpPercap)`
##    <int>               <dbl>
##  1  1952            1968.528
##  2  1957            2173.220
##  3  1962            2335.440
##  4  1967            2678.335
##  5  1972            3339.129
##  6  1977            3798.609
##  7  1982            4216.228
##  8  1987            4280.300
##  9  1992            4386.086
## 10  1997            4781.825
## 11  2002            5319.805
## 12  2007            6124.371
```

This shows that significant growth extends at least to the 50th percentile country, but how does it evolve for the poorer countries?


```r
# find the poorer countries at the beginning of the dataset
then <- filter(gapminder, year == min(year))
lowstart  <- filter(then, gdpPercap < median(gdpPercap))
lowGdp <- filter(gapminder, country %in% lowstart$country)
# plot
plot(lowGdp$gdpPercap~lowGdp$year)
```

![](gapminder-exploration_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

This seems to indicate that other than a few outliers, growth is very modest. Let's find out who those outliers are

```r
lowGdp %>%
  arrange(desc(gdpPercap)) %>% 
  filter(year == max(year)) %>% 
  select(country,continent,gdpPercap,everything(),-year)
```

```
## # A tibble: 71 x 5
##                   country continent gdpPercap lifeExp      pop
##                    <fctr>    <fctr>     <dbl>   <dbl>    <int>
##  1                 Taiwan      Asia 28718.277  78.400 23174294
##  2            Korea, Rep.      Asia 23348.140  78.623 49044790
##  3                   Oman      Asia 22316.193  75.640  3204897
##  4               Botswana    Africa 12569.852  50.728  1639131
##  5               Malaysia      Asia 12451.656  74.241 24821286
##  6      Equatorial Guinea    Africa 12154.090  51.579   551201
##  7              Mauritius    Africa 10956.991  72.801  1250882
##  8               Thailand      Asia  7458.396  70.616 65068149
##  9 Bosnia and Herzegovina    Europe  7446.299  74.852  4552198
## 10                Tunisia    Africa  7092.923  73.923 10276158
## # ... with 61 more rows
```

These results are not encouraging for poorer countries hoping to increase their wealth without foreign aid. Of the three highest countries (Taiwan, South Korea, Oman---whose current GDP's are almost double the next highest), Taiwan and Korea were at (civil) war at the beginning of the dataset and recieved significant American economic support in the aftermath, while Oman was largely dependent on the discovery of oil during their surge in GDP. We can further see that only ten countries made the jump from below median GDP to above median GDP over the 55 years in the dataset, allowing us to deduce that relative wealth is generally fairly static.
