df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

# 결측치 확인하기
is.na(df)

# 결측치 빈도 출력
table(is.na(df$sex))

# 결측치 포함한 상태로 분석
mean(df$score)

sum(df$score)

# 결측치 있는 행 제거하기
library(dplyr)

# score가 NA인 데이터만 출력
df %>% filter(is.na(score))

# sex, score 결측치 제거

df %>% 
  filter(!is.na(score) & !is.na(sex))

# 결측치가 하나라도 있으면 제거하기 - 분석에 필요한 데이터까지 손실될 가능성 유의
df_nomiss2 <- na.omit(df)
df_nomiss2

# 함수의 결측치 제외 기능 이용 - na.rm = T
mean(df$score, na.rm = T)

sum(df$score, na.rm = T)


# summarise()에서 na.rm = T 사용하기
# 결측치 생성
exam <- read.csv('csv_exam.csv')
exam[c(3, 8, 15), "math"] <- NA

# 평균 구하기
exam %>% 
  summarise(mean_math = mean(math))

# 결측치 제외 평균 산출
exam %>% 
  summarise(mean_math = mean(math, na.rm = T))


# 평균으로 대체하기
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

# 
mpg <- as.data.frame(ggplot2::mpg)
# NA할당
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

table(is.na(mpg$drv))
table(is.na(mpg$hwy))

mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
