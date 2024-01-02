## Project 2
## Yelizaveta Semikina

mydata <- read.csv("/Users/liza/Desktop/STAT382/apps_data.csv")
mydata1 <- read.csv("/Users/liza/Desktop/STAT382/paid_apps.csv")

## Task 1
# mydata
mydata$Category <- factor(mydata$Category)
mydata$Content.Rating <- factor(mydata$Content.Rating)
mydata$Genre <- factor(mydata$Genre)
# mydata1
mydata1$Category <- factor(mydata1$Category)
mydata1$Content.Rating <- factor(mydata1$Content.Rating)
mydata1$Genre <- factor(mydata1$Genre)



## Task 2
t.test(mydata$App_Size, mu = 0.25, alternative = "greater", conf.level = 0.92)
# H0: mu = 0.25 vs H1: mu > 0.25
# P-value is 2.2e-16
# p-value is less than significance level of 0.02, thus, reject H0. 
# There is enough evidence that the population mean is greater than 0.25
# The confidence interval is 27.94954 > mu. It supports our conclusion because 
# 0.25 is not on included on the interval. 
# We can conduct a t-test despite that data is not notmally distributed because 
# based on Central Limit Theorem, when the sample size is large and data is skewed, 
# t-test can be still perfomed based on these reqirements. 



## Task 3
game <- mydata[mydata$Category=="GAME",4]
notgame <- mydata[mydata$Category !="GAME",4]

# equal variance test
var.test(game, notgame, conf.level = 0.93)
# p-value (2.2e-16) is less than significance level of 0.07, thus, reject H0, 
# there is significant difference between  game and not games categories. 

# difference of 2 means
t.test(game, notgame, paired = FALSE, conf.level = 0.93, var.equal = FALSE)
# H0: game = notgame vs H1: game != notgame
# p-value is 0.1021, it is bigger than significnace level of 0.07, thus do not reject H0, 
# There is no significant difference in the means of game and notgame. 
# The confidence interval is -41347.14 < muD < 777641.39, zero is on the interval, 
# Thus, it supports out conclusion that we do not reject H0. 



## Task 4
fisher.test(mydata$Content.Rating, mydata$Category, alternative = "two.sided", conf.level = 0.96)
# H0: θ = 1 vs H1: θ != 1
# p-value is 2.314e-09
# P-value is less than significance level of 0.04, thus, reject H0.
# There is evidence that Content.Rating and Category are not independent. 



## Task 5
SLR <- lm(mydata$Rating~mydata$App_Size)
# Scatterplot
plot(x = mydata$App_Size, y = mydata$Rating, xlab = "App Size", ylab = "Rating", main = "Scatterplot of App Size against Rating")
abline(lm(mydata$Rating~mydata$App_Size))

# Pearson
cor.test(mydata$Rating, mydata$App_Size)

# Linearity Check
plot(x = mydata$App_Size, y = SLR$residual, main = "Linearity Check, SLR")
abline(h=0)
# Linear assumption is met because there is no pattern. 

# Normality Check
shapiro.test(SLR$residuals)
#Normality assumption is met because p-value (0.1587) is big compare to significance level of 0.03. 

# Equal Variance Check
plot(x = SLR$fitted.values, y = SLR$residuals, xlab = "Fitted Values", ylab = "Residuals", main = "Equal Variance Check, SLR")
abline(h=0)
# Equal Variance Assumption is met because there is no pattern. 

summary(SLR)
# H0: β1 =0 vs H1: β2 != 0 
# p-value is 0.5552. 
# We use F-statistics.
# p-value is bigger than significance level of 0.03, thus, do not reject H0. 
# there is not enough evidence that App Size is important in explaining some of the variability in Rating. 

# equation of the regression line, and the value of R2
SLR$coefficients
# yi = 4.31 -0.0003Xi

# R-squared is 0.002153 = 0.21%
# R^2 is closer to 0.5, indicating the model is not doing good a job and it does not fit the model well.
# 0.21% of the variability in Rating is explained by App Size.



## Task 6
MLR <- lm(mydata1$Price~mydata1$Rating + mydata1$App_Size)

# Linearity Check
plot(x = mydata1$Rating, y = MLR$residuals, main = "Linearity Check for Rating, MLR")
abline(h=0)
# Linearity check is not met because there is fanned pattern. 

