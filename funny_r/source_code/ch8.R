library(tidyverse)
library(car)
library(mlogit)

eelData <- read.delim('./rawdata/ch8/eel.dat', header = TRUE)

head(eelData)
eelData$Cured <- factor(eelData$Cured)
eelData$Cured <- relevel(eelData$Cured, "Not Cured")
eelData$Intervention <- factor(eelData$Intervention)
eelData$Intervention <- relevel(eelData$Intervention, "No Treatment")

eelModel.1 <- glm(Cured ~ Intervention, data = eelData, family = binomial())

eelModel.2 <- glm(Cured ~ Intervention + Duration, data = eelData, family = binomial())

summary(eelModel.1)
summary(eelModel.2)

modelChi <- eelModel.1$null.deviance - eelModel.1$deviance
modelChi

chidf <- eelModel.1$df.null - eelModel.1$df.residual
chidf

chisq.prob <- 1 - pchisq(modelChi, chidf)
chisq.prob

R2.hl <- modelChi / eelModel.1$null.deviance
R2.hl

# 콕스-스넬 통계량
R.cs <- 1 - exp((eelModel.1$deviance - eelModel.1$null.deviance) / 113)
R.cs

# 네이글커크 측도
R.n <- R.cs / (1- (exp( - (eelModel.1$null.deviance / 113))))
R.n

# 로지스틱 회귀 도구 담기
logisticPseudoR2s <- function(LogModel){
  dev <- LogModel$deviance
  nullDev <- LogModel$null.deviance
  modelN <- length(LogModel$fitted.values)
  R.l <-  1- dev / nullDev
  R.cs <- 1 - exp(- (nullDev - dev) / modelN)
  R.n <- R.cs / (1 - (exp (-(nullDev / modelN))))
  cat("Pseudo R^2 for logistic regression\n")
  cat("Hosmer and Lemeshow R^2    ", round(R.l, 3), "\n")
  cat("Cox and Snell R^2          ", round(R.cs, 3), "\n")
  cat("Nagelkerke R^2             ", round(R.n, 3), "\n")
}
logisticPseudoR2s(eelModel.1)

eelModel.1$coefficients

# 모형 예측변수들에 대한 승산비
exp(eelModel.1$coefficients)
exp(confint(eelModel.1))

# 모형 간 이탈도 차이
modelChi <- eelModel.1$deviance - eelModel.2$deviance
# 자유도 차이
chidf <- eelModel.1$df.residual - eelModel.2$df.residual
# p값
chisq.prob <- 1 - pchisq(modelChi, chidf)

modelChi
chidf
chisq.prob

anova(eelModel.1, eelModel.2)

eelData$predicted.probabilities <- fitted(eelModel.1)
eelData$standardized.residuals <- rstandard(eelModel.1)
eelData$studentized.residuals <- rstudent(eelModel.1)
eelData$dfbeta <- dfbeta(eelModel.1)
eelData$dffit <- dffits(eelModel.1)
eelData$leverage <- hatvalues(eelModel.1)

head(eelData[, c("Cured", "Intervention", "Duration", "predicted.probabilities")])


write.table(eelData, './output/Eel With Diagnostics.dat', sep = '\t', row.names = FALSE)

eelData[, c("leverage", "studentized.residuals", "dfbeta")]

# 다중 공선성 검정
penaltyData <- read.delim("./rawdata/ch8/penalty.dat", header = TRUE)

penaltyData$Scored <- factor(penaltyData$Scored)
penaltyData$Scored <- relevel(penaltyData$Scored, "Missed Penalty")

penaltyModel.2 <- glm(Scored ~ Previous + PSWQ + Anxious, data = penaltyData, family = binomial())

vif(penaltyModel.2)
1/vif(penaltyModel.2)

# 로짓의 선형성 검사
penaltyData$logPSWQInt <- log(penaltyData$PSWQ) * penaltyData$PSWQ

penaltyData

pentaltyTest.1 <- glm(Scored ~ PSWQ + Anxious + Previous + logPSWQInt + logAnxInt + logPrevInt, data = penaltyData, family = binomial())

# 다중 로지스틱 회귀분석
chatData <- read.delim("./rawdata/ch8/Chat-Up Lines.dat", header = TRUE)
head(chatData)

chatData$Success <- factor(chatData$Success)
chatData$Gender <- factor(chatData$Gender)

chatData$Gender <- relevel(chatData$Gender, ref = 2)

mlChat <- mlogit.data(chatData, choice = "Success", shape = "wide")
head(mlChat)

chatModel <- mlogit(Success ~ l | Good_Mate + Funny + Gender + Sex + Gender:Sex + Funny:Gender, data = mlChat, reflevel = 3)
