energydata_updated <- read.csv("energydata_updated.csv")

#Task 1

#Variance unkown
#Use one sample t test

t.test(energydata_updated$OCCUPIED.UNITS.PERCENTAGE, mu = 0.90, alternative = "greater", conf.level = 0.97)

#One Sample t-test

#data:  energydata_updated$OCCUPIED.UNITS.PERCENTAGE
#t = 2.2026, df = 3832, p-value = 0.01384
#alternative hypothesis: true mean is greater than 0.9
#97 percent confidence interval:
#  0.9005662       Inf
#sample estimates:
#  mean of x 
#0.9038823

#H0: mu = 0.90 & H1: mu > 0.90. Based on our one sample t-test, we determined the p-value to be 0.01384. In this case the p-value is less than 0.03 which means we reject H0.
#We can conclude that there is evidence that the population mean of OCCUPIED.UNITS.PERCENTAGE is greater than 0.90.
#Our 97% confidence interval is 0.9038823 < mu. Since our hypothesized value of 0.90 is outside of our confidence interval it supports our conclusion.
#T test can still be done because the sample size is still large enough even though the data is moderately skewed.


#Task 2

#Difference of 2 means
#Equal variance test before

var.test(energydata_updated$KWH.TOTAL.SQFT, energydata_updated$THERMS.TOTAL.SQFT)
#P-value = 0.09805 --> greater than alpha DO NOT REJECT (True ratio of variances are equal to 1)
#There is no significant difference between the two variances.

t.test(energydata_updated$KWH.TOTAL.SQFT, energydata_updated$THERMS.TOTAL.SQFT, paired = FALSE, conf.level = 0.93, var.equal = TRUE)
#Two Sample t-test

#data:  energydata_updated$KWH.TOTAL.SQFT and energydata_updated$THERMS.TOTAL.SQFT
#t = -1.6935, df = 7664, p-value = 0.09041
#alternative hypothesis: true difference in means is not equal to 0
#93 percent confidence interval:
#  -483.86759   16.38363
#sample estimates:
#  mean of x mean of y 
#12073.28  12307.03

#H0: muKWH.TOTAL.SQFT = muTHERMS.TOTAL.SQFT & H1: muWH.TOTAL.SQF != muTHERMS.TOTAL.SQFT
#Based on our two sample t-test, we determined the p-value to be 0.09041. Since the p-value is greater than 0.07 we do not reject H0
#We can conclude that there is not a significant difference in the means of KWH.TOTAL.SQFT and THERMS.TOTAL.SQFT
#Our 93% confidence interval is -483.86759 < muD < 16.38363. Since zero is within the interval this supports our conclusion to no reject H0


#Task 3

#Age group varies by building type
#Fishers Exact Test

fisher.test(energydata_updated$Age_Group, energydata_updated$BUILDING.TYPE, conf.level = 0.96, alternative = "two.sided")
#Fisher's Exact Test for Count Data

#data:  energydata_updated$Age_Group and energydata_updated$BUILDING.TYPE
#p-value = 6.249e-09
#alternative hypothesis: two.sided

#H0: theta = 1 & H1: theta != 1. Based on our Fisher Exact test, we determined our p-value to be 6.249e-09. Since the p-value is less than 0.04 we reject H0.
#We can conclude that there is evidence that Age_Group and BUILDING.TYPE are not independent.


#Task 4

#SLR 
SLR <- lm(energydata_updated$KWH.SQFT.MEAN.2010~energydata_updated$AVERAGE.STORIES)

plot(x = energydata_updated$AVERAGE.STORIES, y = energydata_updated$KWH.SQFT.MEAN.2010, xlab = "Average Stories", ylab = "Mean KWh per square foot in 2010", main = "Scatterplot of Average Stories against Mean KWh per square foot in 2010")
abline(lm(energydata_updated$KWH.SQFT.MEAN.2010~energydata_updated$AVERAGE.STORIES))

cor(energydata_updated$KWH.SQFT.MEAN.2010, energydata_updated$AVERAGE.STORIES)

#Linearity
plot(x = energydata_updated$AVERAGE.STORIES, y = SLR$residuals, xlab = "Average Stories", ylab = "Residuals", main = "Linearity")
abline(h=0)
#Condition met - No noticeable pattern

#Normality
shapiro.test(SLR$residuals)
#Shapiro-Wilk normality test

#data:  SLR$residuals
#W = 0.93351, p-value < 2.2e-16

#Condition not met - p-value is too small

#Equal Variance
plot(x = SLR$fitted.values, y = SLR$residuals, xlab = "Fitted Values", ylab = "Residuals", main = "Equal Variance Test")
abline(h=0,lty=2)
#Condition met - No noticeable pattern

#H0: Beta = 0 & H1: Beta != 0
summary(SLR)
#P-value = 3.347e-14 --> Reject H0
#We can conclude that there is enough evidence of a significant linear relationship between AVERAGE.STORIES and KWH.SQFT.MEAN.2010.

