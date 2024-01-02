## Homework 3
## Yelizaveta Semikina

## Question 1
exponential_mean <- function(seed, sample_size1, sample_size2, rate){
  sample_size1 <- sample_size1
  sample_means1 <- 0
  set.seed(seed)
  for(i in 1:500){sample_means1[i] <- mean(rexp(n = sample_size1), rate = rate)}
  sample_size2 <- sample_size2
  sample_means2 <- 0
  set.seed(seed)
  for(i in 1:500){sample_means2[i] <- mean(rexp(n = sample_size2), rate = rate)}
  result <<- data.frame(sample_means1, sample_means2)
}



## Question 2
exponential_mean(22, 9, 500, 1.4)



## Question 3
# a
hist(result$sample_means1, right = FALSE, main = paste("Sample Size", 9), xlab = "Sample_Means1")
# Distribution is not normal because the histogram is skewed to the left and the normal distribution has bell shaped histogram.

#b
qqnorm(result$sample_means1, main = "Sample Size 9")
qqline(result$sample_means1)
# It is mostly normal because based on teh graph most of the dots are close to line, thus, it is normal. 

#c
shapiro.test(result$sample_means1)
#result
Shapiro-Wilk normality test
data:  result$sample_means1
W = 0.96509, p-value = 1.594e-09
#The test is not normal because the p value is too small 



## Question 4
# a
hist(result$sample_means2, right = FALSE, main = paste("Sample Size", 500), xlab = "Sample_Means2")
# The distribution is normal because the histogram is bell shaped. 


# b 
qqnorm(result$sample_means2, main = "Sample Size 500")
qqline(result$sample_means2)
# Compare to previous QQ-Plot, this is one is even more normal, thus i can say it is normal because of how almost all dots are on the line.


#c
shapiro.test(result$sample_means2)
#result
Shapiro-Wilk normality test
data:  result$sample_means2
W = 0.99809, p-value = 0.8568
# It is closer to normal because the p-value is 0.05 and the our value is 0.8568.

## 5
CLT states that the bigger sample size, the more distribution of sample means approximates a normal distribution.
We can that after doing test and graphs for the sample size 500, the result of the histogram, plot and Shapiro-Wilk test are normal compare to sample size 9. 







