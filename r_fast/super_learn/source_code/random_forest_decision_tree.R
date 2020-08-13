library(caret)
library(tree)
rawdata <- read.csv(file='./rawdata/wine.csv', header = TRUE)

rawdata$Class <- as.factor(rawdata$Class)

str(rawdata)

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

treeRaw <- tree(Class ~.,
                data = train)
plot(treeRaw)
text(treeRaw)
cv_tree <- cv.tree(treeRaw, FUN=prune.misclass)

plot(cv_tree)

# 가지치기
prune_tree <- prune.misclass(treeRaw, best = 4)
plot(prune_tree)
text(prune_tree, pretty = 0)

pred <- predict(prune_tree, test, type = 'class')
confusionMatrix(pred, test$Class)


# RandomForest
ctrl <- trainControl(method = 'repeatedcv', repeats = 5)
rtFit <- train(Class ~.,
               data = train,
               method = 'rf',
               trControl = ctrl,
               preProcess = c('center', 'scale'),
               metric = 'Accuracy')
rtFit
plot(rtFit)

pred_test <- predict(rtFit, newdata = test)
confusionMatrix(pred_test, test$Class)

importance_rf <- varImp(rtFit, scale = FALSE)
plot(importance_rf)
