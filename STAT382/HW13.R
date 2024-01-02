## HW 13
## Yelizaveta Semikina


# Question 1
mydata$History <- factor(mydata$History)
mydata$Test <- factor(mydata$Test)



# Question 2
Yijk = mu + αi + βj + (αβ)ij + Єijk
where αi = History; βj = Test, and (αβ)ij is the interaction



# Question 3
interaction2wt(mydata$Oxygen_uptake~mydata$History*mydata$Test)
interaction.plot(x.factor = mydata$History, trace.factor = mydata$Test,response = mydata$Oxygen_uptake)

there is an interaction which might be insigfinificant because after the interaction, lines change, 
Step line increases, Bicycle decreases and Treadmill increases but not as rapid as Step line.
History is significant, and Test is not significant. 



#  Question 4
lmmydata <- lm(mydata$Oxygen_uptake~mydata$History*mydata$Test)



# Question 5.a
hist(lmmydata$residuals, right = FALSE)
Histogram is perfectly bell shaped, there a gap on the right side. could be normal, but there are 
soe issues. 


# Question 5.b
qqnorm(lmmydata$residuals)
qqline(lmmydata$residuals)
There are some dots that are too far way from line in the begining and ending, not too normal. 


# Question 5.c
shapiro.test(lmmydata$residuals)
# result
Shapiro-Wilk normality test

data:  lmmydata$residuals
W = 0.96394, p-value = 0.4524

The p-valu eis bigger than significance level of 0.04, it means do not reject H0, there is not enough
evidence that it is not normal. 



# Question 6
plot(lmmydata$fitted.values, lmmydata$residuals, xlab = "Fitted Values", ylab = "Residual", main = "Overall Residual Plot")
abline(h = 0, lty = 2)
spread looks okay, there some differences but in general it is not significant. Equal varience 
assumption met. 



# Question 7
We do not need to do the Independence of Residuals Assumption because we do not have a time-series
data. 



# Question 8
anova(lmmydata)
# result
Analysis of Variance Table

Response: mydata$Oxygen_uptake
                             Df Sum Sq Mean Sq F value    Pr(>F)    
  mydata$History              2 184.71  92.356 11.1317 0.0007133 ***
  mydata$Test                 2  86.09  43.045  5.1882 0.0166278 *  
  mydata$History:mydata$Test  4 127.16  31.791  3.8318 0.0200985 *  
  Residuals                  18 149.34   8.297                      
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1



# Question 9.a
H0: (αβ)ij = 0, ∀i(i, j)
H1: at least one (αβ)ij != 0



# Question 9.b
test statistics: 3.8318



# Question 9.c
p-value is 0.0200985



# Question 9.d
Reject H0, because at significance level of 0.04, p-value is small. 



# Question 9.e
There is an evidence of interactions. 



# Question 10
I do not need to do check for main effects and perform  multiple comparisons because, in the
previous step we found out that there are interactions and when we have intercations, no need
to do these two checks. 



# Question 11
TukeyHSD(aov(mydata$Oxygen_uptake ~ mydata$History * mydata$Test), conf.level = 0.96)
# result
Tukey multiple comparisons of means
96% family-wise confidence level

Fit: aov(formula = mydata$Oxygen_uptake ~ mydata$History * mydata$Test)

$`mydata$History`
diff       lwr      upr     p adj
Moderate-Heavy     4.433333  0.816492 8.050175 0.0113940
Nonsmoker-Heavy    6.222222  2.605381 9.839064 0.0006442
Nonsmoker-Moderate 1.788889 -1.827952 5.405730 0.4040170

$`mydata$Test`
diff        lwr      upr     p adj
Step-Bicycle       4.344444  0.7276031 7.961286 0.0131065
Treadmill-Bicycle  2.611111 -1.0057303 6.227952 0.1609815
Treadmill-Step    -1.733333 -5.3501747 1.883508 0.4258857

