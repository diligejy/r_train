DF <- mtcars

# 산점도 그리기기
plot(DF[, c(1:5)])
plot(DF[,c(6:11)])

# 원하는 그래프만 그리기
plot(DF$mpg ~ DF$disp)

# disp -> 배기량, mpg -> 연비

# 상관계수 구하기
cor(DF$mpg, DF$disp)

# mpg(연비) 자세히 살펴보기
summary(DF$mpg)
boxplot(DF$mpg)

hist(DF$mpg)

hist(DF$mpg, breaks = 10)

# disp(배기량) 알아보기 
boxplot(DF$disp)

hist(DF$disp)

hist(DF$disp, breaks = 20)

