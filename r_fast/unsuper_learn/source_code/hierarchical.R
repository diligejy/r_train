
df <- USArrests
head(df)

# 결측치 확인
colSums(is.na(df))

summary(df)

boxplot(df)

# 표준화
library(tidyverse)
library(dplyr)
df <- scale(df) %>%  as.data.frame()
boxplot(df)

# 이상치 제거

df.rm.outlier <- df %>% rownames_to_column('rname') %>% 
  arrange(desc('Rape')) %>% 
  slice(-1:-2) %>% 
  column_to_rownames('rname')
boxplot(df.rm.outlier)

# 유사도 행렬 생성(유클리드 거리)
df.dist <- dist(df.rm.outlier, method = 'euclidean')

# 군집 구성 방식 선택 
df.hclust.sing <- hclust(df.dist, method = 'single')
df.hclust.cplt <- hclust(df.dist, method = 'complete')
df.hclust.avg <- hclust(df.dist, method = 'average')
df.hclust.cent <- hclust(df.dist, method = 'centroid')
df.hclust.ward <- hclust(df.dist, method = 'ward.D2')

# dendrogram생성 및 군집화
plot(df.hclust.sing, cex = 0.6, hang = -1)
rect.hclust(df.hclust.sing, k = 4, border = 2:5)

plot(df.hclust.cplt, cex = 0.6, hang = -1)
rect.hclust(df.hclust.cplt, k = 4, border = 2:5)

# raw data에 cluster 할당
df.clusters <- cutree(df.hclust.ward, k = 4)
table(df.clusters)

df.rm.outlier$cluster <- df.clusters
head(df.rm.outlier)


# 2차원 시각화
library(factoextra)
fviz_cluster(list(data = df.rm.outlier[, 1:ncol(df.rm.outlier)-1], cluster = df.clusters))

# 군집별 평균치 확인 및 시각화
library(reshape2)
temp <- df.rm.outlier %>% 
  melt(id = 'cluster')
head(temp)

df.means <- dcast(temp, cluster ~ variable, mean)
df.means

barplot(t(df.means[,-1]), beside = TRUE, col = 1:4, names.arg = c(1:4))
legend('topright', colnames(df.rm.outlier[1:4]), fill = 1:4, cex = 0.5)
