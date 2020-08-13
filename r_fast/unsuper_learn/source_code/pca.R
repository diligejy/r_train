
head(iris)

# 결측치 확인
colSums(is.na(iris))

summary(iris)

boxplot(iris[, 1:4])

# pca 함수 적용 및 요약결과 확인
iris.pca <- prcomp(iris[1:4], center = T, scale = T)

summary(iris.pca)

# 각 주성분의 eigenvector
iris.pca$rotation

# 각 주성분의 값 
head(iris.pca$x, 10)

plot(iris.pca, type = 'l', main = 'Scree Plot')

# 차원 축소
head(iris.pca$x[, 1:2], 10)

# 2차원 시각화
library(ggfortify)
autoplot(iris.pca, data = iris, colour = 'Species')

library(jpeg)
cat <- readJPEG('./rawdata/cat.jpg')
class(cat)

# rgb 데이터 분할 및 주성분 분석
r <- cat[, , 1]
g <- cat[, , 2]
b <- cat[, , 3]

cat.r.pca <- prcomp(r, center = F)
cat.g.pca <- prcomp(g, center = F)
cat.b.pca <- prcomp(b, center = F)

rgb.pca <- list(cat.r.pca, cat.g.pca, cat.b.pca)

# 차원축소하여 jpg로 저장
pc <- c(2, 10, 50, 100, 300)
for (i in pc){
  pca.img <- sapply(rgb.pca, function(j){
    compressed.img <- j$x[, 1:i] %*% t(j$rotation[, 1:i]) # %*% 행렬곱
  }, simplify = 'array')
  writeJPEG(pca.img, paste('./output/cat_pca_', i, '.jpeg', sep = ''))
}
