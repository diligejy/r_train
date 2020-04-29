library('data.table')

DF <- fread('C:/Users/jinyoung/Pictures/example/example_coffee.csv', header = T, stringsAsFactors = T, data.table = F )

# 사업장 규모 변수만 별도 객체에 저장
Size <- DF$sizeOfsite

# 자료의 특성 파악
summary(Size)

plot(Size)

# 아웃라이어 삭제 - NA만들기
Size[Size > 10000] <- NA

summary(Size)

# 0과 NA값 삭제
Size[Size == 0] <- NA
Size <- Size[complete.cases(Size)]
summary(Size)

# 20단위로 계급 만들기
DegreeOfSize <- table(cut(Size, breaks = (0:72)*20))
DegreeOfSize

# 그래프 그리기
library('ggplot2')
library('ggthemes')

ggplot(data = DF, aes(x=sizeOfsite)) + 
  geom_freqpoly(binwidth = 10, size = 1.2, colour = 'orange') +
  scale_x_continuous(limits = c(0, 300), breaks = seq(0, 300, 20)) + 
  theme_wsj()
