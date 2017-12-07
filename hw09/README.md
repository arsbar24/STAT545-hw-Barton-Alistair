[Link to package](https://github.com/arsbar24/RegularizedFits)

## Summary of Assignment

I wanted to attempt to create functions that were a little more interesting than the power functions explored in class, so I decided to build a package based on some statistical techniques I learnt in a Machine Learning course at UBC (I highly recommend taking CPSC 340 and/or 540 if you're into that sort of thing). 

# Description of functions

This package concerns itself with modelling data with functions. The usual way to do this is with regression ("least squares", as with `lm`), however in some scenarios this results in [overfitting](https://en.wikipedia.org/wiki/Overfitting).

Regularization is a strategy that forces our model to be "simpler" by punishing complexity. My function that does this is called `reg.lm()` and takes as input two data columns, a degree of polynomial that you want to fit, and a parameter $\lambda$ for punishing convexity ([Link to function definition](https://github.com/arsbar24/RegularizedFits/blob/main/R/regfit.R)). How this regularization works is minimizing the so-called "regularized error", which in my case is

![equation](http://www.sciweavers.org/tex2img.php?eq=%5Csum_%7Bi%3D1%7D%5En%20%5Cleft%28y_i-%5Cleft%28%5Csum_%7Bj%3D0%7D%5Ed%20a_jx_i%5Ej%5Cright%29%5Cright%29%5E2%2B%5Clambda%5Csum_%7Bj%3D0%7D%5Eda_j%5E2&bc=White&fc=Black&im=png&fs=12&ff=arev&edit=0)


The first term is just your normal least squares, while the second term is a punishment for making the coefficients in your function too large (high coefficients being analogous to a complicated function). The $\lambda$ in this equation is a weight for how much we want to punish complexity, and is free to be chosen in my modelling function `reg.lm()`. One method of finding a good $\lambda$ is called 'cross-validation', in which one tests different values of $\lambda$ by fitting models on subsets of the data and seeing how well this model predicts data beyond this subset. The best $\lambda$ is the one that has the smallest error when predicting other data. This is what the `crossval()` function does (when you input your data, the number of partitions to divide your data into, the degree of your polynomial, and the $\lambda$ values you want to test)---[Link to function definition](https://github.com/arsbar24/RegularizedFits/blob/main/R/crossval.R).

This is discussed more in the vignette and README.

# Tests

**`reg.lm()`:** [Link to tests](https://github.com/arsbar24/RegularizedFits/blob/main/tests/testthat/test_regfit.R). I tested three different things: 

1. It should return the same fit as `lm()` when the degree is one and $\lambda$ is zero.

2. It should differ from `lm()` when the degree is one and $\lambda$ is non-zero. (This is my expectation of failure)

3. The fit should have positive slope when data is positively correlated.

**`crossval()`:** [Link to tests](https://github.com/arsbar24/RegularizedFits/blob/main/tests/testthat/test_crossval.R). I tested four different things: 

1. It shouldn't matter what order you list the $\lambda$ values you want to try (this was a bug I encountered early on).

2. The error it outputs should match the error from `reg.lm()`.

3. The best $\lambda$ shouldn't be zero if the data is doesn't fit any feasible model. (This is my expectation of failure)

4. The best $\lambda$ should be zero if the data perfectly fits a feasible model.

[Here is a link to my package.](https://github.com/arsbar24/RegularizedFits)


**Next steps:** This package is of course very basic. Many improvements could be made. Among them:

* Using other regularizers than the square of coefficients (the sum of absolute values is in many cases advantageous if more complex).

* Right now my functions only take in models of one variable, but it would be simple to modify the function to make it work for multi-variable models.


## Reflections

I found this assignment more tedious. I think this is because I enjoy working with real data and miss that, but I understand the importance of doing this and am happy with what I have built and that I learnt how to do it. Here are some obstacles I faced along the way:

* I had to learn how to write matrix operations in R for this assignment. Found [this handy site for that](https://www.statmethods.net/advstats/matrix.html).

* Learnt how to draw curves of functions on ggplots using `stat_function()` from [stackoverflow](https://stackoverflow.com/questions/28969760/r-add-a-curve-with-my-own-equation-to-an-x-y-scatterplot).

* Initially I tried `expect_false()` on the vector of coefficient I obtained in one of my tests, but I was surprised this didn't work. I think this is because it only takes logical as arguments rather than logical vectors, but I find it a bit weird. 

* I didn't really know how the README and vignette should differ, so I put similar stuff in both of them. If you have any ideas for how I could've organized them better I would like to hear them.

* I learnt github doesn't support LaTeX in md files, thankfully I found [this tool](http://www.sciweavers.org/free-online-latex-equation-editor) for creating equation images that I can link to instead (from [this stackoverflow post](https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog/11256862#11256862))--although it doesn't fix inline math as you may have noticed :(
