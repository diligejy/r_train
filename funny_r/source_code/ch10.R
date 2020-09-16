library(compute.es)
library(car)
library(tidyverse)
library(multcomp)
library(pastecs)
library(WRS)

libido <- c(3, 2, 1, 1, 4, 5, 2, 4, 2, 3, 7, 4, 5, 3, 6)
dose <- gl(3, 5, labels = c("Placebo", "Low Dose", "High Dose"))
viagraData <- data.frame(dose, libido)

viagraData
by(viagraData$libido, viagraData$dose, stat.desc)
leveneTest(viagraData$libido, viagraData$dose, center = median)

# 주분석
viagraModel <- lm(libido~dose, data = viagraData)
viagraModel <- aov(libido ~ dose, data = viagraData)

summary(viagraModel)
plot(viagraModel)

oneway.test(libido ~dose, data = viagraData)  

viagraWide <- unstack(viagraData, libido ~dose)

# 절사평균 기반 분산분석
t1way(viagraWide)

# 중앙값 기반 분산분석
med1way(viagraWide)

# 절사평균 + 부트스트랩
t1waybt(viagraWide, tr = .05, nboot = 2000)

# 선형모형의 매개변수 요약
summary.lm(viagraModel)

contrasts(viagraData$dose) <- contr.helmert(3)
contrast1 <- c(-2, 1, 1)
contrast2 <- c(0, -1, 1)
contrasts(viagraData$dose) <- cbind(contrast1, contrast2)

viagraData$dose
viagraPlanned <- aov(libido ~ dose, data = viagraData)

summary.lm(viagraPlanned)

contrasts(viagraData$dose) <- contr.poly(3)

viagraTrend <- aov(libido ~ dose, data = viagraData)
summary.lm(viagraTrend)

pairwise.t.test(viagraData$libido, viagraData$dose, p.adjust.method = "bonferroni")
pairwise.t.test(viagraData$libido, viagraData$dose, p.adjust.method = "BH")
