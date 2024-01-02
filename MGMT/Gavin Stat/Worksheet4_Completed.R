## Worksheet 4 Template
## Name: Gavin Frias




#### TASK 1 - HYPOTHESIS TEST FOR PAIRED DATA

data1 <- read.csv("Exercise Heart Rate.csv", header = TRUE)

## Question 1 - State Hypotheses
	# H0:????D = 48
	# H1:????D > 48




## Question 2 - Conduct the Test
## Make sure to also copy and paste results from your code
	# R Code
t.test(data1$Pulse2, data1$Pulse1, paired = TRUE, mu = 48, alternative = "greater", conf.level = 0.93)

	# Results
# Paired t-test

# data:  data1$Pulse2 and data1$Pulse1
# t = 1.0906, df = 45, p-value = 0.1406
# alternative hypothesis: true difference in means is greater than 48
# 93 percent confidence interval:
#   46.71982      Inf
# sample estimates:
#   mean of the differences 
# 51.3913 

	
	
	
## Question 3 - State the p-value
		# p-value = 0.1406
	
	
	
## Question 4 - Decision at alpha = 0.07
# Do Not Reject
	
	
## Question 5 - Conclusion
# There is not enough evidence that there is a difference in the students heart rate before and after running.
	
	
## Question 6 - Confidence Interval
	# a) Is the confidence interval two-sided or one-sided?
    # The confidence interval is one-sided.
	
	# b) Provide your interval.
    # [4671982,Inf]
	
	# c) Can you conclude that running increases the mean heart rate by more than 48 beats per minute?  Why or why not?
    # We cannot conclude that running increases the mean heart rate by more than 48 beats per minute becuse mu = 48 is inside our confidence interval.
	
	
	
	
	
	
	
	
	
	
#### TASK 2 - HYPOTHESIS TEST FOR ONE PROPORTION

## Question 7 - State hypotheses
	# H0: p = 0.82
	# H1: p ??? 0.82
	
	
	
	
## Question 8 - Conduct the Test
## Make sure to also copy and paste results from your code
	# R Code
prop.test(x = 829 ,n = 902, p = 0.82, alternative = "two.sided", correct =  FALSE)

	
	
	# Results
# 1-sample proportions test without continuity
# correction

# data:  829 out of 902, null probability 0.82
# X-squared = 59.978, df = 1, p-value = 9.591e-15
# alternative hypothesis: true p is not equal to 0.82
# 95 percent confidence interval:
#  0.8994424 0.9351407
# sample estimates:
#   p 
# 0.9190687 
	


	
## Question 9 - State the p-value
	# p-value = 9.591e-15
	
	
	
## Question 10 - Decision at alpha = 0.03
  # Reject
	
	
## Question 11 - Conclusion
# There is enough evidence that the proportion of squirrels that are gray is different than 0.82.
	
	
## Question 12 - Compute a Confidence Interval
	# a) Is the confidence interval two-sided or one-sided?
    # Two-sided.
	 
	# b) Provide your interval.
    # [0.8994424,0.9351407]
	
	# c) Can you conclude that the proportions of squirrels that are gray is different than 0.82?  Why or why not?
    # We can conclude that the proportion of squirrels that are gray is different than 0.82 because 0.82 is not inside the confidence interval.

