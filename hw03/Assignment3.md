# Assignment 3




Loading packages:



>Get the maximum and minimum of GDP per capita for all continents.


continent    maxGDPpcap   minGDPpcap
----------  -----------  -----------
Africa         21951.21     241.1659
Americas       42951.65    1201.6372
Asia          113523.13     331.0000
Europe         49357.19     973.5332
Oceania        34435.37   10039.5956

To illustrate this range, I used a boxplot:

![](Assignment3_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

> Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean.


 year   mean life expectancy
-----  ---------------------
 1952               48.94424
 1957               52.12189
 1962               52.32438
 1967               56.98431
 1972               59.51478
 1977               61.23726
 1982               62.88176
 1987               64.41635
 1992               65.64590
 1997               66.84934
 2002               67.83904
 2007               68.91909

For my accompanying graph I decided to plot the distribution of life expectancy with a curve fitted to it through the `geom_smooth()` function---it won't be a weighted average, but it should be close (I was unsucessful in my attempts to plot the weighted average on top, as documented in the [README](https://github.com/arsbar24/STAT545-hw-barton-alistair/blob/master/hw03/README.md)):


```
## `geom_smooth()` using method = 'gam'
```

![](Assignment3_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


> How is life expectancy changing over time on different continents?

I include a small table of the values for each continet every 15 years (to keep the table compact). I also use two plots: one of the (weighted) average life expectancy on each continent (to show short term trends and for easy comparison), and one of the distribution on each continent (to show outliers and long-term trends):


continent    year   meanlifeExp
----------  -----  ------------
Africa       1952      38.79973
Africa       1967      45.17721
Africa       1982      51.01744
Africa       1997      53.28327
Americas     1952      60.23599
Americas     1967      64.50630
Americas     1982      69.19264
Americas     1997      73.19154
Asia         1952      42.94114
Asia         1967      53.88261
Asia         1982      61.57472
Asia         1997      66.77092
Europe       1952      64.90540
Europe       1967      69.54963
Europe       1982      72.56247
Europe       1997      75.70849
Oceania      1952      69.17040
Oceania      1967      71.17848
Oceania      1982      74.58291
Oceania      1997      78.61843

![](Assignment3_files/figure-html/unnamed-chunk-6-1.png)<!-- -->![](Assignment3_files/figure-html/unnamed-chunk-6-2.png)<!-- -->

We can see that all the continents have improved significantly, especially Asia (aside from a brief fall in life expectancy in 1962) with Africa's improvement slowing down significantly since 1990. We can also see the disparities between countries on each continent, oceania seems to be consistently high (although it may be benefited from having few countries) and European countries seems to be converging, while diverging Africa has a few outliers with life expectancy over 70 and Asia seems to have medium life expectancy except one extreme outlier with life expectancy around 40 (I suspect Afghanistan).

> Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.

I will choose the benchmark of my father's age of 57. This makes the data more meaningful as it's difficult to imagine living in a country where most people my age have lost a parent (although this may be offset by younger ages of new parents). 


continent    year   lowLifeExppcent
----------  -----  ----------------
Africa       1952              1.00
Americas     1952              0.60
Asia         1952              0.82
Europe       1952              0.10
Africa       1962              0.96
Americas     1962              0.40
Asia         1962              0.76
Europe       1962              0.03
Africa       1972              0.96
Americas     1972              0.24
Asia         1972              0.52
Africa       1982              0.77
Americas     1982              0.12
Asia         1982              0.24
Africa       1992              0.60
Americas     1992              0.04
Asia         1992              0.15
Africa       2002              0.71
Asia         2002              0.06

![](Assignment3_files/figure-html/unnamed-chunk-7-1.png)<!-- -->


We can see that Oceania hasn't had such countries during the range of this dataset while Europe and the Americas no longer have any such countries. Asia has also raised the life expectancy above 57 in almost every country (aside from, I suspect, only Afghanistan). Unfortunately Africa remains the only continent far away from this level: while at the beginning of the dataset every single african country had a 'low' life expectancy, today about two thirds of african countries still have a 'low' life expectancy! 

In fact the number of african countries with a 'low' life expectancy has actually increased since 1992! This regress is somewhat obscured in the prior graph, although it does correspond to the flattening out of Africa's mean life expectancy.

> Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class.

## Zimbabwe

I find this regress concerning and perplexing, so I'm going to make a case study of what I estimate to be the prototype of this trend: Zimbabwe. This following table of the countries with the worst regresses in that time frame lends justification to this choice:


country           delta   population
-------------  --------  -----------
Zimbabwe        -20.388     10704340
Botswana        -16.111      1342614
Lesotho         -15.092      1803195
Swaziland       -14.605       962344
Namibia         -10.520      1554253
South Africa     -8.523     39964159

As we can see, Zimbabwe had the worst change in life expectancy during the regress. Furthermore many of its neighbours join it near the top of the list, in fact each of the worst six changes in life expectancy are in southern Africa. Thus Zimbabwe is not only the worst affected, but the geographic centre of the regress.

Next, we look at how the living standards in Zimbabwe have changed over time:

![](Assignment3_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

We can see that there seems to be a somewhat normal progression (albeit slow GDP growth) until 1990 where this calamity hits, at which point life expectancy decreased to the lowest level since data collection began, and remains around there at the end of our data collection (culminating in a drop of almost 40% over 15 years). Interestingly GDP per capita doesn't seem to take a significant hit until 15 years after the disaster.

This downturn may be attributed to the [HIV epidemic in the region in the 90s](https://en.wikipedia.org/wiki/HIV/AIDS_in_Africa#Southern_Africa), which also affected neighbouring countries. The crash in GDP per capita in the mid-2000s seems to correlate with the worst periods of the [infamous Zimbabwe hyperinflation](https://en.wikipedia.org/wiki/Hyperinflation_in_Zimbabwe#Inflation_rate) and may also have something to do with the land reform policies around the turn of the century that (quoting wikipedia) "put [land] in the hands of inexperienced people".




