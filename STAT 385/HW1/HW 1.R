### STAT 385, Homework 1 
### Yelizaveta Semikina
#Question 1
#a)
vector <- rchisq(400, df = 4)
mean1 <- mean(vector)
variance1 <- var(vector)
hist(vector, main = "Histogram")
empirical <- mean(vector > 1)

#b) 
matrix <- matrix(vector, nrow = 40, ncol = 10)
matrix_means <- apply(matrix, 2, mean)

#c)
new_vector <- vector[vector > 4]


#Question 2
#a)
n_vec <- c(10, 20, 30)
p_vec <- c(0.2, 0.5)
N <- 1000

approx_exp_binom <- function(n_vec, p_vec, N) {
  expX <- matrix(0, length(n_vec), length(p_vec))
  
  for (i in 1:length(n_vec)) {
    for (j in 1:length(p_vec)) {
      n <- n_vec[i]
      p <- p_vec[j]
      k <- 0:N
      
      pk <- dbinom(k, size = n, prob = p)
      expectation <- sum(k * pk)
      
      expX[i, j] <- expectation
    }
  }
  
  return(expX)
}

result <- approx_exp_binom(n_vec, p_vec, N)
result

#b)
approx_exp_binom_random <- function(n, p, N) {
  k <- 0:N
  pk <- dbinom(k, size = n, prob = p)
  expectation <- sum(k * pk)
  return(expectation)
}


#Question 3
n_vec <- c(10, 20, 30)
p_vec <- c(0.2, 0.5)
N <- 30

plot(0:N, dbinom(0:N, size = n_vec[1], prob = p_vec[1]), type = "n",
     xlab = "x", ylab = "Probability Mass Function",
     main = "Combined Binomial PMFs")

colors <- c("blue", "red", "green", "orange", "purple", "pink")
legend_text <- character(0)

for (i in 1:length(n_vec)) {
  for (j in 1:length(p_vec)) {
    n <- n_vec[i]
    p <- p_vec[j]
    pmf <- dbinom(0:N, size = n, prob = p)
    lines(0:N, pmf, lwd = 2, col = colors[i + (j - 1) * length(n_vec)], lty = j)
    legend_text <- c(legend_text, paste("n=", n, ", p=", p))
  }
}

legend("topright", legend = legend_text, col = colors[1:(length(n_vec) * length(p_vec))],
       lty = rep(1:length(p_vec), each = length(n_vec)), lwd = 2)


#Question 4
#a)
college <- read.csv("/Users/liza/Desktop/STAT 385/College.csv")

#b)
rownames (college) <- college[, 1]
view(college)
college <- college[, -1]
view(college)

#c)
#i)
summary(college)

#ii)
numeric_cols <- college[, sapply(college, is.numeric)]
pairs(numeric_cols[, 1:10])

#iii)
is.na(college$Outstate)
is.na(college$Private)

college$Private <- as.factor(college$Private)
college$Outstate <- as.numeric(college$Outstate)

boxplot(Outstate ~ Private, data = college, xlab = "Private", ylab = "Outstate", main = "Boxplots of Outstate vs Private")

#iv)
Elite <- rep("No", nrow(college))
Elite[college$Top10perc > 50] <- "Yes"
college$Elite <- as.factor(Elite)

summary(college$Elite)

boxplot(Outstate ~ Elite, data = college, xlab = "Elite", ylab = "Outstate", main = "Boxplots of Outstate vs Elite")

#v) 
par(mfrow = c(2, 2))

hist(college$Apps, main = "Histogram of Applications", xlab = "Applications")
hist(college$Accept, main = "Histogram of Acceptances", xlab = "Acceptances")
hist(college$Enroll, main = "Histogram of Enrollments", xlab = "Enrollments")
hist(college$Top10perc, main = "Histogram of Top10perc", xlab = "Top10perc")

#vi)
summary(college[, c("Accept", "Enroll", "Grad.Rate", "Outstate")])

correlation <- cor(college[, c("Accept", "Enroll", "Grad.Rate", "Outstate")])