#Equation of the Regression Line
SLR$coefficients
#Yhat_i = 1116.90763 + 48.11951 * X_i

#R^2
#0.0149
#Both r and R^2 both represent a slightly positive linear relationship. Overall, I believe that the model does not fit the data well because it failed the normality test and both r and R^2 are very low.


#Task 5

MLR <- lm(energydata_updated$TOTAL.THERMS~energydata_updated$TOTAL.UNITS + energydata_updated$AVERAGE.HOUSESIZE)

#Linearity Test
plot(x = energydata_updated$TOTAL.UNITS, y = MLR$residuals)
abline(h=0,lty=2)
#The condition is met because there are no apparent patterns on the scatterplot.

plot(x = energydata_updated$AVERAGE.HOUSESIZE, y = MLR$residuals)
abline(h=0,lty=2)
#The condition is met because there are no apparent patterns on the scatterplot.

#Normality Test
shapiro.test(MLR$residuals)
#Shapiro-Wilk normality test

#data:  MLR$residuals
#W = 0.98224, p-value < 2.2e-16
#The condition is not met because the p-value is too small

#Equal Variance Test
plot(x = MLR$fitted.values, y = MLR$residuals)
abline(h=0,lty=2)
#Condition met because no pattern

#Independence Test
summary(MLR)
#H0: Beta1 = Beta2 = 0 & H1: At least one Betaj != 0
#P-value = 6.927e-10 --> too small Reject H0
#R^2 = 0.01095 & R^2adj = 0.01044
#We can conclude that there is evidence that our x variables explain some of the variation in the dependent variable.

#Determine importance of independent variables
#Total Units: H0: Beta1 = 0 & H1: Beta1 != 0. The P-value = 0.0679. DO NOT REJECT H0. 
#We can conclude that there is not enough evidence that TOTAL.UNITS is important in explaining some of the variability of TOTAL.THERMS.

#Average Housesize: H0: Beta2 = 0 & H1: Beta2 != 0. The P-value = 7.45e-10. REJECT H0.
#We can conclude that there is enough evidence that AVERAGE.HOUSESIZE is important in explaining some of the variability of TOTAL.THERMS.

#I have determined that AVERAGE.HOUSESIZE is an important independent variable because out of the two, it had a p-value less than 0.05.


#Task 6

Age_Group2 <- factor(energydata_updated$Age_Group, ordered = TRUE, levels = c("Newer", "Middle", "Ancient"))

an <- aov(energydata_updated$THERMS.SQFT.MEAN.2010~Age_Group2)
summary(an)
shapiro.test(an$residuals)
#P-value too small condition not met

plot(x = an$fitted.values, y = an$residuals)
abline(h=0,lty=2)
#Condition not met - noticeable pattern

#H0: mu = 0 & H1: mu != 0. The p-value = 0.151. Do Not Reject H0.
#We can conclude that there is not enough evidence to suggest that THERMS.SQFT.MEAN.2010 varies by Age_Group2.


#Task 7

an2 <- aov(energydata_updated$THERMS.SQFT.MEAN.2010~energydata_updated$Housesize_Group)
summary(an2)
shapiro.test(an2$residuals)
#P-value is about 0.04. Condition met

plot(x = an2$fitted.values, y = an2$residuals)
abline(h=0,lty=2)
#Condition not met - noticeable pattern

#H0: mu = 0 & H1: mu != 0. The p-value = 0.00235.Reject H0.
#We can conclude that there is enough evidence to suggest that THERMS.SQFT.MEAN.2010 varies by Housesize_Group.


#Task 8

lm8 <- lm(energydata_updated$OCCUPIED.UNITS.PERCENTAGE~energydata_updated$Housesize_Group * energydata_updated$BUILDING.TYPE)
anova(lm8)
shapiro.test(lm8$residuals)
#P-value is too small - condition not met

plot(x = lm8$fitted.values, y = lm8$residuals)
abline(h=0,lty=2)
#Condition met

interaction.plot(x.factor = energydata_updated$Housesize_Group, trace.factor = energydata_updated$BUILDING.TYPE, response = energydata_updated$OCCUPIED.UNITS.PERCENTAGE)

#H0: (alphaBeta)ij = 0 & H1: At least one (alphaBeta)ij != 0. The p-value = 0.5569. Do Not Reject H0.
#We can conclude that there is enough evidence to suggest that the interaction is not significant.

#H0: (alpha)i = 0 & H1: At least one alphai != 0. The p-value = 4.455e-13. Reject H0.
#We can conclude that there is not enough evidence to suggest that the Housesize_Group variable is not significant.

#H0: Betaj = 0 & H1: At least one Betaj != 0. The p-value = 0.8988. Do Not Reject H0.
#We can conclude that there is enough evidence to suggest that the BUILDING.TYPE variable is not significant.

