
lingStuff
=========

This is a collection of functions that I often use 
in my research. Some are borrowed and edited, others 
are my own. Feel free to fork and edit as you see fit. 

## To add

- contrast coef calculation

## Examples

### D' (d prime)


```r
library(lingStuff); library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
# Create some data
set.seed(1)
axb <- data.frame(subj = sort(rep(1:10, each = 20, times = 10)),
                  group = gl(2, 1000, labels = c("g1", "g2")),
                  hit = c(rbinom(1000, size = c(0, 1), prob = .8), 
                          rbinom(1000, size = c(0, 1), prob = .6)),
                  fa =  c(rbinom(1000, size = c(0, 1), prob = .3), 
                          rbinom(1000, size = c(0, 1), prob = .4))
    )

# Calculate d prime for each subject
# by group, plot it, and run a 
# linear model
axb %>%
  group_by(subj, group) %>%
  summarize(hRate = mean(hit), 
            faRate = mean(fa), 
            dp = dPrime(hRate, faRate)) %T>%
  {
    plot(dp ~ as.numeric(group), data = ., 
    main = "d' as a function of group", xaxt = "n", 
    xlab = "Group", ylab = "d' prime")
    axis(1, at = 1:2, labels = c("g1", "g2"))
    abline(lm(dp ~ as.numeric(group), data = .), col = "red")
  } %>%
  lm(dp ~ group, data = .) %>%
  summary()
```

![](README_files/figure-html/unnamed-chunk-1-1.png) 

```
## 
## Call:
## lm(formula = dp ~ group, data = .)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.18782 -0.03260  0.01253  0.04389  0.13662 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  0.81851    0.04063  20.145 3.85e-08 ***
## groupg2     -0.51986    0.05746  -9.047 1.78e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.09085 on 8 degrees of freedom
## Multiple R-squared:  0.911,	Adjusted R-squared:  0.8998 
## F-statistic: 81.85 on 1 and 8 DF,  p-value: 1.783e-05
```
