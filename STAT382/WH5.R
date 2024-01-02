## Homework 5
## Name: Yelizaveta Semikina

# Question 1
setwd("/Users/liza/Desktop/STAT382")
mydata <- read.csv("BSandAge.csv")


mydata$blood_sugar <- factor(mydata$blood_sugar, order = TRUE, levels = c("Low", "Normal", "High"))
str(mydata$blood_sugar)
# result 
Ord.factor w/ 3 levels "Low"<"Normal"<..: 1 1 1 1 1 1 1 1 1 1 ...


mydata$age <- factor(mydata$age, order = TRUE, levels = c("Under 25", "25 - 49", "Over 50"))
str(mydata$age)
# result 
Ord.factor w/ 3 levels "Under 25"<"25 - 49,"<..: 1 1 1 1 1 1 1 1 1 1 ...



# Question 2
table(mydata$blood_sugar)
# result 
Low Normal   High 
102    227    146 



# Question 3
btable <- table(mydata$blood_sugar, mydata$age)
btable
# result
       Under 25 25 - 49 Over 50
Low          34      31      37
Normal       34     101      92
High         27      47      72



# Question 4
addmargins(btable)
#result
       Under 25 25 - 49 Over 50 Sum
Low          34      31      37 102
Normal       34     101      92 227
High         27      47      72 146
Sum          95     179     201 475



# Question 5
sum(btable)
# result
475

# for blood sugar
rowSums(btable) / sum(btable)
# result
      Low    Normal      High 
0.2147368 0.4778947 0.3073684

# for age 
colSums(btable) / sum(btable)
# result
 Under 25   25 - 49   Over 50 
0.2000000 0.3768421 0.4231579



# Question 6
btable / sum(btable)
# result
Under 25    25 - 49    Over 50
Low    0.07157895 0.06526316 0.07789474
Normal 0.07157895 0.21263158 0.19368421
High   0.05684211 0.09894737 0.15157895



# Question 7 
btable / colSums(btable)
# result
        Under 25   25 - 49   Over 50
Low    0.3578947 0.3263158 0.3894737
Normal 0.1899441 0.5642458 0.5139665
High   0.1343284 0.2338308 0.3582090



# Question 8 
dotchart(btable, lcolor = "blue", xlim = c(10, 120), xlab = "Frequency", main = "Dotchart of Blood Sugar and Age")
