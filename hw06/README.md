In this project I continue a bit of my work from hw05. There I explored how to visualize data in maps using the `mapdata` package. I think this is something I'm likely to want to do in the future as well, so I decided to write a function that plots gapminder-style data in a map.

This project was pretty fun. I think there might've been easier ways to do some of my work--e.g. counting the number of JOYs in each row, which I did via a very slow function.--but I wanted to see how little I could rely on exterior resources (feel free to let me know if you see alternative methods though). 

There were only a couple times I needed to resort to the internet. The first was when defining my map function. I have an argument that specifies which column to use to colour each country that I was trying to pass to the `fill` option in `geom_polygon()`, but it wasn't working. The problem was that my argument was read as a string, so `geom_polygon` was filling in countries according to a single string (so each country was coloured the same). I found a work around in stackoverflow ![here](http://stackoverflow.com/questions/17792929/pass-string-as-name-of-attached-data-column-name).

I also had forgotten how to put plots side-by-side so I had to use some stackoverflow help again, this time ![here](https://stackoverflow.com/questions/1249548/side-by-side-plots-with-ggplot2)
