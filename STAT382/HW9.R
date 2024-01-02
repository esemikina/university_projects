## HW 9
## Yelizaveta Semikina

# Question 1
mydata <- read.csv("/Users/liza/Desktop/STAT382/RealEstate_v2.csv")



# Question 2
lm.saved <- lm(mydata$Price ~ mydata$Sqft + mydata$Num_Bedrm + mydata$Pool)
# result
Call:
  lm(formula = mydata$Price ~ mydata$Sqft + mydata$Num_Bedrm + 
       mydata$Pool)

Coefficients:
  (Intercept)       mydata$Sqft  mydata$Num_Bedrm       mydata$Pool  
-66160.6             165.4           -8793.4            9145.7 



# Question 3
par(mfrow=c(1,3))
plot(x = mydata$Sqft, y = lm.saved$residuals)
abline(h = 0)
plot(x = mydata$Num_Bedrm, y = lm.saved$residuals)
abline(h = 0)
plot(x = mydata$Pool, y = lm.saved$residuals)
abline(h = 0)

The first plot(Sqft) has fanned pattern which means linearity assumptions is not met and the other two graphs, 
Nnumber of bedrooms and pool are okay. The second and third graphs are indicator variables. 



# Question 4
We do not need to check the independence assumption becaus linearity was not met. And since the firsr plot
has fanned pattern, we do not need to continue with that model. Also, it is not a time-series data. 



# Question 5
hist(lm.saved$residuals)
the histogram does look pretty bell shaped, this means it can be normal.

qqnorm(lm.saved$residuals)
qqline(lm.saved$residuals)

the plot does not look normal because in the begining and ending of line, the dots are not close to the
line.

shapiro.test(lm.saved$residuals)
# result
Shapiro-Wilk normality test

data:  lm.saved$residuals
W = 0.90982, p-value < 2.2e-16

the p value is 2.2e-16, it is pretty small compare to 0.05. Thus, reject H0.
There is enough evidence that normality assumption is not met.



# Question 6
par(mfrow=c(2,2))
plot(lm.saved)
par(mfrow=c(1,1))

On the Residuals vs Fitted graph, we see that there is a fanned patter, thus, 
equal variances are not met.



# Question 7
summary(lm.saved)
# result 
Call:
  lm(formula = mydata$Price ~ mydata$Sqft + mydata$Num_Bedrm + 
       mydata$Pool)

Residuals:
  Min      1Q  Median      3Q     Max 
-225669  -39322   -8850   25003  383317 

Coefficients:
                   Estimate Std. Error t value Pr(>|t|)
(Intercept)      -66160.638  13467.410  -4.913 1.21e-06
mydata$Sqft         165.418      5.891  28.080  < 2e-16
mydata$Num_Bedrm  -8793.430   4112.162  -2.138    0.033
mydata$Pool        9145.675  13832.541   0.661    0.509

(Intercept)      ***
  mydata$Sqft      ***
  mydata$Num_Bedrm *  
  mydata$Pool         
---
  Signif. codes:  
  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 78910 on 518 degrees of freedom
Multiple R-squared:  0.6746,	Adjusted R-squared:  0.6727 
F-statistic: 357.9 on 3 and 518 DF,  p-value: < 2.2e-16



# Question 8.a
H0: B1 = B2 = B3 = 0
H1: at least one Bi != 0



# Question 8.b
Test Statistic: 357.9 



# Question 8.c
p-value: 2.2e-16



# Question 8.d
Reject H0 becaus ep-value is pretty small compare to 0.04 significance level. 



# Question 8.e
There is enough evidence that the x variables explain some of variation in price.



# Question  9.a for Sqft
H0: B1 = 0
H1: B1 != 0



# Question 9.b for Sqft
T Test: 28.080 



# Question 9.c for Sqft
p-value: 2e-16



# Question 9.d for Sqft
Reject H0 because p-value is smaller than significance level of 0.04.



# Question 9.e for Sqft
There is enough evidence that Sqrt is important in explaining some of the variability in Price.



# Question  9.a for Num_Bedrm
H0: B2 = 0
H1: B2 != 0



# Question  9.b for Num_Bedrm
T Test: -2.138



# Question  9.c for Num_Bedrm
p-value: 0.033



# Question  9.d for Num_Bedrm
Reject H0 because p-value is smaller than significance level of 0.04.



# Question  9.e for Num_Bedrm
There is enough evidence that Num_Bedrm is important in explaining some of the variability in Price.



# Question 9.a for Pool
H0: B3 = 0
H1: B3 != 0



# Question 9.b for Pool
T Test: 0.661



# Question 9.c for Pool
p-value: 0.509



# Question 9.d for Pool
Do not reject H0 because p-value is bigger than significance level of 0.04.



# Question 9.e for Pool
There is not enough evidence that Pool is important in explaining some of the variability in Price.



























