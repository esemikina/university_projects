## Project 1 
## Yelizaveta Semikina

# Task 1
# Graphs
hist(mydata$Rating, right = FALSE, ylim = c(0,35), main = "Histogram of Rating", xlab = "Rating")
hist(mydata$Reviews, right = FALSE, ylim = c(0, 200), xlim = c(0, 9000000), main = "Histogram of Reviews", xlab = "Reviews")

boxplot(mydata$Rating, horizontal = TRUE, main = "Boxplot of Rating", xlab = "Rating")
boxplot(mydata$Reviews, horizontal = TRUE, breaks = c( 4, 516, 7306, 204111, 82166, 8118609), main = "Boxplot of Reviews", xlab = "Reviews")


# Summary
Reviews is a numeric, discrete variable and Rating is a numeric, continuous variable. 
The average total for reviews is 4.3 and the average total ratings is 204110. 
The min for rating is 3.8 and for reviews is 4. Also, the first and third quartiles for rating is between 4.3 and 4.4 
and for reviews between 516 and 82166. It means that data points for first quartile are 25% of data are found 
under 4.2 for rating and 516 for reviews and for the third quartiles that are 4.4 for rating  and 82166 for reviews, 
found 75% of data. The max for rating is 4.8 and for reviews is 8118609. In rating column we can see which app has
the best rating and we can see which app is better, as for reviews column, based on this column we can tell how many
people reviewed the app and we can conclude which app is the most popular.
As for graphs, the histogram for rating looks pretty normal, it is bell shpaed but a little bit skewed to the right. 
The histogram for Reviews is skewed right and it does not look like normal distribution. The boxplot for rating is 
normal, and for reviews it is not normally distributed. The reviews boxplot is positively skewed. On box boxplots 
we can see the Min, max, and first and third quartiles as well as IQR and median. 



# Task 2
# frequency 
table(mydata$Category)
table(mydata$Content.Rating)

# converting to factor
mydata$Content.Rating <- factor(mydata$Content.Rating, order = TRUE, levels = c("Teen","Mature 17+","Everyone 10+", "Everyone")) 
mydata$Category <- factor(mydata$Category, order = TRUE, levels = c("FAMILY","GAME","TOOLS"))

# converting to numeric varibales
category1 <- as.numeric(mydata$Category))
rating1 <- as.numeric(mydata$Content.Rating)

# histogram 
hist(category1, right = FALSE, ylim = c(0, 100), main = "Histogram of Category", xlab = "Category")

The Category is a categorical nominal variable and Content.Rating is a categorical ordinal variable. The Content.Rating
varibale contains people ages such as teen or Mature 17+ and etc. and can be sorted. When the Category variable contains
three types such as family, game and tools and can not be sorted. The Category and Content.Rating variables have 
a length of 164 and class of character. In content rating, we have 28 teens, 8 mature 17+, 10 everyone 10+ and 118 everyone, 
thus, we know that the amount of people who use the spcific app and categorized by their aged. Also, based on 
category column we know under what category each app. FOr example, Crazy Doctor app is for Family.  
In category we have 88 for family values, 41 for game and 35 for tools. Based on the histogram for Category, it is clear
that it is not normally distributed.



# Task 3
# graphs
boxplot(Rating ~ Category, data = mydata)
boxplot(Reviews ~ Category, data = mydata)

# summary statistics 
mean1 <- tapply(mydata$Rating, mydata$Category, mean)
FAMILY     GAME    TOOLS 
4.314773 4.292683 4.271429 

sd1 <- tapply(mydata$Rating, mydata$Category, sd)
FAMILY      GAME     TOOLS 
0.2152463 0.1737674 0.2066133 

mean2 <- tapply(mydata$Reviews, mydata$Category, mean)
FAMILY      GAME     TOOLS 
83313.22 480220.93 184386.14 

sd2 <- tapply(mydata$Reviews, mydata$Category, sd)
FAMILY      GAME     TOOLS 
216613.4 1381986.3  871841.4 


cbind(mean = mean1, std.dev = sd1)
           mean   std.dev
FAMILY 4.314773 0.2152463
GAME   4.292683 0.1737674
TOOLS  4.271429 0.2066133


cbind(mean = mean2, std.dev = sd2)
            mean   std.dev
FAMILY  83313.22  216613.4
GAME   480220.93 1381986.3
TOOLS  184386.14  871841.4



We can see that the code above shows us the means and standard deviations of the varibales Rating and Reviews sorted 
by Category. Based on the code above we also see that Game Category by Reviews has the highest mean  480220.93 and 
standart deviation 1381986.3 and Family categorized by Reviews has the lowest mean 83313.22 and standart deviation 216613.4. 
As for Rating varibale, the category Family has the highest mean 4.314773 and standart deviation 0.2152463 and 
Tools has the lowest mean 4.271429 and the Game has the lowest standart deviation 0.1737674. The boxplot for Rating 
by Category Game has pretty normal distrubution, the boxplot for Family right skewed and Tools is left skewed.
I assume that the boxplot for Reviews by Category does not looks like normally distributed at all also, the means in 
Reviews by Category are very different, the Family mean is 83313.22, the Game mean is 480220.93 and
the Tools mean is 184386.14. The same difference is in standart deviations. Thus, we can say that varibale Rating 
vary by Category due to small differences and varibale Reviews does not vary by Category. 


# Task 4
# graph
boxplot(Content.Rating ~ Category, data = mydata)

rating1 <- as.numeric(mydata$Content.Rating)
mean3 <- tapply(rating1, mydata$Category, mean)
  FAMILY     GAME    TOOLS 
3.511364 2.365854 4.000000 

sd3 <- tapply(rating1, mydata$Category, sd)
  FAMILY     GAME    TOOLS 
1.028271 1.337088 0.000000 

We have a variable Content.Rating by Category, the highest mean has category Tools 4.000000 and the lowest mean 2.365854
has category Game.The highest standart deviation 1.337088 has Game category and the lowest standart deviation 0.000000 
has Tools category. We can notice that the there is a small difference in means and standard deviations. As for
the boxplot, the Game category is skewed right and Family and Tools is very squeezed. Based on the means and 
standart deviations little differences I think that Content.Rating vary by Category. 



# Task 5 
# App Size Graphs
hist(mydata$App_Size, right = FALSE, main = "Histogram of App Size", xlab = "App Size")
skewness(mydata$App_Size)
#result
0.8831487

kurtosis(mydata$App_Size)
#result
-0.1156519


shapiro.test(mydata$App_Size)
# result
Shapiro-Wilk normality test
data:  mydata$App_Size
W = 0.89667, p-value = 2.633e-09


# Rating Graphs
hist(mydata$Rating, right = FALSE, ylim = c(0,35), main = "Histogram of Rating", xlab = "Rating")

skewness(mydata$Rating)
#result
1.296361e-15


kurtosis(mydata$Rating)
#result 
-0.3117621


shapiro.test(mydata$Rating)
# result 
Shapiro-Wilk normality test
data:  mydata$Rating
W = 0.97804, p-value = 0.01041





