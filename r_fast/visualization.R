library(ggplot2)

# 배경 설정 하기
ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 범위를 조정하는 설정 추가 
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)

# 혼자서 해보기
ggplot(data = mpg, aes(x = cty, y = hwy)) + 
  geom_point()

ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + 
  xlim(0, 500000) +
  ylim(0, 10000)


# 막대 그래프 - 평균 막대 그래프 만들기

library(dplyr)

# 평균표 만들기
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg
# 그래프 생성성
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + 
  geom_col()

# 크기 순서로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + 
  geom_col()

# 막대그래프 2 - 빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + 
  geom_bar()

# x축 연속변수, y축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

df_suv <- mpg %>% 
  filter(class == 'suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

df_suv

ggplot(data = df_suv, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()

ggplot(data = mpg, aes(x = class)) + geom_bar()

# 시계열 그래프 만들기
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 혼자서 해보기
ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line()

# 상자그림 만들기
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

class_mpg <- mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = class_mpg, aes(x = class, y = cty)) + 
  geom_boxplot()






