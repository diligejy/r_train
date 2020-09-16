library(tidyverse)
library(psych)
library(pastecs)
library(car)
library(Hmisc)
library(ggm)
library(polycor)
library(boot)

# 상관분석
examData <- read.delim('./rawdata/Exam Anxiety.dat')

cor(examData$Exam, examData$Anxiety, use = 'complete.obs', method = 'pearson')

cor(examData$Exam, examData$Anxiety, use = 'complete.obs', method = 'kendall')

cor(examData$Exam, examData$Anxiety, use = 'complete.obs', method = 'kendall')

cor.test(examData$Exam, examData$Anxiety, method = 'pearson')
cor.test(examData$Exam, examData$Anxiety, alternative = 'less', method = 'pearson')

cor.test(examData$Exam, examData$Anxiety, alternative = 'less', method = 'pearson', conf.level = 0.99)

examData2 <- examData[, c('Exam', 'Anxiety', 'Revise')]
cor(examData2)

cor(examData[, c('Exam', 'Anxiety', 'Revise')])

examMatrix <- as.matrix(examData[, c('Exam', 'Anxiety', 'Revise')])

head(rcorr(examMatrix))

examMatrix

Hmisc::rcorr(examMatrix)

cor.test(examData$Anxiety, examData$Exam)
cor(examData2)^2

# 스피어먼 상관계수
liarData <- read.delim('./rawdata/The Biggest Liar.dat', header = TRUE)

head(liarData)
cor(liarData$Position, liarData$Creativity, method = 'spearman')

# 상관계수의 유의확률 구하기
liarMatrix <- as.matrix(liarData[, c('Position', 'Creativity')])
rcorr(liarMatrix)

cor.test(liarData$Position, liarData$Creativity, alternative = 'less', method = 'spearman')

cor(liarData$Position, liarData$Creativity, method = 'kendall')

cor.test(liarData$Position, liarData$Creativity, alternative = 'less', method = 'kendall')

bootTau <- function(liarData, i){
  cor(liarData$Position[i], liarData$Creativity[i], 
      use = 'complete.obs', method = 'kendall')
}

boot_kendall <- boot(liarData, bootTau, 2000)
boot_kendall
boot.ci(boot_kendall)

# 이연상관과 점이연 상관
catData <- read.csv('./rawdata/pbcorr.csv', header = TRUE)

catData

cor.test(catData$time, catData$gender)
cor.test(catData$time, catData$recode)

catFrequencies <- table(catData$gender)
prop.table(catFrequencies)

polyserial(catData$time, catData$gender)

# 편상관분석
examData <- read.delim('./rawdata/Exam Anxiety.dat', header = TRUE)
examData2 <- examData[, c('Exam', 'Anxiety', 'Revise')]

pc <- pcor(c('Exam', 'Anxiety', 'Revise'), var(examData2))
pc
pc^2

pcor.test(pc, 1, 103)
