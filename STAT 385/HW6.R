# STAT 385: HW 6
# Yelizaveta Semikina

install.packages("gbm")
library(readr)
library(dplyr)
library(caret)
library(randomForest)
library(gbm)
library(rpart)

data <- read.csv("/Users/liza/Desktop/results_2021.csv")

# Convert categorical variables to factors
data$country <- as.factor(data$country)
data$country_name <- as.factor(data$country_name)
data$region <- as.factor(data$region)
data$income_group <- as.factor(data$income_group)

# Replace zeros with NA in specific columns if zero represents missing data
cols_to_replace <- c("curr_cc_prev", "curr_mort_prev", "curr_cost", "curr_cost_prev")
data[cols_to_replace] <- lapply(data[cols_to_replace], function(x) ifelse(x == 0, NA, x))

# Function to calculate mode for a categorical column
get_mode <- function(v) {
  uniqv <- unique(na.omit(v))
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Replace NA's with the mode for categorical columns
categorical_cols <- c("country", "country_name", "region", "income_group")
data[categorical_cols] <- lapply(data[categorical_cols], function(x) ifelse(is.na(x), get_mode(x), x))

# Replace NA's with the mean for numeric columns
numeric_cols <- sapply(data, is.numeric)
data[numeric_cols] <- lapply(data[numeric_cols], function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))

# Summary of cleaned data
summary(data)

# Split the data into training and test sets
set.seed(123) # for reproducibility
splitIndex <- createDataPartition(data$current_net_cost, p = 0.8, list = FALSE)
training <- data[splitIndex, ]
testing <- data[-splitIndex, ]

# Linear Regression Model
lm_model <- lm(current_net_cost ~ ., data = training)

# Regression Tree Model
tree_model <- rpart(current_net_cost ~ ., data = training, method = "anova")

# Bagging Model
bag_model <- train(current_net_cost ~ ., data = training, method = "treebag")

# Random Forest Model
rf_model <- randomForest(current_net_cost ~ ., data = training)

# Boosting Model
boost_model <- gbm(current_net_cost ~ ., data = training, distribution = "gaussian", n.trees = 5000, interaction.depth = 4)

# Modified Predict and Evaluate Function
predict_and_evaluate <- function(model, test_data, actual, n.trees = NULL) {
  if (!is.null(n.trees) && inherits(model, "gbm")) {
    predictions <- predict(model, test_data, n.trees = n.trees)
  } else {
    predictions <- predict(model, test_data)
  }
  return(RMSE(predictions, actual))
}

# Evaluate all models
rmse_lm <- predict_and_evaluate(lm_model, testing, testing$current_net_cost)
rmse_tree <- predict_and_evaluate(tree_model, testing, testing$current_net_cost)
rmse_bag <- predict_and_evaluate(bag_model, testing, testing$current_net_cost)
rmse_rf <- predict_and_evaluate(rf_model, testing, testing$current_net_cost)
rmse_boost <- predict_and_evaluate(boost_model, testing, testing$current_net_cost, n.trees = 5000)

# Print RMSE for each model
cat("RMSE for Linear Regression:", rmse_lm, "\n")
cat("RMSE for Regression Tree:", rmse_tree, "\n")
cat("RMSE for Bagging:", rmse_bag, "\n")
cat("RMSE for Random Forest:", rmse_rf, "\n")
cat("RMSE for Boosting:", rmse_boost, "\n")
