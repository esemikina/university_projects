## HW 8
## Yelizaveta Semikina

mydata <- read.csv("/Users/liza/Desktop/STAT382/penguindives.csv")

# Question 1
plot(x = mydata$Heart_Rate, y = mydata$Duration, xlab = "Heart Rate", ylab = "Duration", main = "Scatterplot of Duration against Heart Rate")



# Question 2
lm.mydata <- lm(mydata$Duration ~ mydata$Heart_Rate)



# Question 3
lm(formula = mydata$Duration ~ mydata$Heart_Rate)
# result
Call:
  lm(formula = mydata$Duration ~ mydata$Heart_Rate)

Coefficients:
  (Intercept)  mydata$Heart_Rate  
16.1980            -0.1626 



# Question 4.a
H0: B1 = 0
H1: B1 != 0



# Question 4.b
summary(lm.mydata)
# result
Call:
  lm(formula = mydata$Duration ~ mydata$Heart_Rate)

Residuals:
    Min      1Q  Median      3Q     Max 
-4.0384 -1.4531 -0.2779  1.5982  4.4167 

Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)       16.19805    1.07143  15.118 3.99e-16 ***
mydata$Heart_Rate -0.16264    0.01826  -8.908 3.55e-10 ***
  ---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.176 on 32 degrees of freedom
Multiple R-squared:  0.7126,	Adjusted R-squared:  0.7036 
F-statistic: 79.35 on 1 and 32 DF,  p-value: 3.55e-10



# Question 4.c 
Test statistics for Heart Rate is-8.908 and for Duration is 15.118. I used t test. 



# Question 4.d
p-value is -0.35009.



# Question 4.e
Significance levels is 0.04, p-value is less than 0.04, thus, reject H0.



# Question 4.f
There is a linear relationship between heart rate and duration. 



# Question 5
Multiple R-squared:  0.7126.
Since the value of R^2 is 0.7126, it means that it is l partially predicts the outcome. The value is close
to model preditions. More points are located close to the line. 

























