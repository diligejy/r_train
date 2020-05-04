
library('ggplot2')
DF <- diamonds
str(DF)

# 관측치 중 일부만 담기 
Sample <- DF[sample(nrow(DF), 300),]
head(Sample)

# price의 boxplot
boxplot(DF$price)

# price와 관련된 그래프만 그리기
par(mfrow = c(3, 3))
plot(Sample$price ~., data = Sample)

tapply(DF$price, DF$cut, mean)

# caret, x, y, z의 산점도를 그리기
par(mfrow = c(2,2))
plot(DF$price ~ DF$carat+x+y+z)