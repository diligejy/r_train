
# 마케팅에 따른 판매액 차이
raw_d <- read.csv(file = 'C:/Users/jinyoung/Pictures/r/fc_part4/Data/htest02d.csv', header = TRUE)

groupAd <- raw_d[,1]
groupBd <- raw_d[,2]

# 각 집단의 평균
mean(groupAd)
mean(groupBd)

# 귀무가설 : 마케팅을 통해 판매액 변화 없음
# 대립가설 : 마케팅을 통해 판매액이 증가함
