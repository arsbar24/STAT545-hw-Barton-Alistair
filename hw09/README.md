[Link to package](https://github.com/arsbar24/RegularizedFits)

## Summary of Assignment

I wanted to attempt to create functions that were a little more interesting than the power functions explored in class, so I decided to build a package based on some statistical techniques I learnt in a Machine Learning course at UBC (I highly recommend taking CPSC 340 and/or 540 if you're into that sort of thing). 

This package concerns itself with modelling data with functions. The usual way to do this is with regression ("least squares", as with `lm`), however in some scenarios this results in [overfitting](https://en.wikipedia.org/wiki/Overfitting).

Regularization is a strategy that forces our model to be "simpler" by punishing complexity. It does this by minimizing the so-called "regularized error", which in my case is

$$\sum_{i=1}^n \left(y_i-\left(\sum_{j=0}^d a_jx_i^j\right)\right)^2+\lambda\sum_{j=0}^da_j^2
$$

The first term is just your normal least squares, while the second term is a punishment for making the coefficients in your function too large (high coefficients being analogous to a complicated function). The $\lambda$ in this equation is a weight for how much we want to punish complexity, and is free to be chosen in my modelling function `reg.lm()`. One method of finding a good $\lambda$ is called 'cross-validation', in which one tests different values of $\lambda$ by fitting models on subsets of the data and seeing how well this model predicts data beyond this subset. The best $\lambda$ is the one that has the smallest error when predicting other data. This is what the `crossval()` function does (when you input your data, the number of partitions to divide your data into, the degree of your polynomial, and the $\lambda$ values you want to test).

This is discussed more in the vignette and README.

[Here is a link to my package.](https://github.com/arsbar24/RegularizedFits)


**Next steps:** This package is of course very basic. Many improvements could be made. Among them:

* Using other regularizers than the square of coefficients (the sum of absolute values is in many cases advantageous if more complex).

* Right now my functions only take in models of one variable, but it would be simple to modify the function to make it work for multi-variable models.


## Reflections

I found this assignment more tedious. I think this is because I enjoy working with real data and miss that, but I understand the importance of doing this and am happy with what I have built and that I learnt how to do it.

* Ran into some problems with `expect_identical()` until I found `expect_equal()`. I think this was because the format output by `lm()` is not the same as the format output by my `reg.lm()`.

* I had to learn how to write matrix operations in R for this assignment. Found [this handy site for that](https://www.statmethods.net/advstats/matrix.html).

* Learnt how to draw curves of functions on ggplots using `stat_function()` from [stackoverflow](https://stackoverflow.com/questions/28969760/r-add-a-curve-with-my-own-equation-to-an-x-y-scatterplot).

* I didn't really know how the README and vignette should differ, so I put similar stuff in both of them. If you have any ideas for how I could've organized them better I would like to hear them.
