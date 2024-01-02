## Worksheet 2 Template
## Name: Yelizaveta Semikina


## Question 1 - engineering firm
## Make sure to also copy and paste results from your code

# a) Rank top 4 candidates
factorial (12) / factorial (12 -4)
#result:
11880

# b) Choose 4 candidates from 12
choose(12,4)
#result:
495



## Question 2 - white-board markers (Binomial Distribution)
## Make sure to also copy and paste results from your code

# probability that fewer than 7 fail during lecture
pbinom(7, 35, 0.24)
#result:
0.3727882



## Question 3 - particles (Poisson / Exponential)
## Make sure to also copy and paste results from your code

# P(D > 0.6) - exponential distribution
pexp(0.6, 2.1, lower.tail = FALSE)
#result:
0.283654



## Question 4 - Find k. P(X > k) = 0.035
## Make sure to also copy and paste results from your code

# a) X~Standard Normal Distribution
qnorm(0.035, mean= 0, sd = 1, lower.tail = FALSE)
#result:
1.811911


# b) X~t(df = 15)
qt(0.035, df = 15, lower.tail = FALSE)
#result:
1.95094



## Question 5 - Random Samples identification
# Import and Explore Dataset (not graded)



# a) Histograms (make sure to export the graphs and submit them to Gradescope)
hist(mydata1$sample1, right = FALSE, xlim = c(0,25), main = "Sample Histogram", xlab = "Sample1")
hist(mydata1$sample2, right = FALSE, xlim = c(5,30), main = "Sample Histogram", xlab = "Sample2")


# b) Shapiro-Wilk Test of each column  (remember to copy and paste results)
shapiro.test(mydata1$sample1)
#results:
Shapiro-Wilk normality test

data:  mydata1$sample1
W = 0.97119, p-value = 0.1064



shapiro.test(mydata1$sample2)
#results:
Shapiro-Wilk normality test

data:  mydata1$sample2
W = 0.99122, p-value = 0.9095



# c) QQ Plot of each column (make sure to export the graphs and submit them to Gradescope)
# Sample1
qqnorm(mydata1$sample1, main = "Sample1")
qqline(mydata1$sample1)

# Sample 2
qqnorm(mydata1$sample2, main = "Sample2")
qqline(mydata1$sample2)

# d) Skewness of each column (remember to copy and paste results)
skewness(mydata1$sample1)
#result:
0.1623077


skewness(mydata1$sample2)
#result:
0.05629407

# e) Kurtosis of each column (remember to copy and paste results)
kurtosis(mydata1$sample1)
#result
-1.007512

kurtosis(mydata1$sample2)
#result
0.0871956


# f) Based on parts a-e, determine whether the column came from a normal
# distribution or not.

# Sample 1 analysis:
# a) The histogram of Sample 1 because it is Bimodal Shaped. Not Normal.
# b) In Sample the p-value is 0.1064 which is larger than 0.05, thus, it means that it is more likely to be normal. Not Normal.
# c) The QQ Plot for Sample 1 is not Normal because the dots are not close to line. 
# d) Skewness in 1st sample is 0.1623077, Could potentially come from a normal distribution. 
# e) Kurtosis for Sample 1 is too far from 3, it is -1.007512. This is not Normal. 
# Overall Conclusion:
# Overall, it does not appear to come from a normal distribution because all of the tests show that it not normally distributed. 

# Sample 2 analysis:
# a) The histogram of Sample 2 is Bell Shaped and that means it is normally distributed.Normal.
# b) The p-value is 0.9095 which is too large for normal distribution. Not Normal.
# c) The QQ Plot for Sample 2 is Normal because dots are close to line.
# d) For Sample 2, skewness is 0.05629407 which is more closer to 0, because the skewness for normal distribution is 0.
#  This is more likely to be normally distributed. 
# e) Kurtosis for Sample 2 is too far from 3, it is 0.0871956. This is not Normal. 
# Overall Conclusion:
# Overall, it is not definitively normal because Kurtosis and Shapiro-Wilk Tests were not normal and histogram, QQ Plot and skewness were normal. 




