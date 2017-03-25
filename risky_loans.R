#identify the risky loans

#load the data set
credit <- read.csv("~/credit.csv")

#split data into training and testing
set.seed(123)
train_sample <- sample(1000,900)
credit_train <- credit[train_sample,]
credit_test <- credit[-train_sample,]

#create cost matrix
matrix_dimensions <- list(c("no","yes"), c("no","yes"))
names(matrix_dimensions) <- c("predicted","actual")
error_cost <- matrix(c(0,1,4,0), nrow = 2, dimnames = matrix_dimensions)

#training data
library(C50)
credit_train$default <- as.factor(credit_train$default)
credit_cost <- C5.0(credit_train[,-17], credit_train$default,costs = error_cost)
credit_cost_predict <- predict(credit_cost, credit_test)

#evaluation of model
library(gmodels)
CrossTable(credit_test$default, credit_cost_predict, prop.chisq = F, prop.c = F, prop.r = F, dnn = c('actual','predicted'))
