
lingStuff
=========

This is a collection of functions and datasets that I 
often use, both in research and teaching. Feel free to 
fork and edit as you see fit. 

## Installation

In order to install this package you must have `devtools`. Don't know if you 
have `devtools`? Copy and paste this into your console:


```r
if (!require('devtools')) {
  stop('The package foo was not installed')
}
```

R will load `devtools` if you have it, otherwise it will give you an error, in which case you should copy and paste the following code into the console:


```r
install.packages("devtools")
library(devtools)
install_github("jvcasill/lingStuff")
```

In the case that you already have `devtools`, then just copy and paste lines 2 
and 3 of the above code chunk. 

## To add

- contrast coef calculation

## Examples

### crossOver


```r
# Generate data
set.seed(1)
vot = rnorm(20, 15, 5)
vot = sort(vot)
phon1 = c(0,1,0,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,1,1)
group1 = rep('g1', 20)
df1 = data.frame(vot = vot, phon = phon1, group = group1)
phon2 = c(1,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1,1,1)
group2 = rep('g2', 20)
df2 = data.frame(vot = vot, phon = phon2, group = group2)
df <- rbind(df1, df2)


# Fit models
glm1 <- glm(phon ~ vot, data = df, family = "binomial")
glm2 <- glm(phon ~ vot * group, data = df, family = "binomial")

# Get crossover points
cross_over(mod = glm1, cont_pred = 'vot')
cross_over(mod = glm2, cont_pred = 'vot')
cross_over(mod = glm2, cont_pred = 'vot', grouping_var = TRUE, 
           int_adj = 'groupg2', slope_adj = 'vot:groupg2')
```

```r
## [1] 16.20771
## [1] 15.53595
## [1] 17.10169
```

```r
# Plot regression with crossover point
ggplot(df, aes(x = vot, y = phon, color = group)) + 
  geom_smooth(method = 'glm', method.args = list(family = 'binomial'), se = F) + 
  geom_vline(xintercept = cross_over(mod = glm2, cont_pred = 'vot')) +
  geom_vline(xintercept = cross_over(mod = glm2, cont_pred = 'vot', 
                                     grouping_var = T, int_adj = 'groupg2', 
                                     slope_adj = 'vot:groupg2'))
```

![](README_files/figure-html/cross_over-1.png) 
