library('ggplot2')
str(diamonds)

library('ggplot2')
library('ggthemes')

# 기본적 산점도 파악
ggplot(diamonds, aes(x = x, y = price)) + geom_point()

# 그래프 그리기
ggplot(diamonds, aes(x = x, y = price, colour = clarity)) + geom_point()

# 테마 적용
ggplot(diamonds, aes(x = x, y = price, colour = clarity)) + geom_point() + theme_solarized_2()

# alpha 값 조절
ggplot(diamonds, aes(x = x, y = price, colour = clarity)) + geom_point(alpha = 0.3) + theme_solarized_2() 

# legend만 alpha값이 1이 되도록
ggplot(diamonds, aes(x = x, y = price, colour = clarity)) + geom_point(alpha = 0.03)
+ guides(colour = guide_legend(override.aes = list(alpha = 1))) + theme_solarized_2()
