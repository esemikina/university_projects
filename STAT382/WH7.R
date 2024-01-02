## WH 7
## Yelizaveta Semikina

# Question 1.a
H0: the variables are independent (Node_caps and Deg_malig are independent)
H1: the variables are not independent (Node_caps and Deg_malig are dependent)



# Question 1.b
table1 <- table(mydata$Node_caps, mydata$Deg_malig)
# result
      1   2   3
yes   0  26  30
no   66 103  52

chisq.test(table1)
# result 
# Pearson's Chi-squared test

data:  table1
X-squared = 30.346, df = 2, p-value = 2.573e-07



# Question 1.c
p-value is -0.00586, it is less than significance levle of 0.01.
Reject H0.



# Question 1.d
There is an evidence that node capsules and the degree of malignancy are not independent. 



# Question 2.a
people <- matrix(data = c(12, 4, 6, 9), nrow = 2, ncol = 2, byrow = TRUE)
rownames(people) <- c("Drug A", "Drug B")
colnames(people) <- c("Improved", "Stayed the same or did not improve")
people
# result
       Improved Stayed the same or did not improve
Drug A       12                                  4
Drug B        6                                  9



# Question 2.b
fisher.test(people, alternative = "two.sided", or = 1)
# result
# Fisher's Exact Test for Count Data

data:  people
p-value = 0.07317
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
  0.7846563 27.9487259
sample estimates:
odds ratio 
  4.268185 

  
  
# Question 2.c
p- value is 0.07317, it is bigger than significance level. 
Do not reject H0.



# Question 2.d 
There is not enough evidence they are not independent. 









