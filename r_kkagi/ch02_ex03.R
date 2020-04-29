# 전국 커피숍 폐업 영업 현황황

library('data.table')
library('ggplot2')

DF <- fread('C:/Users/jinyoung/Pictures/example/example_coffee.csv', header = T, stringsAsFactors = T, data.table = F )

str(DF)

#최초 커피숍 찾기
range(DF$yearOfStart, na.rm = T)

subset(DF, subset=(yearOfStart == 1964))

# 해마다 오픈한 커피숍 개수 찾기
table(DF$yearOfStart)

# 막대그래프로 그리기
qplot(yearOfStart, data = DF, geom = 'bar', binwidth = 1)

# 영업상태 및 연도에 따른 분할표 만들기
Freq <- table(DF$stateOfbusiness, DF$yearOfStart)
Freq

# 1997년도 이상 데이터만 저장
which(colnames(Freq) == '1997')
which.max(colnames(Freq))
Freq <- Freq[,c(30:47)]

# 비율 살펴보기
PFreq <-  prop.table(Freq, margin = 2)
PFreq

# 새로운 데이터프레임으로 자료 모으기
NewDF <- data.frame(colnames(Freq), Freq[1, ], Freq[2,], PFreq[1,], PFreq[2,])
NewDF

# 행과 이름 정렬
rownames(NewDF) <- NULL # 연도가 변수에 있으니 삭제
colnames(NewDF) <- c('Time', 'Open', 'Close', 'POpen', 'PClose')

NewDF

# 라인 그래프 그리기

ggplot(NewDF, aes(x = factor(Time), y = Close, group = 1)) + 
  geom_line(colour = 'steelblue1', size = 1) + 
  geom_point(colour = 'steelblue', size = 3) + 
  geom_line(aes(y=Open), colour = 'tomato2', size = 1) +
  geom_point(aes(y=Open), colour = 'red', size = 6) + 
  theme_bw()
