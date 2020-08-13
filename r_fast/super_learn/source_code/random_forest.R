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
