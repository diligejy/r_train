library(car)
library(compute.es)
library(effects)
library(tidyverse)
library(multcomp)
library(pastecs)
library(WRS)

viagraData <- read.delim("./rawdata/ch11/ViagraCovariate.dat", header = TRUE)


libido <- c(3, 2, 5, 2, 2, 2, 7, 2, 4, 7, 5, 3, 4, 4, 7, 5, 4, 9, 2, 6, 3, 4, 4, 4, 6, 4, 6, 2, 8, 5)
partnerLibido <- c(4, 1, 5, 1, 2, 2, 7, 4, 5, 5, 3, 1, 2, 2, 6, 4, 2, 1, 3, 5, 4, 3, 3, 2, 0, 1, 3, 0, 1, 0)
dose <- c(rep(1, 9), rep(2,8), rep(3, 13))

dose <- factor(dose, levels = c(1:3), labels = c("Placebo", "Low Dose", "High Dose"))
dose

viagraData <- data.frame(dose, libido, partnerLibido)

viagraData
head(viagraData)

viagraData %>% 
  group_by(dose) %>% 
  summarise(libido_mean = mean(libido),
            partnerLibido_mean = mean(partnerLibido)) %>% 

viagraData %>% 
  group_by(dose) %>% 
  ggplot(viagraData, aes(x = dose, y = libido)) +
  geom_boxplot()

ggplot(data = viagraData, aes(x = dose, y = libido)) + geom_boxplot(outlier.shape=16, outlier.size=2, notch=FALSE)
ggplot(data = viagraData, aes(x = dose, y = partnerLibido)) + geom_boxplot()

leveneTest(viagraData$libido, viagraData$dose, center = median)

head(viagraData)

viagraData %>% 
  group_by(dose) %>% 
  summarise(libido_sd = sd(libido),
            partnerLibido_sd = sd(partnerLibido))

viagraAovModel <- aov(libido ~ dose, data = viagraData)
summary.lm(viagraAovModel)

viagraModel <- aov(libido ~dose + partnerLibido, data = viagraData)
summary(viagraModel)
viagraModel <- aov(libido ~partnerLibido + dose, data = viagraData)
summary(viagraModel)

# 대비설계 & 제3종 제곱합
contrasts(viagraData$dose) <- cbind(c(-2, 1, 1), c(0, -1, 1))
viagraModel <- aov(libido ~ partnerLibido + dose, data = viagraData)
Anova(viagraModel, type = "III")

# 수정평균
adjustedMeans <- effect("dose", viagraModel, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

summary.lm(viagraModel)

# 산점도
ggplot(data = viagraData, aes(x = libido, y = partnerLibido)) +
  geom_point() +
  stat_smooth(method = 'lm')

# 사후검정
postHocs <- glht(viagraModel, linfct = mcp(dose = "Tukey"))
summary(postHocs)
confint(postHocs)

plot(viagraModel)
# 그룹별 리비도 수준 일원 분산분석
model = aov(libido ~ dose, data = viagraData)
summary(model)



