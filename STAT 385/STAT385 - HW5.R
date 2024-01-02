# STAT 385 - HW 5
# Yelizaveta Semikina

install.packages("ISLR2")
library("ISLR2")
attach(College)
attach(Boston)

# Question 8
#a
set.seed(1)
X <- rnorm(100)
noise_vect <- rnorm(100)


#b
Y <- 3 + 1*X + 4*X^2 - 1*X^3 + noise_vect


#c
library(leaps)
library(ggplot2)
library(dplyr)

df <- data.frame(Y, X)
fit <- regsubsets(Y ~ poly(X, 10), data = df, nvmax = 10)
fit_summary <- summary(fit)

cp_values <- fit_summary$cp
bic_values <- fit_summary$bic
adjr2_values <- fit_summary$adjr2

best_cp_model <- which.min(cp_values)
best_bic_model <- which.min(bic_values)
best_adjr2_model <- which.max(adjr2_values)

# Get the coefficients for the best models
best_cp_model_coef <- coef(fit, id = best_cp_model)
best_bic_model_coef <- coef(fit, id = best_bic_model)
best_adjr2_model_coef <- coef(fit, id = best_adjr2_model)

plot_data <- data.frame(
  ModelSize = 1:10,
  Cp = cp_values,
  BIC = bic_values,
  AdjR2 = adjr2_values
)

plot_data_long <- plot_data %>%
   pivot_longer(-ModelSize, names_to = "Criterion", values_to = "Value")

ggplot(plot_data_long, aes(x = ModelSize, y = Value, color = Criterion)) +
  geom_line() +
  geom_point() +
  ylab('Criterion Value') +
  xlab('Number of Variables Used') +
  facet_wrap(~ Criterion, scales = 'free')

# we have 3 parameters

#d
library(caret)

df <- data.frame(Y, X)

# Backward stepwise selection
model_back <- train(Y ~ poly(X, 10), data = df, 
                    method = 'glmStepAIC', direction = 'backward', 
                    trace = 0,
                    trControl = trainControl(method = 'none', verboseIter = FALSE))

back_predictions <- predict(model_back, df)
back_rmse <- sqrt(mean((back_predictions - df$Y)^2))
back_r_squared <- cor(back_predictions, df$Y)^2
back_mae <- mean(abs(back_predictions - df$Y))

# summary of backward stepwise selection
summary(model_back$finalModel)

# Forward stepwise selection
x_poly <- poly(df$X, 10)
colnames(x_poly) <- paste0('poly', 1:10)

selected_cols <- 1:ncol(x_poly)

model_forw <- train(Y ~ .,
                    data = data.frame(Y = df$Y, x_poly),  # Include Y and the predictor columns
                    method = 'glmStepAIC',
                    direction = 'forward',
                    trace = 0,
                    trControl = trainControl(method = 'none', verboseIter = FALSE))

forw_predictions <- predict(model_forw, data.frame(x_poly))
forw_rmse <- sqrt(mean((forw_predictions - df$Y)^2))
forw_r_squared <- cor(forw_predictions, df$Y)^2
forw_mae <- mean(abs(forw_predictions - df$Y))

# summary of forward stepwise selection
summary(model_forw$finalModel)


#e
library(glmnet)

X_matrix <- as.matrix(data_df[, -ncol(data_df)])  
Y_vector <- data_df$Y  

lasso_model <- cv.glmnet(X_matrix, Y_vector, alpha = 1)
plot(lasso_model)
optimal_lambda <- lasso_model$lambda.min
coefficients <- coef(lasso_model, s = "lambda.min")


#f
Y <- 3 + 8 * X^7 + noise_vect
df_2 <- data_frame(Y = Y, X = df[,-1])
fit <- regsubsets(Y ~ poly(X, 10), data = df_2, nvmax = 10)
fit_summary <- summary(fit)

results_df <- data_frame(
  Cp = fit_summary$cp,
  BIC = fit_summary$bic,
  R2 = fit_summary$adjr2
)

results_df %>%
  mutate(id = row_number()) %>%
  gather(value_type, value, -id) %>%
  ggplot(aes(id, value, col = value_type)) +
  geom_line() + geom_point() + ylab('') + xlab('Number of Variables Used') +
  facet_wrap(~ value_type, scales = 'free') +
  theme_tufte() + scale_x_continuous(breaks = 1:10)

lasso_y_model <- train(
  Y ~ poly(X, 10),
  data = df_2,
  method = 'glmnet',
  trControl = trainControl(method = 'cv', number = 5),
  tuneGrid = expand.grid(alpha = 1, lambda = seq(0.001, 0.2, by = 0.005))
)

coefficients <- coef(lasso_y_model$finalModel, lasso_y_model$bestTune$lambda)
print(coefficients)

performance <- postResample(predict(lasso_y_model, df_2), df_2$Y)
print(performance)




# Question 9
#a
library(ISLR)
library(caret)
library(glmnet)
library(pls)

