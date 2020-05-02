DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_cancer.csv', stringsAsFactors = F, na = '기록없음')

str(DF)

# 나이의 평균 구하기

mean(DF$age)

# 변수 특징 파악
summary(DF$age)

# 그래프로 아웃라이어 찾기
boxplot(DF$age, range = 1.5)
grid()

# IQR의 길이 알아내기
distIQR <- IQR(DF$age, na.rm = T)

# IQR의 위치 구하기
posIQR <- quantile(DF$age, probs = c(0.25, 0.75), na.rm = T)
posIQR

# IQR위치에서 1.5배 더한 위치를 구하기
DownWhisker <- posIQR[[1]] - distIQR * 1.5 # 25% 지점에서 IQR의 1.5배만큼 연장
UpWhisker <- posIQR[[2]] + distIQR * 1.5 # 75% 지점에서 IQR의 1.5배만큼 연장
DownWhisker;
UpWhisker

# 아웃라이어만 따로 저장
Outlier <- subset(DF, subset = (DF$age < DownWhisker | DF$age > UpWhisker))
Outlier
