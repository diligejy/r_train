library(dplyr)
exam <- read.csv('csv_exam.csv')
exam

# exam에서 class가 1인 경우만 추출하여 출력
exam %>% filter(class == 1)
exam %>% filter(math > 50)
exam %>% filter(class == 1 & math >= 50)

# %in% 기호 이용하기
# 1, 3, 5반에 해당하면 추출
exam %>% filter(class %in% c(1, 3, 5))

# 추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)


mpg <- as.data.frame(ggplot2::mpg)
str(mpg)
dim(mpg)
head(mpg)
View(mpg)

displ_4 <- mpg %>% filter(displ <= 4)
displ_5 <- mpg %>% filter(displ >= 5)

mean(displ_4$hwy)
mean(displ_5$hwy)

audi <- mpg %>% filter(manufacturer == 'audi')
toyota <- mpg %>% filter(manufacturer == 'toyota')

mean(audi$cty)
mean(toyota$cty)

chev_ford_honda <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))

mean(chev_ford_honda$hwy)

exam %>% select(math)

# dplyr 함수 조합하기
# class가 1인 행만 추출한 다음 english 추출
exam %>%
  filter(class == 1) %>%
  select(english)

# 일부만 출력하기
exam %>% 
  select(id, math) %>% 
  head

# 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)

mpg_class_cty <- mpg %>% select(class, cty)

head(mpg_class_cty)

suv <- mpg_class_cty %>% filter(class == "suv")
compact <- mpg_class_cty %>% filter(class == 'compact')

mean(suv$cty)
mean(compact$cty)

# 오름차순으로 정렬하기
exam %>% arrange(math)

# 내림차순으로 정렬하기
exam %>% arrange(desc(math))

# 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)

audi <- mpg %>% filter(manufacturer == 'audi')

head(audi %>% arrange(desc(hwy)),5)

mpg %>% 
  filter(manufacturer == 'audi') %>% 
  arrange(desc(hwy)) %>% 
  head(5)

# 파생변수 추가 - mutate

exam %>% 
  mutate(total = math + english + science) %>% 
  head

exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

# 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(total) %>% 
  head

# 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)

mpg_copy <- mpg

mpg %>% 
  mutate(cty_hwy = cty + hwy) %>% 
  mutate(mean_cty_hwy = cty_hwy / 2) %>% 
  arrange(desc(mean_cty_hwy)) %>% 
  head(3)


# 집단별로 요약하기
exam %>% summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))


exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

# 각 집단별로 다시 집단 나누기
mpg %>% 
  group_by(manufacturer, drv) %>% # 회사별, 구방방식별 분리
  summarise(mean_cty = mean(cty)) %>% 
  head(10)





# 혼자서 해보기
mpg %>%  
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% 
  filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

# 가로로 합치기
# 중간 고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

# id 기준으로 합치기
total <- left_join(test1, test2, by = "id")
total

# 반별 담임교사 명단 생성
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

# class 기준 합치기
exam_new <- left_join(exam, name, by = 'class')
exam_new

# 세로로 합치기
# 학생 1~5번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

# 학생 6~10번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

# 세로로 합치기
group_all <- bind_rows(group_a, group_b)
group_all

fuel <- data.frame(f1 = c('c', 'd', 'e', 'p', 'r'),
                   price_f1 = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel

mpg <- as.data.frame(ggplot2::mpg)
mpg <- left_join(mpg, fuel, by = "price_f1")


# 분석 도전 데스
midwest <- as.data.frame(ggplot2::midwest)

midwest %>% 
  mutate(youth_per_total = ((poptotal- popadults) / poptotal) * 100) %>% 
  arrange(desc(youth_per_total)) %>% 
  select(county, youth_per_total) %>% 
  head(5)

midwest <- midwest %>% 
  mutate(youth_per_total = ((poptotal- popadults) / poptotal) * 100) 

midwest <- midwest %>% 
  mutate(class_youth_per_total = ifelse(youth_per_total >= 40, "large", ifelse(youth_per_total >= 30, "middle", "small")))

table(midwest$class_youth_per_total)
qplot(midwest$class_youth_per_total)

midwest %>% 
  mutate(asian_per_total = (popasian / poptotal) * 100) %>% 
  select(state, county, asian_per_total) %>% 
  arrange(asian_per_total) %>% 
  head(10)
