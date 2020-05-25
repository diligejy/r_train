# foreign 패키지 설치
install.packages('foreign')

# 패키지 로드
library(foreign)
library(dplyr)
library(ggplot2)

# 데이터 로드
raw_welfare <- read.spss('data_spss_Koweps2014.sav', to.data.frame = T)

# 데이터 copy

welfare <- raw_welfare

# 데이터 검토
dim(welfare)
str(welfare)
head(welfare)
summary(welfare)

dim(welfare)

# 변수명 수정
welfare <- rename(welfare,
                  sex = h0901_4,
                  birth = h0901_5,
                  income = h09_din)
welfare$sex

# 변수 검토 및 정제 - 성별
class(welfare$sex)

summary(welfare$sex)

table(welfare$sex)

# 항목 이름 부여 
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)

qplot(welfare$sex)

# 남자가 많은 이유 - 가구주의 남자 빈도가 더 많기 때문 

class(welfare$income)

summary(welfare$income)
qplot(welfare$income) + xlim(0, 10000)

# 정제
table(is.na(welfare$income))

# 성별 소득 평균표 생성
sex_income <- welfare %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income

ggplot(sex_income, aes(x = sex, y = mean_income)) + geom_col()