plot(x = mydata1$App_Size, y = MLR$residuals, main = "Linearity Check for App Size, MLR")
abline(h=0)
# Linearity check is met because there is no pattern. 

# Normality Check 
shapiro.test(MLR$residuals)
# the p-value (0.001051) is small compare to significance level of 0.10. It is not normal. 

# Equal Variance Check
plot(x = MLR$fitted.values, y = MLR$residuals, xlab = "Fitted Values", ylab = "Residuals", main = "Equal Variance Check, MLR")
abline(h=0)
# Equal Variance Check is met because there is no pattern. 

# Independent Variables Check
summary(MLR)
# H0: β1 = β2 = 0 vs H1: at least one βj != 0
# p-value is 0.09803
# compare to significance level of 0.10 p-value is small, thus, Reject H0
# There is enough  evidence that  App Size and Rating explain some of variability in Price
# R-squared is 0.04287
# Adjusted R-squared is  0.02481 

# Determine which independent variables are important
# # H0: β1 =0 vs H1: β1 != 0 
# p-value for Rating is 0.1865
# compare to significance level of 0.10 p-value is big, thus, do not reject H0
# There is not enough evidence that Rating explain some of variability in Price

# # H0: β2 =0 vs H1: β2 != 0 
# p-value for App Size is 0.0831
# compare to significance level of 0.10 p-value is smaller, thus, reject H0
# There is enough evidence that App Size explain some of variability in Price
# Thus, App Size variable is an independent variable that is more important than Rating in explaining some 
# variability in Price because it has smaller p-value. 



## Task 7
lmmydata <- lm(mydata$Reviews~mydata$Category)

summary(mydata$Category)

residual <- lmmydata$residual
mydata2 <- cbind(mydata, residual)

mydata2fam <- mydata2$residual[mydata2$Category == "FAMILY"]
mydata2game <- mydata2$residual[mydata2$Category == "GAME"]
mydata2tool <- mydata2$residual[mydata2$Category == "TOOLS"]

# Normality  Check
qqnorm(mydata2fam, main = "Q-Q Plot for Family Category")
qqline(mydata2fam)
# It is not normal because we can see that there are issues in the beginning and ending of the line.

qqnorm(mydata2game, main = "Q-Q Plot for Game Category")
qqline(mydata2game)
# It is not normal because we can see that there are issues in the beginning and ending of the line.

qqnorm(mydata2tool, main = "Q-Q Plot for Tools Category")
qqline(mydata2tool)
# It is not normal because we can see that there are issues in the ending of the line.

shapiro.test(mydata2fam)
# It is not normal because p-value(2.2e-16) is small compare to significance level of 0.04

shapiro.test(mydata2game)
# It is not normal because p-value(4.734e-12) is small compare to significance level of 0.04

shapiro.test(mydata2tool)
# It is not normal because p-value(1.435e-12) is small compare to significance level of 0.04

par(mfrow = c(2,2))
hist(mydata2fam, right = FALSE, main = "Residual Histogram", sub = "Category Family")
hist(mydata2game, right = FALSE, main = "Residual Histogram", sub = "Category Game")
hist(mydata2tool, right = FALSE, main = "Residual Histogram", sub = "Category Tools")
par(mfrow = c(1,1))
# All of the three histograms are right skewed. It is not normal, thus we can say that the 
# normality condition is not met. 

# Equal Variance Check 
leveneTest(lmmydata)
# p-value(0.04248) is bigger than significance level of 0.04. 
# Thus, do not reject, there is evidence for equal variance. 

lm.anova <-  anova(lmmydata)
# H0: µF = µG = µT vs H1: at least one of the means is different
# p-value is 0.03758, it is smaller than significance level of 0.04. Thus, Reject H0, there is evidence that at leats  one of the 
# means is different. 

# Tukey Test
lm.aov <- aov(mydata$Reviews~mydata$Category)
tukey <- TukeyHSD(lm.aov, conf.level = 0.96)
# Reject H0 for GAME-FAMILY because the p-value is less than 0.04 significance level and zero is not on the interval. 
# For TOOLS-FAMILY and TOOLS-GAME do not reject  H0 because the p-value are bigger than 0.04 significance level and
# zero is on the intervals. Thus, TOOLS-FAMILY and TOOLS-GAME difference is not significant and for GAME-FAMILY
# difference is significant. 



