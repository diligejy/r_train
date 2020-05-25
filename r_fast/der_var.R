df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

#create derived variable 
df$var_sum <- df$var1 + df$var2
df

df$var_mean <-  (df$var1 + df$var2) / 2
df

#mpg 통합 연비 변수 만들기
mpg$total <- (mpg$cty + mpg$hwy) /2 
head(mpg)

#조건문을 활용해 파생변수 만들기
summary(mpg$total)

hist(mpg$total)

mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail')

head(mpg)

# 빈도표로 합격 판정 자동차 수 살펴보기
table(mpg$test)

# 막대 그래프로 빈도 표현하기
library(ggplot2)
qplot(mpg$test)

# 중첩 조건문 활용하기 - 연비 등급 변수 만들기

mpg$grade <- ifelse(mpg$total >= 30, 'A',
                    ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)

table(mpg$grade)
qplot(mpg$grade)

midwest <- as.data.frame(ggplot2::midwest)

dim(midwest)
str(midwest)
summary(midwest)
head(midwest)

library(dplyr)
midwest <- rename(midwest, total = poptotal)
midwest

midwest <- rename(midwest, asian = popasian)

midwest$asia_per <- midwest$asian / midwest$total

hist(midwest$asia_per)
mean_asia_per <-mean(midwest$asia_per)

midwest$asia_large_small <- ifelse(midwest$asia_per > mean_asia_per, "large", "small")

library(ggplot2)
table(midwest$asia_large_small)
qplot(midwest$asia_large_small)
