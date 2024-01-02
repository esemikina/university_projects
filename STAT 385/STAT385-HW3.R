## STAT 385 
## HW3
## Yelizaveta Semikina
install.packages("ISLR2")
library("ISLR2")
Carseats
Boston

#Question 10
# a
model1 <- lm(Sales ~ Price + Urban + US, data = Carseats)

#d
summary(model1)

#e
model2 <- lm(Sales ~ Price + US, data = Carseats)

#g
confint(model2, level=0.95)


#Question 13
#a
set.seed(1)
x <- rnorm(100, mean = 0, sd = 1)

#b
eps <- rnorm(100, mean = 0, sd = 0.25)

#c
y <- -1 + 0.5 * x + eps

#d
plot(x, y, main = "Scatterplot of x and y", xlab = "x", ylab = "y")

#e
lm_model <- lm(y ~ x)

#f
abline(lm_model, col = "red", lwd = 2)  
abline(-1, 0.5, col = "blue", lwd = 2, lty = 2) 
legend("topleft", legend = c("Least Squares Line", "Population Regression Line"), col = c("red", "blue"), lty = c(1, 2), lwd = 2)

#g
lm_model2 <- lm(y ~ poly(x, 2))

#h
set.seed(1)
x <- rnorm(100, mean = 0, sd = 1)

eps_less_noisy <- rnorm(100, mean = 0, sd = 0.1) 

y_less_noisy <- -1 + 0.5 * x + eps_less_noisy

lm_model_less_noisy <- lm(y_less_noisy ~ x)
summary(lm_model_less_noisy)

#i 
set.seed(1)
x <- rnorm(100, mean = 0, sd = 1)

eps_more_noisy <- rnorm(100, mean = 0, sd = 0.5)  

y_more_noisy <- -1 + 0.5 * x + eps_more_noisy

lm_model_more_noisy <- lm(y_more_noisy ~ x)
summary(lm_model_more_noisy)

#j
confint(lm_model)

confint(lm_model_less_noisy)

confint(lm_model_more_noisy)


#Question 15
#a
data <- Boston
model_zn <- lm(crim ~ zn, data)
model_indus <- lm(crim ~ indus, data)
model_chas <- lm(crim ~ chas, data)
model_nox <- lm(crim ~ nox, data)
model_rm <- lm(crim ~ rm, data)
model_age <- lm(crim ~ age, data)
model_dis <- lm(crim ~ dis, data)
model_rad <- lm(crim ~ rad, data)
model_tax <- lm(crim ~ tax, data)
model_ptratio <- lm(crim ~ ptratio, data)
model_lstat <- lm(crim ~ lstat, data)
model_medv <- lm(crim ~ medv, data)


summary(model_zn)
summary(model_indus)
summary(model_chas)
summary(model_nox)
summary(model_rm)
summary(model_age)
summary(model_dis)
summary(model_rad)
summary(model_tax)
summary(model_ptratio)
summary(model_lstat)
summary(model_medv)

plot(data$zn, data$crim, pch = 20, main = "Scatterplot of zn and crim")
abline(model_zn, lwd = 3)

plot(data$indus, data$crim, pch = 20, main = "Scatterplot of indus and crim")
abline(model_indus, lwd = 3)

plot(data$chas, data$crim, pch = 20, main = "Scatterplot of chas and crim")
abline(model_chas, lwd = 3)

plot(data$nox, data$crim, pch = 20, main = "Scatterplot of nox and crim")
abline(model_nox, lwd = 3)

plot(data$rm, data$crim, pch = 20, main = "Scatterplot of rm and crim")
abline(model_rm, lwd = 3)

plot(data$age, data$crim, pch = 20, main = "Scatterplot of age and crim")
abline(model_age, lwd = 3)

plot(data$dis, data$crim, pch = 20, main = "Scatterplot of dis and crim")
abline(model_dis, lwd = 3)

plot(data$rad, data$crim, pch = 20, main = "Scatterplot of rad and crim")
abline(model_rad, lwd = 3)

plot(data$tax, data$crim, pch = 20, main = "Scatterplot of tax and crim")
abline(model_tax, lwd = 3)

plot(data$ptratio, data$crim, pch = 20, main = "Scatterplot of ptratio and crim")
abline(model_ptratio, lwd = 3)

plot(data$lstat, data$crim, pch = 20, main = "Scatterplot of lstat and crim")
abline(model_lstat, lwd = 3)

plot(data$medv, data$crim, pch = 20, main = "Scatterplot of medv and crim")
abline(model_medv, lwd = 3)

#b
lm.fit <- lm(crim ~.,data = Boston)
summary(lm.fit)

#c
uni_reg <- vector("numeric", 0)
multiple_reg <- vector("numeric", 0)

uni_reg <- c(uni_reg, model_zn$coefficient[2])
uni_reg <- c(uni_reg, model_indus$coefficient[2])
uni_reg <- c(uni_reg, model_chas$coefficient[2])
uni_reg <- c(uni_reg, model_nox$coefficient[2])
uni_reg <- c(uni_reg, model_rm$coefficient[2])
uni_reg <- c(uni_reg, model_age$coefficient[2])
uni_reg <- c(uni_reg, model_dis$coefficient[2])
uni_reg <- c(uni_reg, model_rad$coefficient[2])
uni_reg <- c(uni_reg, model_tax$coefficient[2])
uni_reg <- c(uni_reg, model_ptratio$coefficient[2])
uni_reg <- c(uni_reg, model_lstat$coefficient[2])
uni_reg <- c(uni_reg, model_medv$coefficient[2])

multiple_reg <- c(multiple_reg, lm.fit$coefficients)
multiple_reg <- multiple_reg[-1]

plot(uni_reg, multiple_reg, pch =15, ylab = "Multiple Regression Coefficients", xlab = "Univariate Regression Coefficients", main = "Plot")

#d
model1_zn <- lm(data$crim~ data$zn + I(data$zn^2) +I(data$zn^3))
model2_indus <- lm(data$crim~ data$indus + I(data$indus^2) +I(data$indus^3))
model3_chas <- lm(data$crim~ data$chas + I(data$chas^2) +I(data$chas^3))
model4_nox <- lm(data$crim~ data$nox + I(data$nox^2) +I(data$nox^3))
model5_rm <- lm(data$crim~ data$rm + I(data$rm^2) +I(data$rm^3))
model6_age <- lm(data$crim~ data$age + I(data$age^2) +I(data$age^3))
model7_dis <- lm(data$crim~ data$dis + I(data$dis^2) +I(data$dis^3))
model8_rad <- lm(data$crim~ data$rad + I(data$rad^2) +I(data$rad^3))
model9_tax <- lm(data$crim~ data$tax + I(data$tax^2) +I(data$tax^3))
model10_ptratio <- lm(data$crim~ data$ptratio + I(data$ptratio^2) +I(data$ptratio^3))
model11_lstat<- lm(data$crim~ data$lstat + I(data$lstat^2) +I(data$lstat^3))
model12_medv <- lm(data$crim~ data$medv + I(data$medv^2) +I(data$medv^3))

summary(model1_zn)
summary(model2_indus)
summary(model3_chas)
summary(model4_nox)
summary(model5_rm)
summary(model6_age)
summary(model7_dis)
summary(model8_rad)
summary(model9_tax)
summary(model10_ptratio)
summary(model11_lstat)
summary(model12_medv)



















