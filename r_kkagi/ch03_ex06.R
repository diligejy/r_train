DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_salary.csv', stringsAsFactors = T, na = '-')

head(DF, 5)

# 변수명 바꾸기
colnames(DF)

colnames(DF) <- c('age', 'salary', 'specialSalary', 'workingTime', 'numberOfWorker', 'career', 'sex')

str(DF)

# 검색 목록에 data.frame을 올리기

detach(DF)
attach(DF)

# 평균 구하기 
Mean <- mean(salary, na.rm = T)
Mean

# 중앙값 구하기
Mid <- median(salary, na.rm = T)
Mid

# 범위 구하기
Range <- range(salary, na.rm = T)
Range

w <- which(DF$salary == 4064286)
DF[w,]

# 사분위 구하기
Qnt <- quantile(salary, na.rm = T)
Qnt

# 모두 모아 리스트에 담기
Salary <- list(평균월급 = Mean, 중앙값월급 = Mid, 월급범위 = Range, 월급사분위 = Qnt)
Salary


# 2019년 데이터로 테스트
DF <- read.csv('C:/Users/jinyoung/Pictures/example/ch03_ex06.csv', stringsAsFactors = T, na = '-', header = T)
DF

head(DF, 5)
str(DF)

DF <- DF[2:23, ]
head(DF, 5)
str(DF[2:23, ])

DF <- DF[, 3:length(DF)]
head(DF, 5)

colnames(DF) <- c('sex', 'age', 'career', 'totalWorkingTime', 'salary', 'specialSalary', 'numberOfWorker')
head(DF, 5)

# row index 재설정
row.names(DF) <- NULL

head(DF,5)
DF <- DF[-c(1, 12), ]
head(DF, 5)
row.names(DF) <- NULL

DF$career <- as.double(DF$career)
DF$totalWorkingTime <- as.double(DF$totalWorkingTime)
DF$salary <- as.double(DF$salary)
DF$specialSalary <- as.double(DF$specialSalary)
DF$numberOfWorker <- as.double(DF$numberOfWorker)
str(DF)

head(DF)
# 평균 구하기 
Mean <- mean(DF$salary, na.rm = T)
Mean

# 중앙값 구하기
Mid <- median(DF$salary, na.rm = T)
Mid

# 범위 구하기
Range <- range(DF$salary, na.rm = T)
Range

w <- which(DF$salary == 4064286)
DF[w,]

# 사분위 구하기
Qnt <- quantile(DF$salary, na.rm = T)
Qnt

# 모두 모아 리스트에 담기
Salary <- list(평균월급 = Mean, 중앙값월급 = Mid, 월급범위 = Range, 월급사분위 = Qnt)
Salary
