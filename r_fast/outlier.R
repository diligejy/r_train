# 이상치 제거하기 - 1. 존재할 수 없는 값

outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))

outlier

# 이상치 확인하기
table(outlier$sex)
table(outlier$score)

# 결측 처리하기 - sex
# sex가 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

# score가 1~5아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

# 결측치 제외하고 분석
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

# 상자 그림으로 극단치 기준 정해서 제거
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

# 상자그림 통계치 출력
boxplot(mpg$hwy)$stats

# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외하고 분석
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

# 혼자서 해보기

mpg <- as.data.frame(ggplot2::mpg)
# drv, cty이상치 할당
mpg[c(10, 14, 58, 93), "drv"] <- "k" 
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

library(dplyr)
table(mpg$drv)

mpg$drv <- ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)

# 이상치 확인

table(mpg$drv)

# 상자그림
boxplot(mpg$cty)$stats

# 9 - 26 벗어나면 NA 할당
mpg$cty <- ifelse(mpg$cty < 9 | mpg > 26, NA, mpg$cty)

boxplot(mpg$cty)


mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean_cty = mean(cty))

