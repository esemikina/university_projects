## HW 12
## Yelizaveta Semikina



# Question 1
load("/Users/liza/Desktop/STAT382/Classroom_Workspace.RData")



# Question 2
summary(classroom$location)
# result
Front Middle   Back 
41     48     39 



# Question 3
I have three  groups: Front = 41, Middle = 48,  Back = 39. All of the sample sizes are “large” (> 30) and the total is 128,
thus, I should perfom  the checks by group. 



# Question 4
class2 <- cbind(classroom)

class2front <- class2$residual[class2$location == "Front"]
class2mid <- class2$residual[class2$location == "Middle"]
class2back <- class2$residual[class2$location == "Back"]



# Question 4.a
par(mfrow = c(2,2))
hist(class2front, right = FALSE, main = "Residual Histogram")
hist(class2mid, right = FALSE, main = "Residual Histogram")
hist(class2back, right = FALSE, main = "Residual Histogram")
par(mfrow = c(1,1))
hist(classroom$residuals, right = FALSE, main = "Residual Histogram", xlab = "Residual")

# summary
Histogram for front is looks bell shaped but it is not perfect. Histogram for middle location looks
skewed to the left and histogram for back location could be bell shaped but there are many uneven
parts. Overall hist looks pretty bell shaped, thus there is normality. 


# Question 4.b
## Front 
qqnorm(class2front, main = "QQ Plot for Front Location")
qqline(class2front)
# summary
there are some dots in the begining, middle and ending that are not close enough to a line, 
thus it migh not be normal. 

## Middle
qqnorm(class2mid, main = "QQ Plot for Middle Location")
qqline(class2mid)
# summary
there are some dots in the begining and ending that are not close enough to a line, thus, 
it migh not be normal.

## Back
qqnorm(class2back, main = "QQ Plot for Back Location")
qqline(class2back)
# summary
there are some dots in the ending that are not close enough to a line, thus it migh not be normal.

## Overall
qqnorm(lm.classroom$residuals)
qqline(lm.classroom$residuals)
# summary
dots are pretty close to the line, thus it is normal. 



# Question 4.c
## Front
shapiro.test(class2front)
# result
Shapiro-Wilk normality test

data:  class2front
W = 0.98029, p-value = 0.6865

## Middle
shapiro.test(class2mid)
# result
Shapiro-Wilk normality test

data:  class2mid
W = 0.9881, p-value = 0.9039

## Back
shapiro.test(class2back)
# result
Shapiro-Wilk normality test

data:  class2back
W = 0.98782, p-value = 0.9426
# Overall
shapiro.test(lm.classroom$residuals)

Shapiro-Wilk normality test

data:  lm.classroom$residuals
W = 0.99484, p-value = 0.9265

## Conclusion
Based on Shapiro-Wilk normality test, at 0.02 significance level, we can say do not reject H0, 
there is an evidence that all of the residuals are normal. Thus, we can say that normality is met.



# Question 5.a
plot(lm.classroom$fitted.values, lm.classroom$residuals, xlab = "Predicted Deflection Values", ylab = "Residual", main = "Overall Residual Plot")
abline(h = 0, lty = 2)



# Question 5.b
boxplot(class2$residual~class2$location, xlab = "Location", ylab = "Residual", main = "Distribution of Residual by Group")
abline(h = 0, lty = 2)



# Question 5.c.i
H0: QF^2 = QM^2 = QB^2
H1: not all variences are the same



# Question 5.c.ii
bartlett.test(classroom$scores~classroom$location)
# result
Bartlett test of homogeneity of variances

data:  classroom$scores by classroom$location
Bartletts K-squared = 6.3962, df = 2, p-value = 0.04084



# Question 5.c.iii
p-value is 0.04084



# Question 5.c.iv
since the  p-value(0.04084) is larger than significnace value(0.02) we do not reject H0.



# Question 5.c.v
There is evidence for equal variences. 



# Question 6
summary(lm.classroom)
# result
Call:
  lm(formula = classroom$scores ~ classroom$location)

Residuals:
  Min       1Q   Median       3Q      Max 
-24.8718  -6.9282   0.0153   6.9589  29.6875 

Coefficients:
                            Estimate Std. Error t value Pr(>|t|)    
  (Intercept)                78.098      1.617  48.309  < 2e-16 ***
  classroom$locationMiddle   -5.785      2.201  -2.628  0.00967 ** 
  classroom$locationBack    -12.226      2.315  -5.280 5.53e-07 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 10.35 on 125 degrees of freedom
Multiple R-squared:  0.1824,	Adjusted R-squared:  0.1693 
F-statistic: 13.94 on 2 and 125 DF,  p-value: 3.415e-06



# Question 7
There is a difference between means at 0.02 significance level. If we take a look at p-values of
the seat location we notice that Front(2e-16), Mid(0.00967) and Back(5.53e-07) p-values are all
pretty small compare to 0.02. Reject H0. There is a difference between front, mid and back locations. 



# Question 8
pairwise.t.test(x = classroom$scores, g = classroom$location, p.adj = "bonferroni")
# result
Pairwise comparisons using t tests with pooled SD 

data:  classroom$scores and classroom$location 

       Front   Middle
Middle 0.029   -     
Back   1.7e-06 0.014 

P value adjustment method: bonferroni

# summary
Front + Middle: p-value is 0.029
Front + Back: p-value is 1.7e-06
Back + Middle: p-value is 0.014

For the Front + Middle the p-value is bigger than 0.02, thus, do not reject H0.
For Front + Back p-value is smaller than 0.02, thus, reject H0.
For Back + Middle p-value is smaller than 0.02, thus, reject H0.
There is significant difference in Front + Back and Back + Middle but in Front + Middle there is 
no significance difference.



# Question 9
lm.aov <- aov(classroom$scores~classroom$location)
tukey <- TukeyHSD(lm.aov, conf.level = 0.98)
tukey
# result
Tukey multiple comparisons of means
98% family-wise confidence level

Fit: aov(formula = classroom$scores ~ classroom$location)

$`classroom$location`
                   diff       lwr        upr     p adj
Middle-Front  -5.785061 -11.78276  0.2126410 0.0259849
Back-Front   -12.225766 -18.53422 -5.9173085 0.0000017
Back-Middle   -6.440705 -12.52078 -0.3606274 0.0126813


-11.78 < µMiddle − µFront < 0.21
−18.53 < µBack − µFront < -5.92
−12.52 < µBack − µMiddle < -0.36


Reject H0 for Back-Front and Back-Middle because the p-values are less than 0.02 and zero is not on
the intervals. For Middle-Front do not reject H0 because the p-value is bigger than 0.02 and 
there is zero on the interval. Thus, Back-Front and Back-Middle difference is significance and
for Middle-Front it is not significant. 






