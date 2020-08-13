library(caret)

rawdata <- read.csv(file = './rawdata/wine.csv')
rawdata$Class <- as.factor(rawdata$Class)
str(rawdata)

#split train-test 
analdata <- rawdata

set.seed(2020)
datatotal <- sort(sample(nrow(analdata), nrow(analdata)*.7))

train <- rawdata[datatotal,]
test <- rawdata[-datatotal,]

str(train)

train_x <- train[,1:13]
train_y <- train[,14]

test_x <- test[,1:13]
test_y <- test[,14]

ctrl <- trainControl(
                      method = 'repeatedcv',
                      repeats = 5
)

nbFit <- train(
                Class ~.,
                data = train,
                method = 'naive_bayes',
                trControl = ctrl,
                preProcess = c('center', 'scale'),
                metric = 'Accuracy'
)
nbFit
plot(nbFit)

pred_test <- predict(nbFit, newdata = test)
confusionMatrix(pred_test, test$Class)

importance_naive_bayes <- varImp(nbFit, scale = FALSE)
plot(importance_naive_bayes)
