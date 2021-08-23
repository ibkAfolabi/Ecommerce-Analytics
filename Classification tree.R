library(rpart)
library(rpart.plot)
bank.df <- read.csv("UniversalBank.csv")
bank.df <- bank.df[ , -c(1, 5)] # Drop ID and zip code columns.

#CODE FOR CREATING A DEFAULT CLASSIFICATION TREE

# partition
set.seed(1)
train.index <- sample(c(1:dim(bank.df)[1]), dim(bank.df)[1]*0.6)
train.df <- bank.df[train.index, ]
valid.df <- bank.df[-train.index, ]

# classification tree
default.ct <- rpart(Personal.Loan ~ ., data = train.df, method = "class")

# plot tree
prp(default.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10)

#CODE FOR CREATING A DEEPER CLASSIFICATION TREE

deeper.ct <- rpart(Personal.Loan ~ ., data = train.df, method = "class", cp = 0, minsplit = 1)

# count number of leaves
length(deeper.ct$frame$var[deeper.ct$frame$var == "<leaf>"])

# plot tree
prp(deeper.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10,
    box.col=ifelse(deeper.ct$frame$var == "<leaf>", 'gray', 'white'))

#CODE FOR TESTING ACCURACY 
# classify records in the validation data.
#set argument type = "class" in predict() to generate predicted class membership.
default.ct.point.pred.train <- predict(default.ct,train.df,type = "class")

#GENERATE CONFUSION MATRIX

#default tree: training
confusionMatrix(default.ct.point.pred.train, train.df$Personal.Loan)

#default tree: validation
confusionMatrix(default.ct.point.pred.valid, valid.df$Personal.Loan)

#deeper tree: training
confusionMatrix(deeper.ct.point.pred.train, train.df$Personal.Loan)

#deeper tree: validation
confusionMatrix(deeper.ct.point.pred.valid, valid.df$Personal.Loan)