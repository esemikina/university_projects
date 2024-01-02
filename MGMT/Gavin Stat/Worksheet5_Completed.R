## Worksheet 5
## Name: Gavin Frias





########################################
## Task 1: Simple Linear Regression  ###
########################################

# Import Data

penguindives <- read.csv("penguindives.csv")


# Question 1 - Create a scatterplot with Heart_Rate on the horizontal axis and Duration on the vertical axis.
# Make sure to export the graph and submit it to Gradescope

plot(x = penguindives$Heart_Rate, y = penguindives$Duration, xlab = "Heart Rate", ylab = "Duration", main = "Scatterplot of Duration against Heart Rate")	
abline(lm(penguindives$Duration ~ penguindives$Heart_Rate))
	



	
	
# Question 2 - Compute Person's correlation coefficient, r.
		# Code: 
cor(penguindives, use = "complete.obs")

#             Heart_Rate   Duration
# Heart_Rate  1.0000000 -0.8441596
# Duration   -0.8441596  1.0000000


		# Value:-0.8441596


		
		

# Question 3 - Based on your scatterplot and the value for r, describe the linear association between the two variables.
		
		# There is evidence of a linear association between heart rate and duration.
		
		
		
		
		
		
# Question 4 - Create the simple linear regression model for Duration with Heart_Rate as the predictor.
		
lm.heartrate <- lm(penguindives$Duration ~ penguindives$Heart_Rate)


		
		
		
# Question 5a - Test Linearity
# Make sure to export any graphs and submit them to Gradescope

	# Code
plot(x = penguindives$Heart_Rate, y = lm.heartrate$residuals)
abline(h = 0)

	# Is the linearity condition met?
	# Yes, because there are no apparent patterns on the accompanying graph


		
		
		
		
# Question 5b - Test Normality
# Make sure to export any graphs and submit them to Gradescope
# If you run code that produces results, make sure to copy and paste the result in your R Script.

	# Code
shapiro.test(lm.heartrate$residuals)

# Shapiro-Wilk normality test

#data: lm.heartrate$residuals 
#W = 0.97681, p-value = 0.67

	# Is the normality assumption met?
#Yes, p = 0.67. Do not reject H0		
		

		
		
# Question 5c - Test Equal Variance
# Make sure to export any graphs and submit them to Gradescope

	# Code
plot(x = lm.heartrate$fitted.values, y = lm.heartrate$residuals)
abline(h = 0, lty = 2)

	# Is the equal variance assumption met?
#Yes, because there are no apparent patterns on the accompanying graph

	
	
	
	
	
# Question 6 - Test whether Heart_Rate is important in explaining variation in Duration at a 7% significance level.
	
	# a) State hypotheses
		# H0: Beta = 0
		# H1: Beta != 0 
	

	
	# b) Conduct the Test and report the results as a comment.
		# Code
summary(lm.heartrate)



		# Copy and paste results here
#Call:
#  lm(formula = penguindives$Duration ~ penguindives$Heart_Rate)

#Residuals:
#  Min      1Q  Median      3Q     Max 
#-4.0384 -1.4531 -0.2779  1.5982  4.4167 

#Coefficients:
#                         Estimate Std. Error t value Pr(>|t|)    
#(Intercept)             16.19805    1.07143  15.118 3.99e-16 ***
#  penguindives$Heart_Rate -0.16264    0.01826  -8.908 3.55e-10 ***
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 2.176 on 32 degrees of freedom
#Multiple R-squared:  0.7126,	Adjusted R-squared:  0.7036 
#F-statistic: 79.35 on 1 and 32 DF,  p-value: 3.55e-10



		# Test Statistic Value = -8.908

		# P-Value = 3.55e-10



	# c) State your decision.
#Reject H0
			
			
	# d) State your conclusion.
#There is evidence of a significant linear relationship between heart rate and duration.
			
			

			
# Question 7 - Give the value for multiple R^2 and explain what it tells you about the model.

		# Multiple R^2 = 0.7126

		# Interpretation: 71.26% of variance in duration is explained by heart rate.
			
			
			
			
			
			
			
			
			
			



			
			
########################################
## Task 2: 1-way ANOVA  ################
########################################
			
# Import Data

calories <- read.csv("calories.csv")
		
		
		
# Question 8 - Create side-by-side boxplots by Restaurant and note if there appear to be any differences by restaurant.
# Make sure to export any graphs and submit them to Gradescope

	# Code
boxplot(calories$Calories~calories$Restaurant, xlab = "Restaurant", ylab = "Calories")


			
	# Potential Differences:
#There are few outliers, with very little potential difference.
	
	
	
	
	
# Question 9 - Create a linear model for Calories with Restaurant as the predictor
lm.restaurant <- lm(calories$Calories ~ calories$Restaurant)
	
	
	
# Question 10 - Create a table to determine number of observations by Restaurant Type
	# Code
lm.anova <- anova(lm.restaurant)
lm.anova

	# Copy and paste results here
#Analysis of Variance Table

#Response: calories$Calories
#Df   Sum Sq Mean Sq F value  Pr(>F)  
#calories$Restaurant   2   818237  409119   3.259 0.04113 *
#  Residuals           152 19081149  125534                  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1



# Question 11a - Test Normality
# Make sure to export any graphs and submit them to Gradescope
# If you run code that produces results, make sure to copy and paste the result in your R Script.

	# Code
shapiro.test(lm.restaurant$residuals)

#Shapiro-Wilk normality test

#data:  lm.restaurant$residuals
#W = 0.98881, p-value = 0.2537


	# Is the normality assumption met?
	
#Yes, p = 0.2537. Do not reject H0
	

	
	
# Question 11b - Test Equal Variance

	# Code
plot(x = lm.restaurant$fitted.values, y = lm.restaurant$residuals)
abline(h = 0, lty = 2
       
	# Is the equal variance assumption met?
#Yes, because there are no apparent patterns on the accompanying graph.
	
	
	
	
# Question 12 - Test whether the effect of restaurant is significant.
	# a) State Hypotheses
		# H0: muChilis = muTGIFridays = muRedRobin
		# H1: At least one of the means is different.
	

	# b) Conduct the Test and report the results as a comment.

		# Code
lm.anova


		# Copy and paste results here
#Analysis of Variance Table

#Response: calories$Calories
#                     Df   Sum Sq Mean Sq F value  Pr(>F)  
#calories$Restaurant   2   818237  409119   3.259 0.04113 *
#  Residuals           152 19081149  125534                  
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


		# Test Statistic Value = 3.259

		# P-Value = 0.04113
	
	
	
	# c) State your decision.
#Reject H0



	# d) State your conclusion.
#There is evidence of a difference of means in restaurants.
	
	
	
	
# Question 13 - If the effect is significant, compute either Bonferroni P-values or Tukey SCIs.
	
	# Code
pairwise.t.test(x = calories$Calories, g = calories$Restaurant, p.adjust.method = "bonferroni")

	# Copy and paste results here
#Pairwise comparisons using t tests with pooled SD 

#data:  calories$Calories and calories$Restaurant 

#           Chilis Red Robin
#Red Robin  0.037  -        
#TGIFridays 0.266  1.000    

#P value adjustment method: bonferroni 

	# Which pairs show evidence of a significant difference?
#The pair of Red Robin and Chilis shows evidence of a significant difference, with a p-value of 0.037.



