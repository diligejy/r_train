library(tidyverse)
library(dplyr)

df <- read.csv('./rawdata/Wholesale customers data.csv')


head(df)

df$Channel <- df$Channel %>% as.factor() #범주형 데이터 팩터로 변경
df$Region <- df$Region %>% as.factor()

# 결측치 확인
colSums(is.na(df))

summary(df)

boxplot(df[, 3:ncol(df)])

# 지수표기법 변경
options(scipen = 100)
boxplot(df[, 3:ncol(df)])

# 이상치 제거
temp <- NULL
for (i in 3:ncol(df)){
  temp <- rbind(temp, df[order(df[, i], decreasing = T),] %>% slice(1:5))
}

temp %>% 
  arrange(Fresh) %>% 
  head() #중복 있음

temp <- distinct(temp) #중복 제거
df.rm.outlier <- anti_join(df, temp) #df에서 temp제거 

# 이상치 제거 후 박스플롯 확인
par(mfrow = c(1, 2))
boxplot(df[,3:ncol(df)])
boxplot(df.rm.outlier[, 3:ncol(df)])


# k 군집 개수 설정(Elbow method)
library(factoextra)
set.seed(1234)
fviz_nbclust(df.rm.outlier[, 3:ncol(df.rm.outlier)], kmeans, method = 'wss', k.max = 15) +
  theme_minimal() + 
  ggtitle('Elbow Method')

# Silhouette method
fviz_nbclust(df.rm.outlier[, 3:ncol(df.rm.outlier)], kmeans, method = 'silhouette', k.max = 15) + 
  theme_minimal() + 
  ggtitle('Silhouette Plot')

# k-means 모델 생성
df.kmeans <- kmeans(df.rm.outlier[, 3:ncol(df.rm.outlier)], centers = 5, iter.max = 1000)
df.kmeans

# 군집별 평균치 시각화
barplot(t(df.kmeans$centers), beside = TRUE, col = 1:6)
legend("topleft", colnames(df[, 3:8]), fill = 1:6, cex = 0.5)

# rawdata에 cluster 할당
df.rm.outlier$cluster <- df.kmeans$cluster
head(df.rm.outlier)

library(jpeg)
img <- readJPEG('./rawdata/cat.jpg')
class(img)

imgdim <- as.vector(dim(img))
imgRG
    B = as.vector(img[,,3])
  
head(imgRGB)
kClusters <- c(3, 5, 10, 15, 30, 50) # 축소할 색상 클러스터 개수

set.seed(1234)
for (i in kClusters){
  img.kmeans <- kmeans(imgRGB[, c('R', 'G', 'B')], centers = i)
  img.result <- img.kmeans$centers[img.kmeans$cluster, ]
  img.array <- array(img.result, dim = imgdim)
  writeJPEG(img.array, paste('./output/kmeans_', i, 'cluters.jpeg', sep = ''))
}
  
  
  
