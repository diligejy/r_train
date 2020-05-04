
# 데이터 로드
DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')

# 데이터 확인
head(DF)
str(DF)

# 기본 plot
plot(DF$age)

# 상관관계 파악하기
plot(DF$height, DF$weight)
plot(DF$weight ~ DF$height) # 두 가지 모두 같으나 이 방법은 정규식을 쓰며 종속변수 ~ 독립변수 적어주면 됨

# 명목형 변수와 수치형 변수의 관계계
plot(DF$height, DF$sex)
plot(DF$sex, DF$weight)

# plot에서 첫번째 인자가 x축, 두 번째 인자가 y축

# 특정 변수만 객체에 삽입
DF2 <- data.frame(DF$height, DF$weight)

plot(DF2)

# 변수 3개로 이루어진 데이터 프레임 시각화
DF3 <- cbind(DF2, DF$age)
head(DF3)

plot(DF3)

plot(DF)


# LEVEL별 그래프 보기
plot(DF$weight ~ DF$height, pch = as.integer(DF$sex))
legend('topleft', c('남', '여'), pch = DF$sex)


coplot(DF$weight ~ DF$height | DF$sex)

# ann = F로 함으로써 그래픽엔 아무 라벨도 안나옴
plot(DF$weight ~ DF$height, ann = FALSE) 
title(main = 'A대학 B학과생 몸무게와 키의 상관관계계')
title(xlab = '몸무게')
title(ylab = '키')

# 격자 추가
grid()

# 그래프에 선을 긋기
weightMean <- mean(DF$height)
abline(v = weightMean, color = 'red')

# 빈도수 나타내기
FreqBlood <- table(DF$bloodtype)
FreqBlood

barplot(FreqBlood)
title(main='혈액형별 빈도수')
title(xlab = '혈액형')
title(ylab = '빈도수')

# 
Height <- tapply(DF$height, DF$bloodtype, mean)
Height

barplot(Height, ylim = c(0, 200))

plot(DF$bloodtype)

boxplot(DF$height)

boxplot(DF$height ~ DF$bloodtype)

# hist
hist(DF$height)

# 막대 개수 바꾸고 싶다면 인자 추가
hist(DF$height, breaks = 10)
hist(DF$height, breaks = 10, prob = T)

lines(density(DF$height))

# 7간격 계급으로 만들기
BreakPoint <- seq(min(DF$height), max(DF$height) + 7, by = 7)
hist(DF$height, breaks = BreakPoint)

DiffPoint <- c(min(DF$height), 165, 170, 180, 185, 190)
hist(DF$height, breaks = DiffPoint)
hist(0)
# 한 화면에 여러 개 그래프그리기
par(mfrow = c(2, 3))
plot(DF$weight, DF$height)
plot(DF$sex, DF$height)
barplot(table(DF$bloodtype))
barplot(DF$height)
barplot(DF$height ~ DF$bloodtype)
hist(DF$height, breaks = 10)

par(mfrow = c(1, 1))

# 넘겨가며 그래프 보기
plot(DF$weight ~ DF$height + DF$age + DF$grade + DF$absence + DF$sex)

# 두 라인을 겹쳐 비교하는 그래프 그리기
TS1 <- c(round(runif(30) * 100))
TS1
TS2 <- c(round(runif(30) * 100))
TS2

TS1 <- sort(TS1, decreasing = F)
TS2 <- sort(TS2, decreasing = F)
TS1
TS2

plot(TS1, type = 'l')
lines(TS2, lty = 'dashed', col = 'red')

install.packages('ggplot2')
install.packages('ggthemes')

library('ggplot2')
library('ggthemes')

ggplot(data = diamonds, aes(x=caret, y = price, colour = clarity)) 
+ geom_point() + theme_wsj()
