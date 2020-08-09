
head(mtcars)
dim(mtcars)

# check the distribution of the target
plot(mtcars$mpg)
abline(h = mean(mtcars$mpg), lty = 2)
abline(h = median(mtcars$mpg), lty = 3, col = 'blue')

# 평균과 중위수가 일치하지 않는다면 대칭 분포가 아님
# (= Skewed)

plot(sort(mtcars$mpg))
abline(h=mean(mtcars$mpg), lty=2)
abline(h=median(mtcars$mpg), lty=3, col="blue")

plot(sort(mtcars$mpg, decreasing=T))
abline(h=mean(mtcars$mpg), lty=2)
abline(h=median(mtcars$mpg), lty=3, col="blue")

# 분포의 히스토그램과 밀도플롯
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10)
abline(v = mean(mtcars$mpg), lty = 2)
abline(v = median(mtcars$mpg), lty = 3, col = 'blue')


hist(mtcars$mpg, breaks = 10, prob = T)
lines(density(mtcars$mpg), lwd = 2)
polygon(density(mtcars$mpg), col = rgb(0, 0, 0.5, 0.5))
abline(v = mean(mtcars$mpg), lty = 2)
abline(v = median(mtcars$mpg), lty = 3, col = 'blue')

# target과의 상관계수 확인
barplot(cor(as.matrix(mtcars[,1]), as.matrix(mtcars[, -1])))

# drat = Rear axle Ratio

# scatter plot
plot(mtcars$wt, mtcars$mpg)
abline(lm(mtcars$mpg~mtcars$wt), col = 'red', lty = 2)

cor(mtcars$wt, mtcars$mpg)
cor.test(mtcars$wt, mtcars$mpg)

# add locally-weighted polynomial regression smoothing
lines(lowess(mtcars$mpg~mtcars$wt), col = 'blue', lty = 3)


# 선형 관계 아님 -> 분포 전환 필요

# scatter plot (Y ~ X1 + X2)

# 두 x변수들 사이의 관계 확인
plot(mtcars$wt, mtcars$drat)

# 두 변수들과 target 관계 확인
plot(mtcars$wt, mtcars$drat,
     col = ifelse(mtcars$mpg>quantile(mtcars$mpg, .7), "red", "blue"),
     main = "mpg by wt and drat")

plot(mtcars$wt, mtcars$drat,
     col = ifelse(mtcars$mpg>quantile(mtcars$mpg, .7), "red", "blue"),
     main = "mpg by wt and drat",
     pch = 19, cex = 1.2,
     xlim = c(0, max(mtcars$wt)),
     ylim = c(0, max(mtcars$drat)),
     xlab = 'weight', ylab = 'Rear axle ratio(drat)')
grid(5)
lines(lowess(mtcars$drat~mtcars$wt),
      lty = 3, lwd = 2)

# continuous coloring

# UDF for standarize anomaly score
# 스코어의 스케일을 0~1사이로 변환하기 위한 사용자 정의 함수 
stnd <- function(x){
  x1 <- (x-min(x)) / (max(x) - min(x))
  return(x1)
}

plot(mtcars$wt, mtcars$drat,
     col = rgb(stnd(mtcars$mpg), 0, 1-stnd(mtcars$mpg)),
     pch = 19, cex = 1.2,
     xlim = c(0, max(mtcars$wt)),
     ylim = c(0, max(mtcars$drat)),
     xlab = "weight",
     ylab = "Rear axle ratio(drat)")
grid(5)
lines(lowess(mtcars$drat~mtcars$wt),
      lty = 3, lwd = 2)

# give transparency
plot(mtcars$wt, mtcars$drat,
     col = rgb(stnd(mtcars$mpg), 0, 1-stnd(mtcars$mpg), 0.5),
     pch = 19, cex = 1.2,
     xlim = c(0, max(mtcars$wt)),
     ylim = c(0, max(mtcars$drat)),
     xlab = "weight",
     ylab = "Rear axle ratio(drat)")
grid(5)
lines(lowess(mtcars$drat~mtcars$wt),
      lty = 3, lwd = 2)

# show the car names
text(mtcars$wt, mtcars$drat, labels = row.names(mtcars),
     cex = 0.5, pos = 2)

# To find anomaly data
plot(sort(mtcars$mpg))
abline(h = c(12, 30), lty = 3)

plot(mtcars$wt, mtcars$drat,
     col = rgb(stnd(mtcars$mpg), 0, 1-stnd(mtcars$mpg), 0.5),
     pch = 19, cex = 1.2,
     xlim = c(0, max(mtcars$wt)),
     ylim = c(0, max(mtcars$drat)),
     xlab = "weight",
     ylab = "Rear axle ratio(drat)")
grid(5)
lines(lowess(mtcars$drat~mtcars$wt),
      lty = 3, lwd = 2)

text(mtcars$wt, mtcars$drat,
     labels = ifelse(mtcars$mpg>30 | mtcars$mpg < 12, row.names(mtcars), ""),
     cex = 0.8, pos = 2)
