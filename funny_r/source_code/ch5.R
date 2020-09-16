library(tidyverse)
library(psych)
library(pastecs)
library(car)
library(Hmisc)
library(ggm)
library(polycor)
library(boot)

dlf <- read.delim('./rawdata/DownloadFestival(No Outlier).dat', header = TRUE)

hist.day1 <- ggplot(dlf, aes(day1)) +
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..),
                 colour = 'black', fill = 'white') + 
  labs(x = 'Hygiene score on day 1', y = 'density')

hist.day1

hist.day1 + stat_function(fun = dnorm, args = list(mean = mean(dlf$day1, na.rm = TRUE), sd = sd(dlf$day1, na.rm = TRUE)), colour = 'black', size = 1)

describe(dlf$day1)
describe(cbind(dlf$day1, dlf$day2, dlf$day3))

rexam <- read.delim('./rawdata/RExam.dat', header = TRUE)

rexam$uni <- factor(rexam$uni, levels = c(0:1), labels = c('Duncetown University', 'Sussex University'))

head(rexam)

ggplot(rexam, aes(exam)) +
  geom_histogram(aes(y = ..density..),
                 colour = 'black', fill = 'white') +
  labs(x = 'Score of Exam', y = 'Count')

ggplot(rexam, aes(computer)) +
    theme(legend.position = 'none') +
    geom_histogram(aes(y = ..density..),
                 colour = 'black', fill = 'white') +
  stat_function(fun = dnorm, args = list(mean = mean(rexam$computer, na.rm = TRUE), sd = sd(rexam$computer, na.rm = TRUE)), colour = 'black', size = 1)

describe(rexam)

# 그룹별 분석
by(data = rexam$exam, INDICES = rexam$uni, FUN = describe)

by(rexam$exam, rexam$uni, describe)
by(rexam$exam, rexam$uni, stat.desc)

by(rexam$exam, rexam$uni, stat.desc, basic = FALSE, norm = TRUE)

by(cbind(data = rexam$exam, data = rexam$numeracy), rexam$uni, describe)
by(rexam[, c('exam', 'numeracy')], rexam$uni, stat.desc, basic = FALSE, norm = TRUE)


dunceData <- subset(rexam, rexam$uni == 'Duncetown University')
sussexData <- subset(rexam, rexam$uni == 'Sussex University')

hist.numeracy.duncetown <- ggplot(dunceData, aes(numeracy)) +
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black', binwidth = 1) +
  labs(x = 'Numeracy Score', y = 'Density') +
  stat_function(fun = dnorm, args = list(mean = mean(dunceData$numeracy, na.rm = TRUE), sd = sd(dunceData$numeracy, na.rm = TRUE)), colour = 'blue', size = 1)

hist.numeracy.duncetown

hist.exam.duncetown <- ggplot(dunceData, aes(exam)) + 
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black', binwidth = 1) +
  labs(x = 'Exam Score', y = 'Density') +
  stat_function(fun = dnorm, args = list(mean = mean(dunceData$exam, na.rm = TRUE), sd = sd(dunceData$exam, na.rm = TRUE)), colour = 'blue', size = 1)

hist.exam.duncetown  

hist.lectures.duncetown <- ggplot(dunceData, aes(lectures)) +
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black',
                 binwidth = 1) +
  labs(x = 'Exam Score', y = 'Density') +
  stat_function(fun = dnorm, args = list(mean = mean(dunceData$lectures)), colour = 'blue', size = 1)

hist.lectures.duncetown

# Shapiro-wilk test 
shapiro.test(rexam$exam)
shapiro.test(rexam$numeracy)

by(rexam$exam, rexam$uni, shapiro.test)
by(rexam$numeracy, rexam$uni, shapiro.test)

ggplot(rexam, aes(sample=exam)) + stat_qq()
ggplot(rexam, aes(sample=numeracy)) + stat_qq()

# 레빈 검정 - 
leveneTest(rexam$exam, rexam$uni)
leveneTest(rexam$exam, rexam$uni, center = mean)

leveneTest(rexam$numeracy, rexam$uni)

# R을 이용한 로그변환
dlf$logday1 <- log(dlf$day1 + 1)
dlf$logday2 <- log(dlf$day2 + 1)
dlf$logday3 <- log(dlf$day3 +1)


ggplot(dlf, aes(logday1)) +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black') +
  theme(legend.position = 'none') + 
  labs(x = 'day1 (with log transform)', y = 'density') +
  stat_function(fun = dnorm, args = list(mean = mean(dlf$day1, na.rm = TRUE), sd = sd(dlf$day1, na.rm = TRUE)), colour = 'blue', size = 1)

# R을 이용한 제곱근 변환
dlf$sqrtday1 <- sqrt(dlf$day1)


ggplot(dlf, aes(sqrtday1)) +
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black') +
  labs(x = 'day1 with sqrt transform', y = 'density') +
  stat_function(fun = dnorm, args = list(mean = mean(dlf$sqrt, na.rm = TRUE), sd = sd(dlf$sqrtday1, na.rm = TRUE)), colour = 'blue', size = 1)



# 역수변환
dlf$recday1 <- 1/(dlf$day1 + 1)
ggplot(dlf, aes(recday1)) +
  theme(legend.position = 'none') +
  geom_histogram(aes(y = ..density..), fill = 'white', colour = 'black') +
  labs(x = 'day1 with reverse transform', y = 'density') +
  stat_function(fun = dnorm, args = list(mean = mean(dlf$recday1, na.rm = TRUE), sd = sd(dlf$recday1, na.rm = TRUE)), colour = 'blue', size = 1)


# ifelse 함수
dlf$day1NoOutlier <- ifelse(dlf$day1 > 4, NA, dlf$day1)

# 연습문제
cf <- read.delim('./rawdata/ChickFlick.dat')

head(cf)

# 정규성 검정
shapiro.test(cf$arousal)

cf$film <- factor(cf$film)
ggplot(cf, aes(sample = arousal)) + stat_qq()

leveneTest(cf$arousal, cf$film)

