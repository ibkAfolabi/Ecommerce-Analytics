# Multiple Linear Regression

# Importing the dataset
dataset = read.csv('Preprocessed Internal Data.csv')

# Encoding categorical data

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Total_Amount, SplitRatio = 0.6)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set = scale(training_set)
test_set = scale(test_set)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Total_Amount ~ .,
               data = training_set)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)