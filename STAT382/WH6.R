## WH 6
## Yelizaveta Semikina

setwd("/Users/liza/Desktop/STAT382")
mydata <- read.csv("squirrelcolor_v3.csv")

# Question 1.a

tab <- table(mydata$color)
tab
# result
Black Cinnamon     Gray 
59      114      729



# Question 1.b
prop.test(729, 902, 0.8, alternative = "two.sided", correct = TRUE)
# result
1-sample proportions test with continuity correction

data:  729 out of 902, null probability 0.8
X-squared = 0.32989, df = 1, p-value = 0.5657
alternative hypothesis: true p is not equal to 0.8
95 percent confidence interval:
  0.7806446 0.8330932
sample estimates:
  p 
0.808204


p-value 0.5657 is bigger than significance level 0.02, thus, we fail to reject the null hypothesis.
902*0.8 = 721.6 and 902(1-0.8) = 180.4. Thus, 721.6 >= 5 and 180.4 >= 5. Finally, we can say that normal 
approximation is appripriate for this dataset. 


# Question 1.c.i
prop.test(729, 902, conf.level = 0.98, correct=FALSE)
# result 
1-sample proportions test without continuity correction

data:  729 out of 902, null probability 0.5
X-squared = 342.72, df = 1, p-value < 2.2e-16
alternative hypothesis: true p is not equal to 0.5
98 percent confidence interval:
  0.7759048 0.8368269
sample estimates:
  p 
0.808204 



#  Question 1.c.ii
We are 98% confident that the grey squirrels sample is between 0.7759048 and 0.8368269.


# Question 1.c.iii
[0.7759048, 0.8368269]



# Question 1.c.iiii
It is would be different from 0.85 because 0.85 would not be in the interval [0.7759048, 0.8368269], it is bigger 
than 0.8368269. 



# Question 2.a
H0 : pgenZ − pMillennials = 0 
H1 : pgenZ − pMillennials > 0



# Question 2.b
prop.test(c(655, 677), c(750, 800), alternative = "greater", correct = FALSE)
# result 
2-sample test for equality of proportions without continuity correction
data:  c(655, 677) out of c(750, 800)
X-squared = 2.3492, df = 1, p-value = 0.06267
alternative hypothesis: greater
95 percent confidence interval:
  -0.001883607  1.000000000
sample estimates:
  prop 1    prop 2 
0.8733333 0.8462500



# Question 2.c
p-value = 0.06267, and our significance level is 0.07. Thus, p value is less than significance level. 
Reject H0.



# Question 2.d
there is not enough evidence that the population proportion of Gen Z that plan to celebrate Halloween 
this year is greater than the population proportion of Millennials that plan to celebrate Halloween this year.



# Question 3.a
mydata1 <- read.csv("ecancer.csv")
mydata1$agegp <- factor(mydata1$agegp, order = TRUE, levels = c("25-34", "35-44", "45-54", "55-64", "65-74", "75+"))



# Question 3.b
H0 : p1 = p2 = p3 = p4 = p5 = p6
H1: at least one proportion pi is different from the others(ncases is increasing)



# Question 3.c
successes <- tapply(mydata1$ncases, mydata1$agegp, summary)
successes
# result
25-34 35-44 45-54 55-64 65-74   75+ 
  1     9    46    76    55    13

# Question 3.d
totals <- tapply(tot, mydata1$agegp, sum)
totals
# result 
25-34 35-44 45-54 55-64 65-74   75+ 
  116   199   213   242   161    44 



# Question 3.e
prop.test(successes, totals, correct = FALSE)
# result
6-sample test for equality of proportions without continuity correction

data:  successes out of totals
X-squared = 97.036, df = 5, p-value < 2.2e-16
alternative hypothesis: two.sided
sample estimates:
  prop 1     prop 2     prop 3     prop 4     prop 5     prop 6 
0.00862069 0.04522613 0.21596244 0.31404959 0.34161491 0.29545455 



# Question 3.f
p value is 2.2e-16 is less than significance level of 0.04. Thus, Reeject H0.



# Question 3.g
There is enough evidence that the  people with esophageal cancer in each age group the same as age group
increases. 



# Question 4.a
H0: there is no linear trend in the proportion as age increases
H1: there is a linear trend in the proportion as age increases



# Question 4.b
prop.trend.test(successes, totals)
# result 
Chi-squared Test for Trend in Proportions

data:  successes out of totals ,
using scores: 1 2 3 4 5 6
X-squared = 83.452, df = 1, p-value < 2.2e-16



# Question 4.c
The  p-value 2.2e-16 is less than 0.04, thus, reject H0. 



# Question 4.d
There i senough evidence that there is a trend in the proportions as age increases.















