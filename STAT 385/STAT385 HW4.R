# STAT 385 
# HW4
# Yelizvaeta Semikina

# Question 1
setwd("/Users/liza/Desktop")
chromoX<-read.table(file="ChromoXmicroarray.txt",header=TRUE)
BLClabels<-c(rep(1,13),rep(2,14),rep(3,20))

anova_pvalues <- apply(chromoX[, 3:49], 1, function(x) {
  aov_result <- aov(x ~ BLClabels)
  return(summary(aov_result)[[1]][["Pr(>F)"]][1])
})
selected_genes <- order(anova_pvalues)[1:2]
selected_data <- chromoX[selected_genes, 3:49]

normalize <- function(x) {
  return ( (x - min(x)) / (max(x) - min(x)) )
}
normalized_data <- apply(selected_data, 1, normalize)
gene_data <- data.frame(normalized_data, group=BLClabels)


# Question 2
set.seed(2023)
train_indices <- sample(c(1:47), 30)
train_data <- gene_data[train_indices, ]
test_data <- gene_data[-train_indices, ]

# Question 3
library(MASS) 
library(e1071)  
library(class)   

#LR
train_data_binary <- train_data
train_data_binary$BinaryGroup <- ifelse(train_data_binary$group %in% c(1, 2), 1, 0)
logistic_formula <- BinaryGroup ~ .
logistic_model_binary <- glm(logistic_formula, data = train_data_binary, family = binomial)
logistic_train_pred_binary <- predict(logistic_model_binary, train_data_binary, type = "response")
test_data_binary <- test_data
test_data_binary$BinaryGroup <- ifelse(test_data_binary$group %in% c(1, 2), 1, 0)
logistic_test_pred_binary <- predict(logistic_model_binary, newdata = test_data_binary, type = "response")


#LDA
lda_model <- lda(group ~ ., data = train_data)
lda_train_pred <- predict(lda_model, train_data)$class
lda_test_pred <- predict(lda_model, test_data)$class


# Naive Bayes model
naive_bayes_model <- naiveBayes(as.factor(test_data_binary$BinaryGroup) ~ ., data = test_data_binary)
naive_train_pred <- predict(naive_bayes_model, train_data)
naive_test_pred <- predict(naive_bayes_model, test_data)


# K-nearest neighbor method
knn_model_5 <- knn(train_data[, 1:2], test_data[, 1:2], cl = train_data$group, k = 5)
knn_model_10 <- knn(train_data[, 1:2], test_data[, 1:2], cl = train_data$group, k = 10)


# Question 4
par(mfrow=c(2,2))

# separation line for LDA
plot(train_data[, 1], train_data[, 2], col = as.numeric(train_data$group) + 1, pch = 19, main = "LDA method")
abline(lda_model$scaling[2] / lda_model$scaling[1], -lda_model$scaling[1] / lda_model$scaling[2])

# separation curve for NB
px1 <- seq(min(gene_data$X20475), max(gene_data$X20475), length = 100)
px2 <- seq(min(gene_data$X31009), max(gene_data$X31009), length = 100)
xgrid <- expand.grid(X20475 = px1, X31009 = px2)
nbpred <- predict(naive_bayes_model, newdata = xgrid)
plot(xgrid$X20475, xgrid$X31009, col = as.numeric(nbpred) + 1, pch = 20, cex = 0.2, main = "NB method")
points(train_data$X20475, train_data$X31009, col = as.numeric(train_data$group) + 1, pch = 19)

# Separation curve for KNN (k=5)
px1 <- seq(min(gene_data$X20475), max(gene_data$X20475), length = 100)
px2 <- seq(min(gene_data$X31009), max(gene_data$X31009), length = 100)
xgrid <- expand.grid(X20475 = px1, X31009 = px2)
ygrid5 <- knn(train = train_data[, c("X20475", "X31009")], test = xgrid, cl = train_data$group, k = 5)
plot(xgrid$X20475, xgrid$X31009, col = as.numeric(ygrid5) + 1, pch = 20, cex = 0.2, main = "KNN (k=5)")
points(train_data$X20475, train_data$X31009, col = as.numeric(train_data$group) + 1, pch = 19)

# Separation curve for KNN (k=10)
ygrid10 <- knn(train = train_data[, c("X20475", "X31009")], test = xgrid, cl = train_data$group, k = 10)
plot(xgrid$X20475, xgrid$X31009, col = as.numeric(ygrid10) + 1, pch = 20, cex = 0.2, main = "KNN (k=10)")
points(train_data$X20475, train_data$X31009, col = as.numeric(train_data$group) + 1, pch = 19)



# Question 5
# LR
truth <- test_data$group
logistic_pred <- ifelse(logistic_test_pred_binary >= 0.5, 1, 0)
table_logistic <- table(truth, logistic_pred)

# LDA
lda_pred <- predict(lda_model, test_data)$class
table_lda <- table(truth, lda_pred)

# Naive Bayes
nb_pred <- predict(naive_bayes_model, test_data)
table_nb <- table(truth, nb_pred)

# KNN (k=5 and k=10)
table_knn_5 <- table(truth, knn_model_5)
table_knn_10 <- table(truth, knn_model_10)


