## HW 11
## Yelizaveta Semikina



# Question 1
mydata <- read.csv("/Users/liza/Desktop/STAT382/calories.csv")
mydata$Restaurant <- factor(mydata$Restaurant)


# Question 2
avrg <- tapply(mydata$Calories, mydata$Restaurant, mean, na.rm=TRUE)
# result 
avrg
   Chilis  Red Robin TGIFridays 
1113.0233   936.9692   984.8936 

# graph
barplot(avrg, ylim = c(0, 1200), xlab = "Names of the Restaurants", ylab = "Calories", main = "Calories vs Restaurants")

# summary
there might be a small difference in means, We can say that Red Robin and TGIFridays has very very small difference, 
compare these two to Chills, there a little bigeer difference. 



# Question 3
lm.saved <- lm(mydata$Calories ~ mydata$Restaurant)
# result 
Call:
  lm(formula = mydata$Calories ~ mydata$Restaurant)

Coefficients:
  (Intercept)   mydata$RestaurantRed Robin  mydata$RestaurantTGIFridays  
1113.0                       -176.1                       -128.1  

lm.saved$coefficients
# result
(Intercept)  mydata$RestaurantRed Robin mydata$RestaurantTGIFridays 
1113.0233                   -176.0540                   -128.1296 



# Question 4.a
H0: All means are the same.
H1: At least one mean is different.



# Question 4.b
lm.anova <- anova(lm.saved)
lm.anova
# result
Analysis of Variance Table

Response: mydata$Calories
                    Df   Sum Sq Mean Sq F value  Pr(>F)  
mydata$Restaurant   2   818237  409119   3.259 0.04113 *
  Residuals         152 19081149  125534                  
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1



# Question 4.c
We use F test statistics based on table, the f value is 3.259.



# Question 4.d
The p-value is 0.04113. 



# Question 4.e
Reject H0 because p-value is smaller than significnace levle of 0.05. 



# Question 4.f
There is enough evidence that at least one mean is different. 



# Question 5 
summary(lm.saved)
# result 
Call:
  lm(formula = mydata$Calories ~ mydata$Restaurant)

Residuals:
  Min      1Q  Median      3Q     Max 
-773.02 -226.97  -23.02  270.00 1055.11 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
  (Intercept)                  1113.02      54.03  20.600   <2e-16 ***
  mydata$RestaurantRed Robin   -176.05      69.65  -2.528   0.0125 *  
  mydata$RestaurantTGIFridays  -128.13      74.77  -1.714   0.0886 .  
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 354.3 on 152 degrees of freedom
Multiple R-squared:  0.04112,	Adjusted R-squared:  0.0285 
F-statistic: 3.259 on 2 and 152 DF,  p-value: 0.04113



# Question 6
Red Robin estimates the difference between Red Robin and Intercept(Chilis). The p value is 0.0125, which is small, 
thi smeans there is an evidence of a difference between Red Robin and Chilis.














