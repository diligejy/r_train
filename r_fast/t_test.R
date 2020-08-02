rawN3 <- read.csv('C:/Users/jinyoung/Pictures/r/fc_part4/Data/htest01.csv', header = TRUE)
rawN3

groupA <- rawN3[rawN3$group=='A', 1:2]
groupB <- rawN3[rawN3$group=='B', 1:2]

# 각 집단의 평균 구해서 비교
mean(groupA[,2])
mean(groupB[,2])

# 정규성 검정
shapiro.test(groupA[,2])

qqnorm(groupA[,2])
qqline(groupA[,2])

# 분산 동질성 검정
var.test(groupA[,2], groupB[,2])

# T-TEST
# alternative == 'less' -> 대립가설에서 왼쪽값이 오른쪽값보다 작다는 뜻
t.test(groupA[,2], groupB[,2], alternative = 'less', val.equal = TRUE)

# 각 집단 샘플 사이즈 = 10(소표본)
rawN10 <- read.csv(file = 'C:/Users/jinyoung/Pictures/r/fc_part4/Data/htest02.csv', header = TRUE)

# 집단 분류
groupA2 <- rawN10[rawN10$group=='A', 1:2]
groupB2 <- rawN10[rawN10$group=='B', 1:2]


# 각 집단 평균
mean(groupA2[,2])
mean(groupB2[,2])

# 정규성 검정
shapiro.test(groupA2[,2])
qqnorm(groupA2[,2])
qqline(groupA2[,2])

shapiro.test(groupB2[,2])
qqnorm(groupB2[,2])
qqline(groupB2[,2])

# 분산 동질성 검정
var.test(groupA2[,2], groupB2[,2])

# T-test
t.test(groupA2[,2], groupB2[,2], alternative = 'less', var.equal = FALSE)