## Task 8
lmmydata1 <- lm(mydata$Rating~mydata$Category)
summary(mydata$Category)

residual1 <- lmmydata1$residual
mydata3 <- cbind(mydata, residual1)

mydata3fam <- mydata3$residual[mydata3$Category == "FAMILY"]
mydata3game <- mydata3$residual[mydata3$Category == "GAME"]
mydata3tool <- mydata3$residual[mydata3$Category == "TOOLS"]

# Normality  Check
qqnorm(mydata3fam, main = "Q-Q Plot for Family Category")
qqline(mydata3fam)
# It is not normal because we can see that there are issues all over the line.

qqnorm(mydata3game, main = "Q-Q Plot for Game Category")
qqline(mydata3game)
# It is not normal because we can see that there are issues all over the line.

qqnorm(mydata3tool, main = "Q-Q Plot for Tools Category")
qqline(mydata3tool)
# It is not normal because we can see that there are issues all over the line.

shapiro.test(mydata3fam)
# It is normal because p-value(0.1166) is big compare to significance level of 0.03

shapiro.test(mydata3game)
# It is normal because p-value(0.1976) is big compare to significance level of 0.03

shapiro.test(mydata3tool)
# It is normal because p-value(0.2407) is big compare to significance level of 0.03

par(mfrow = c(2,2))
hist(mydata3fam, right = FALSE, main = "Residual Histogram", sub = "Category Family")
hist(mydata3game, right = FALSE, main = "Residual Histogram", sub = "Category Game")
hist(mydata3tool, right = FALSE, main = "Residual Histogram", sub = "Category Tools")
par(mfrow = c(1,1))
# All of the three histograms are bell shaped. It is normal. 

# Equal Variance Check 
leveneTest(lmmydata1)
# the p-value is 0.4746 which is bigger than significance level of 0.03. 
# Thus, do not reject, there is evidence for equal variance.  

# H0: µF = µG = µT vs H1: at least one of the means is different
lm.anova1 <-  anova(lmmydata1)
# p-value is 0.5493, it is bigger than significance level of 0.03. 
#Thus, do not reject H0, there is not  enough evidence that at least one of the means is different.



## Task 9
lmmydata2 <- lm(mydata1$Price~mydata1$Content.Rating*mydata1$Category)
interaction.plot(x.factor = mydata1$Content.Rating,trace.factor = mydata1$Category,response = mydata1$Price, main = "Interaction Plot")

mean_price_category <- tapply(mydata1$Price,mydata1$Category,mean)
mean_price_contentRating <- tapply(mydata1$Price,mydata1$Content.Rating ,mean)

bp1 <- barplot(mean_price_category, xlab = "Category", ylab = " Average Price", main = "Barplot of Price vs Category", ylim = c(0, 6))
bp2 <- barplot(mean_price_contentRating, xlab = "Content Rating", ylab = " Average Price", main = "Barplot of Price vs Content Rating", ylim = c(0, 6))

anova(lmmydata2)

# Normality Check 
hist(lmmydata2$residuals, right = FALSE)
# The histogram looks pretty Bell Shaped. It is normal. 

qqnorm(lmmydata2$residuals, main = "Q-Q Plot of lmmydata2")
qqline(lmmydata2$residuals)
# The plot is not normal because there are some issues over the whole line. 

shapiro.test(lmmydata2$residuals)
# The p-value is 0.04457, it is bigger than significance level of 0.025, thus, it is normal.

#  Equal Variance Check 
plot(x = lmmydata2$fitted.values, y = lmmydata2$residuals, xlab = "Fitted Values", ylab = "Residuals", 
main = "Equal Variance Check, lmmydata2")
abline(h=0)
# Based on the plot, it does not look like there are equal variance because the dots spread differently. 

# H0: (αβ)ij = 0, ∀i(i, j) vs H1: at least one (αβ)ij != 0
# the p-value for interaction is 0.01462, it is small compare to significance level of 0.025, thus, 
# reject H0, there is evidence that interaction is significant and that it is present. We should stop
# analysis here.

