$`mydata$History:mydata$Test`
diff          lwr         upr     p adj
Moderate:Bicycle-Heavy:Bicycle         -1.4666667  -9.97393597  7.04060264 0.9991796
Nonsmoker:Bicycle-Heavy:Bicycle         0.4333333  -8.07393597  8.94060264 0.9999999
Heavy:Step-Heavy:Bicycle               -3.1333333 -11.64060264  5.37393597 0.9082888
Moderate:Step-Heavy:Bicycle             6.9333333  -1.57393597 15.44060264 0.1411095
Nonsmoker:Step-Heavy:Bicycle            8.2000000  -0.30726931 16.70726931 0.0517088
Heavy:Treadmill-Heavy:Bicycle          -1.6000000 -10.10726931  6.90726931 0.9984815
Moderate:Treadmill-Heavy:Bicycle        3.1000000  -5.40726931 11.60726931 0.9129818
Nonsmoker:Treadmill-Heavy:Bicycle       5.3000000  -3.20726931 13.80726931 0.4153325
Nonsmoker:Bicycle-Moderate:Bicycle      1.9000000  -6.60726931 10.40726931 0.9950932
Heavy:Step-Moderate:Bicycle            -1.6666667 -10.17393597  6.84060264 0.9979825
Moderate:Step-Moderate:Bicycle          8.4000000  -0.10726931 16.90726931 0.0437703
Nonsmoker:Step-Moderate:Bicycle         9.6666667   1.15939736 18.17393597 0.0147710
Heavy:Treadmill-Moderate:Bicycle       -0.1333333  -8.64060264  8.37393597 1.0000000
Moderate:Treadmill-Moderate:Bicycle     4.5666667  -3.94060264 13.07393597 0.5968775
Nonsmoker:Treadmill-Moderate:Bicycle    6.7666667  -1.74060264 15.27393597 0.1596501
Heavy:Step-Nonsmoker:Bicycle           -3.5666667 -12.07393597  4.94060264 0.8340975
Moderate:Step-Nonsmoker:Bicycle         6.5000000  -2.00726931 15.00726931 0.1934796
Nonsmoker:Step-Nonsmoker:Bicycle        7.7666667  -0.74060264 16.27393597 0.0737147
Heavy:Treadmill-Nonsmoker:Bicycle      -2.0333333 -10.54060264  6.47393597 0.9923492
Moderate:Treadmill-Nonsmoker:Bicycle    2.6666667  -5.84060264 11.17393597 0.9606044
Nonsmoker:Treadmill-Nonsmoker:Bicycle   4.8666667  -3.64060264 13.37393597 0.5203320
Moderate:Step-Heavy:Step               10.0666667   1.55939736 18.57393597 0.0104080
Nonsmoker:Step-Heavy:Step              11.3333333   2.82606403 19.84060264 0.0034106
Heavy:Treadmill-Heavy:Step              1.5333333  -6.97393597 10.04060264 0.9988745
Moderate:Treadmill-Heavy:Step           6.2333333  -2.27393597 14.74060264 0.2327920
Nonsmoker:Treadmill-Heavy:Step          8.4333333  -0.07393597 16.94060264 0.0425642
Nonsmoker:Step-Moderate:Step            1.2666667  -7.24060264  9.77393597 0.9997168
Heavy:Treadmill-Moderate:Step          -8.5333333 -17.04060264 -0.02606403 0.0391314
Moderate:Treadmill-Moderate:Step       -3.8333333 -12.34060264  4.67393597 0.7775692
Nonsmoker:Treadmill-Moderate:Step      -1.6333333 -10.14060264  6.87393597 0.9982465
Heavy:Treadmill-Nonsmoker:Step         -9.8000000 -18.30726931 -1.29273069 0.0131472
Moderate:Treadmill-Nonsmoker:Step      -5.1000000 -13.60726931  3.40726931 0.4626259
Nonsmoker:Treadmill-Nonsmoker:Step     -2.9000000 -11.40726931  5.60726931 0.9380086
Moderate:Treadmill-Heavy:Treadmill      4.7000000  -3.80726931 13.20726931 0.5626744
Nonsmoker:Treadmill-Heavy:Treadmill     6.9000000  -1.60726931 15.40726931 0.1446648
Nonsmoker:Treadmill-Moderate:Treadmill  2.2000000  -6.30726931 10.70726931 0.9873821



We should make an analyze based on the History. The first one. 

















