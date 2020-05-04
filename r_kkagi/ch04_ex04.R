DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_cancer.csv', stringsAsFactors = T, na = '기록없음')
str(DF)

par(mfrow = c(1,1))
# 날짜 빼고 나머지로 그리기
plot(DF[-5])

# 서엽ㄹ로 나눠서 탐색하기
par(mfrow = c(1, 4))
plot(age~sex, data = DF, main = 'age')
plot(height~sex, data = DF, main = 'height')
plot(weight~sex, data = DF, main = 'weight')
plot(hospitalization~sex, data = DF)

# 몸무게의 이상치를 제거하고 비교하기
DF3 <- DF
qnt <- quantile(DF3$weight, probs = c(0.25, 0.75), na.rm = T)
H <- 1.5 * IQR(DF$weight, na.rm = T)
DF3$weight[DF3$weight < (qnt[1] - H)] <- NA
DF3$weight[DF3$weight > (qnt[2] + H)] <- NA

# 이상치를 제거한 데이터와 비교
par(mfrow = c(2,4))
hist(DF3$weight, breaks = 100)
plot(weight ~ diseaseCode, data = DF3)
plot(weight ~ cancerStaging, data = DF3)
plot(weight~age, data = DF3)
hist(DF$weight, breaks = 100)
plot(weight ~ diseaseCode, data = DF)
plot(weight ~ cancerStaging, data = DF)
plot(weight~age, data = DF)

#입원일수 이상치를 제거하고 비교
DF4 <- DF
qnt <- quantile(DF4$hospitalization, probs = c(0.25, 0.75), na.rm = T)
H <- 1.5 * IQR(DF4$hospitalization, na.rm = T)
DF4$hospitalization[DF4$hospitalization < (qnt[1] - H)] <- NA
DF4$hospitalization[DF4$hospitalization > (qnt[2] + H)] <- NA

# 이상치가 제거된 데이터로 확인
par(mfrow = c(2, 4))
hist(DF4$hospitalization, breaks = 100)
plot(hospitalization ~ diseaseCode, data = DF4)
plot(hospitalization ~ cancerStaging, data = DF4)
plot(hospitalization ~ age, data = DF4)

hist(DF$hospitalization, breaks = 100)
plot(hospitalization ~ diseaseCode, data = DF)
plot(hospitalization ~ cancerStaging, data = DF)
plot(hospitalization ~ age, data = DF)

# 입원 일수만 따로 정렬을 해서 보기
par(mfrow = c(1, 1))
plot(DF$hospitalization[order(DF$hospitalization)])

plot(DF$hospitalization[order(DF$hospitalization)], xlim = c(18200, 18500))

# 90일 이상 입원한 환자에 대한 자료
DF5 <- subset(DF, subset = (hospitalization > 90))
dim(DF5)

library('data.table')
# 모집단과 비교 
prop.table(table(DF5$sex))

prop.table(table(DF$sex))

# 질병 코드 별 비교
par(mfrow = c(2, 1))
plot(prop.table(table(DF5$diseaseCode)))
plot(prop.table(table(DF$diseaseCode)))

# 암병기도 비교
plot(prop.table(table(DF5$cancerStaging)))
plot(prop.table(table(DF$cancerStaging)))

# 최종암병기 IV값만 그래프로 그리기
DF6 <- subset(DF, subset = (DF$cancerStaging = "IV"))
