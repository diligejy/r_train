library(caret)

# 데이터 훈련 과정의 파라미터 설정
trainControl(
  method = 'repeatedcv', # cross-validation 반복
  number = 10, # 훈련 데이터 fold 갯수
  repeats = 5 # cv 반복횟수
)

# 모든 벡터 or 인자(factor) 조합인 데이터프레임 생성
expand.grid(k = 1:10)

# 머신러닝 알고리즘 이용해 모델 생성
train (
  class ~., # .은 all
  data = train,
  method = 'knn',
  trControl = trainControl(),
  preProcess = c("center", "scale"), # 표준화
  tuneGrid = expand.grid(k = 1:10),
  metric = "Accuracy"
)

rawdata <- read.csv(file = './rawdata/wine.csv', header = TRUE)
rawdata$Class <- as.factor(rawdata$Class)
str(rawdata)

# split data into train and test

analdata <- rawdata

set.seed(2020)
datatotal <- sort(sample(nrow(analdata), nrow(analdata)*0.7))
train <- rawdata[datatotal,]
test <- rawdata[-datatotal,]

train_x <- train[,1:13]
train_y <- train[,14]

test_x <- test[,1:13]
test_y <- test[,14]

# 모형 학습 
ctrl <- trainControl(method = 'repeatedcv',
                     number = 10, 
                     repeats = 5)
customGrid <- expand.grid(k = 1:10)
knnFit <- train(Class ~.,
                data = train,
                method = 'knn',
                trControl = ctrl,
                preProcess = c('center', 'scale'),
                tuneGrid = customGrid,
                metric = 'Accuracy')

knnFit
plot(knnFit)


# 예측 
pred_test <- predict(knnFit, newdata = test)
rs <- confusionMatrix(pred_test, test$Class)


# 변수 중요도 
importance_knn <- varImp(knnFit, scale = FALSE)
plot(importance_knn)
