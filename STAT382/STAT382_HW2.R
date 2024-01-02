## Homework 2
## Yelizaveta Semikina
## Task 1

# Question 1
setwd("/Users/liza/Desktop/STAT382")
mydata <- read.csv("Pollutants.csv")

str(mydata$NOX)
#result:
chr [1:46] "MEDIUM" "LOW" "LOW" "MEDIUM" "LOW" "MEDIUM" "LOW" "MEDIUM" "LOW" "MEDIUM" "MEDIUM" ...

mydata$NOX <- factor(mydata$NOX,order = TRUE,levels = c("LOW","MEDIUM","HIGH")) 
#result:
Ord.factor w/ 3 levels "LOW"<"MEDIUM"<..: 2 1 1 2 1 2 1 2 1 2 ...



# Question 2 
sd(mydata$CO)
#result:
5.260606

mean(mydata$CO)
#result:
7.960217

median(mydata$CO)
#result:
5.905



# Question 3
tapply(mydata$CO, mydata$NOX, summary)

#result:
$LOW
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
4.120   6.963  10.410  11.783  14.935  23.530 

$MEDIUM
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
3.380   4.815   5.690   6.503   7.355  12.300 

$HIGH
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
1.850   2.260   3.810   3.391   4.100   4.740 



# Question 4
tapply(mydata$CO, mydata$NOX, length)

#result:
LOW MEDIUM   HIGH 
18     19      9 



# Question 5
hist(mydata$CO, right = FALSE, ylim = c(0,20), main = "Carbon Monoxide Emissions", xlab = "CO Emissions")



# Question 6
boxplot(CO ~ NOX, data = mydata, ylim = c(0,25))



# Question 7
barplot(nox, ylim = c(0, 24), main = "Nitrogen Oxide Emissions")



## Task 2
# Question 8
mydata2 <- read.csv("BSandAge.csv")
str(mydata2$blood_sugar)

#result:
chr [1:475] "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" "Low" ...


str(mydata2$age)
#result:
chr [1:475] "Under 25" "Under 25" "Under 25" "Under 25" "Under 25" "Under 25" "Under 25" "Under 25" ...

mydata2$blood_sugar <- factor(mydata2$blood_sugar, order = TRUE,levels = c("Low","Normal","High"))
str(mydata2$blood_sugar)
#result:
Ord.factor w/ 3 levels "Low"<"Normal"<..: 1 1 1 1 1 1 1 1 1 1 ...

mydata2$age <- factor(mydata2$age, order = TRUE,levels = c("Under 25","25 - 49","Over 50"))
str(mydata2$age)
#result
Ord.factor w/ 3 levels "Under 25"<"25 - 49"<..: 1 1 1 1 1 1 1 1 1 1 ...



# Question 9
bloodsugarandage <- table(mydata2$blood_sugar, mydata2$age)
#result
       Under 25 25 - 49 Over 50
Low          34      31      37
Normal       34     101      92
High         27      47      72



# Question 10
barplot(bloodsugarandage, legend = rownames(bloodsugarandage), args.legend = list(x = "topleft"), main = "Barplot of Blood Sugar (Row) by Age (Colum)")



# Question 11
barplot(bloodsugarandage, col = c( "blue","green", "red" ), legend.text = TRUE, args.legend = list(x = "topleft"), beside = TRUE)





