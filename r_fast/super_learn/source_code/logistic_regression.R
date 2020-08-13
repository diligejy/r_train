library(caret)

rawdata <- read.csv(file = './rawdata/heart.csv', header = TRUE)
str(rawdata)

# 타겟 클래스 범주화
rawdata$target <- as.factor(rawdata$target)
unique(rawdata$target)

# 연속형 독립변수 표준화
rawdata$age <- scale(rawdata$age)
rawdata$trestbps <- scale(rawdata$trestbps)
rawdata$chol <- scale(rawdata$chol)
rawdata$thalach <- scale(rawdata$thalach)
rawdata$oldpeak <- scale(rawdata$oldpeak)
rawdata$slope <- scale(rawdata$slope)

# 범주형 독립변수 as factor
newdata <- rawdata
factorVar <- c('sex', 'cp', 'fbs', 'restecg', 'exang', 'ca', 'thal')
newdata[, factorVar] = lapply(newdata[ , factorVar], factor)

# 트레이닝 테스트 나누기
set.seed(2020)
datatotal <- sort(sample(nrow(newdata), nrow(newdata) * 0.7))
train <- newdata[datatotal, ]
test <- newdata[-datatotal,]

train_x <- train[, 1:12]
train_y <- train[, 13]

test_x <- test[, 1:12]
test_y <- test[, 13]

# LogitBoost
ctrl <- trainControl(method = 'repeatedcv', repeats = 5)
logitFit <- train(
                  target ~., 
                  data = train,
                  method = "LogitBoost",
                  trControl = ctrl,
                  metric = 'Accuracy'
)
logitFit

plot(logitFit)

pred_test <- predict(logitFit, newdata = test)
confusionMatrix(pred_test, test$target)

importance_logit <- varImp(logitFit, scale = FALSE)
plot(importance_logit)
