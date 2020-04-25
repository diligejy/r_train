install.packages('hflights')

library('hflights')

hflights

str(hflights)
# 특정 변수 살펴보기
CountOfDest <- table(hflights$Dest)
CountOfDest

# 명목형 변수 개수 세기
length(CountOfDest)

# 범위 살펴보기
range(CountOfDest)

# 최소값과 최대값의 이름 찾기
CountOfDest[CountOfDest == 1]
CountOfDest[CountOfDest == max(CountOfDest)]

# 6000횟수가 넘는 공항 찾기
SelectedDest <- CountOfDest[CountOfDest > 6000]
SelectedDest

# 6000횟수가 넘는 공항들의 전체 합 구하기
addmargins(SelectedDest, margin = 1)

barplot(SelectedDest)
