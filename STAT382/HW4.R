## HW 4
## Yelizaveta Semikina


## Task 1

# Question 1
mean(mydata$hp)
#result
71.95294

length(sample(mydata$hp))
#result
85

# Question 2 
qnorm(0.96)
#result 
1.750686

# Question 3
from 67.3 to 76.61 or 71.95 ± 4.654

# Question 4
[67.3, 76.61]

# Question 5


# Question 6
# I would increase the confidence level, because the bigger confidence level, the wider the confidence interval. 


## Task 2
# Question 7
Ho: p = 0.07
H1: p > 0.07 
one-sided test

# Question 8
t.test(mydata1$Pulse1, mydata1$Pulse2, mu = 47, paired = FALSE, var.equal = FALSE, alternative = "greater", conf.level = 0.93)
#result
Welch Two Sample t-test

data:  mydata1$Pulse1 and mydata1$Pulse2
t = -22.618, df = 74.692, p-value = 1
alternative hypothesis: true difference in means is greater than 47
93 percent confidence interval:
  -57.88034       Inf
sample estimates:
  mean of x mean of y 
75.45652 126.84783 



## Task 3
# Question 9
Ho:μ = 80
H1:μ < 80


# Question 10
t.test(mydata2$exit_velocity, alternative = "less", conf.level = 0.955)

#result:

One Sample t-test

data:  mydata2$exit_velocity
t = 39.847, df = 45, p-value = 1
alternative hypothesis: true mean is less than 0
95.5 percent confidence interval:
  -Inf 79.87415
sample estimates:
  mean of x 
76.54565 



# Question 11
[72.695, 80.397]

# Question 12
We are 95.5%  confident that the mean exit velocity is between [72.695, 80.397]. 

# Question 13
For significance level that is less or equal to 8% because when it is less or equal, the confidence intevral will be between [73.183, 79.909] and it means that μ which is 80 would nor be inside the CI. 

# Question 14
For significance level that is equal to 7.25% because it means that μ which is 80 would not be inside the CI. 

# Question 15
We can not conclude that there is enough evidence for significance levels that are bigger than 8% because the μ which is 80 would be inside Confidence Interval. 



## Task 4
# Question 16.a
H0: u1 = u2
Ha: u1 != u2

# Question 16.b
nv <- mydata3[mydata3$group == "NV", ]
vv <- mydata3[mydata3$group == "VV", ]

t.test(nv$fusion.time, vv$fusion.time, var.equal = TRUE, alternative = "two.sided", mu = 0, conf.level = 0.97)
#result
Two Sample t-test

data:  nv$fusion.time and vv$fusion.time
t = 1.9395, df = 76, p-value = 0.05615
alternative hypothesis: true difference in means is not equal to 0
97 percent confidence interval:
  -0.4221391  6.4402107
sample estimates:
  mean of x mean of y 
8.560465  5.551429


# Question 16.c
Do not reject Ho at the significance level of 0.03.


# Question 16.d
since the p-value is bigger than significance level, there is enough evidence to not reject the null hypothesis.


# Question 17.a
Ho: u1 = u2
Ha: u1 != u2


# Question 17.b 

t.test(nv$fusion.time, vv$fusion.time, paired = FALSE, var.equal = FALSE, mu = 0, conf.level = 0.97)

#result 
Welch Two Sample t-test

data:  nv$fusion.time and vv$fusion.time
t = 2.0384, df = 70.039, p-value = 0.04529
alternative hypothesis: true difference in means is not equal to 0
97 percent confidence interval:
  -0.2609816  6.2790532
sample estimates:
  mean of x mean of y 
8.560465  5.551429 



# Question 17.c
Do not reject Ho at the significance level of 0.03.




# Question 17.d
since the p-value is bigger than significance level, there is enough evidence to not reject the null hypothesis.


















