library(tidyverse)
library(pastecs)
library(WRS)

spiderLong <- read.delim('./rawdata/ch9/SpiderLong.dat', header = TRUE)
spiderWide <- read.delim('./rawdata/ch9/SpiderWide.dat', header = TRUE)

spiderLong$Group <- factor(spiderLong$Group)
spiderLong$Group <- relevel(spiderLong$Group, "Picture")

ggplot(data = spiderLong, aes(x = Group, y= Anxiety)) +
  stat_summary(fun.data = mean_cl_normal(), geom = "pointrange")

spiderWide$pMean <- (spiderWide$picture + spiderWide$real)/2

grandMean <- mean(c(spiderWide$picture, spiderWide$real))

spiderWide$adj <- grandMean - spiderWide$pMean

spiderWide$picture_adj <- spiderWide$picture + spiderWide$adj
spiderWide$real_adj <- spiderWide$real + spiderWide$adj

lm(formula = Anxiety ~ Group, data = spiderLong)

# 독립 t검정
Group <- gl(2, 12, labels = c("Picture", "Real Spider"))
Anxiety <- c(30, 35, 45, 40, 50, 35, 55, 25, 30, 45, 40, 50, 40, 35, 50, 55, 65, 55, 50, 35, 30, 50, 60, 39)

spiderLong <- data.frame(Group, Anxiety)

ind.t.test <- t.test(Anxiety ~ Group, data = spiderLong)
ind.t.test

ind.t.test <- t.test(spiderWide$real, spiderWide$picture)
ind.t.test

# 독립 평균들의 강건한 비교방법
yuen(spiderWide$real, spiderWide$picture)

# 효과 크기 계산
t <- ind.t.test$statistic[[1]]
df <- ind.t.test$parameter[[1]]
r <- sqrt(t^2 / (t^2+df))
round(r,3)