set.seed(123)

trainIndex <- createDataPartition(College$Apps, p = 0.7, list = FALSE)
train_data <- College[trainIndex, ]
test_data <- College[-trainIndex, ]

y_train <- train_data$Apps
y_test <- test_data$Apps
x_train <- as.matrix(train_data[, -1])
x_test <- as.matrix(test_data[, -1])


#b
linear_mod <- lm(Apps ~ ., data = train_data)
linear_pred <- predict(linear_mod, newdata = test_data)
linear_rmse <- sqrt(mean((linear_pred - y_test)^2))
linear_mae <- mean(abs(linear_pred - y_test))

#c
ridge_mod <- cv.glmnet(x_train, y_train, alpha = 0)
best_lambda_ridge <- ridge_mod$lambda.min
ridge_pred <- predict(ridge_mod, s = best_lambda_ridge, newx = x_test)
ridge_rmse <- sqrt(mean((ridge_pred - y_test)^2))
ridge_mae <- mean(abs(ridge_pred - y_test))


#d
lasso_mod <- cv.glmnet(x_train, y_train, alpha = 1)
best_lambda_lasso <- lasso_mod$lambda.min
lasso_pred <- predict(lasso_mod, s = best_lambda_lasso, newx = x_test)
lasso_rmse <- sqrt(mean((lasso_pred - y_test)^2))
lasso_mae <- mean(abs(lasso_pred - y_test))
num_nonzero_coef <- sum(coef(lasso_mod, s = best_lambda_lasso) != 0)


#e
pcr_mod <- train(x_train, y_train, method = "pcr", tuneGrid = data.frame(ncomp = 1:10))
pcr_pred <- predict(pcr_mod, newdata = x_test)
pcr_rmse <- sqrt(mean((pcr_pred - y_test)^2))
pcr_mae <- mean(abs(pcr_pred - y_test))
best_M_pcr <- pcr_mod$bestTune$ncomp

#f
pls_mod <- train(x_train, y_train, method = "pls", tuneGrid = data.frame(ncomp = 1:10))
pls_pred <- predict(pls_mod, newdata = x_test)
pls_rmse <- sqrt(mean((pls_pred - y_test)^2))
pls_mae <- mean(abs(pls_pred - y_test))
best_M_pls <- pls_mod$bestTune$ncomp


# Question 11
# a
data(Boston)
# Best Subset Selection
best_fit <- regsubsets(crim ~ ., data=Boston, nbest=1, nvmax=13, method="exhaustive")
summary(best_fit)
# Lasso Regression
x <- as.matrix(Boston[, -1]) 
y <- Boston$crim
cv_fit <- cv.glmnet(x, y, alpha=1)
lasso_fit <- glmnet(x, y, alpha=1, lambda=cv_fit$lambda.min)
print(coef(lasso_fit))

#Ridge Regression
cv_fit_ridge <- cv.glmnet(x, y, alpha=0)
ridge_fit <- glmnet(x, y, alpha=0, lambda=cv_fit_ridge$lambda.min)
print(coef(ridge_fit))

# PCR
library(pls)
pcr_fit <- pcr(crim ~ ., data=Boston, scale=TRUE, validation="CV")
summary(pcr_fit)


#b
index <- createDataPartition(Boston$crim, p=0.8, list=FALSE)
train_data <- Boston[index, ]
test_data <- Boston[-index, ]

x_train <- as.matrix(train_data[-1])
y_train <- train_data$crim

x_test <- as.matrix(test_data[-1])
y_test <- test_data$crim

# Lasso Regression
cv_lasso <- cv.glmnet(x_train, y_train, alpha=1)
lasso_model <- glmnet(x_train, y_train, alpha=1, lambda=cv_lasso$lambda.min)

# Ridge Regression
cv_ridge <- cv.glmnet(x_train, y_train, alpha=0)
ridge_model <- glmnet(x_train, y_train, alpha=0, lambda=cv_ridge$lambda.min)

# PCR
cv_pcr <- train(crim ~ ., data=train_data, method="pcr", trControl=trainControl("cv", number=10))
pcr_model <- pcr(crim ~ ., data=train_data, ncomp=cv_pcr$bestTune$ncomp, validation="CV")

predictions_lasso <- predict(lasso_model, s=cv_lasso$lambda.min, newx=x_test)
predictions_ridge <- predict(ridge_model, s=cv_ridge$lambda.min, newx=x_test)
predictions_pcr <- predict(pcr_model, test_data)

rmse_lasso <- sqrt(mean((predictions_lasso - y_test)^2))
rmse_ridge <- sqrt(mean((predictions_ridge - y_test)^2))
rmse_pcr <- sqrt(mean((predictions_pcr - y_test)^2))

results <- data.frame(
  Model = c("Lasso", "Ridge", "PCR"),
  RMSE = c(rmse_lasso, rmse_ridge, rmse_pcr)
)
print(results)

