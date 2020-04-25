a1 <- c(5, 3, 6, 3, 1)
is(a1)
a1 <- as.integer(a1)
is(a1)

b <- c(1.23, 6.63452, 4.34234)
b
is(b)
a2 <- c('짬뽕', '짜장면', '짬뽕', '짬뽕', '짜장면')
a2

a3 <- c(7, 3, 7, 5, 2, '짜장면')
a3
is(a3)
a2 <- as.factor(a2)
a2

a2 <- factor(a2, ordered = T)
a2

a5 <- factor(c('남', '여', '여', '남'), levels = c('남', '여', '소녀'))
a5

a1 <- c(5, 3, 6, 3, 1)
a1

a2 <- c('짬뽕', '짜장면', '짬뽕', '짬뽕', '짜장면')
a2

a3 <- c(3.62, 5.45, 2.54, 3.67, 7.23)
a3

DF <- data.frame(a1, a2, a3)
DF

DF <- data.frame(count = a1, food = a2, meanCount = a3)
DF

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')

DF
is.vector(DF$height)

str(DF)

DF$height

mean(DF$height)

Height <- DF$height
Height
DF[[7]]

DF[c(6, 7)]

DF[c('bloodtype', 'height')]
DF[,7]
DF[, 'height']
DF[,c(6, 7)]

attach(DF)

height

search()

subset(DF, usbset=(height > 170))

subset(DF, select=c(name, height), subset = (height > 180))

subset(DF, select = -height )
subset(DF, select = c(-height, -weight))

colnames(DF)

colnames(DF)[6] <- 'blood'
DF
Oldlist <- colnames(DF)
NewList <- c('na', 'se', 'ag', 'gr', 'ab', 'bl', 'he', 'we')
colnames(DF) <- NewList
DF

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')
BMI <- DF$weight/DF$height^2

BMI
DF <- cbind(DF, BMI)
DF

Omit <- read.csv('C:/Users/jinyoung/Pictures/example/omit.csv')
Omit

DF <- merge(DF, Omit, by = 'name')
DF

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')
AddCol <- data.frame(name= '이미리', sex = '여자', age = '24', grade = '4', absence = '무', bloodtype = 'A', height = 175.2, weight = 51)
AddCol
DF <- rbind(DF, AddCol)
DF

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')
a <- c(1:20)
s <- c('파스타', '짬뽕', '순두부찌개', '요거트 아이스크림', '커피')
L <- c(T, F, F, T, T, T)
List <- list(DF, a, s, L, mean)
List

List <- list(DataFrame = DF, Number = a, Character = s, Logic = L)
List
List['Number']
List[1]


List[c(2, 3)]
List[c('Number', 'Character')]
List$Number

names(List)[2] <- 'Num'
List[2]
names(List) <- c('Num', 'Cha', 'Log')
List

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')
HeightBySex <- split(DF$height, DF$sex)
HeightBySex

# 리스트 항목별 평균
mean(HeightBySex[[1]])
mean(HeightBySex[[2]])

# 한 번에 동일한 함수 적용
sapply(HeightBySex, mean)

#모든 항목의 표준편차 구하기
sapply(HeightBySex, sd)

#모든 항목의 범위 구하기
sapply(HeightBySex, range)

#혈액형을 나타내는 변수의 빈도수 구하기
Freq <- table(DF$bloodtype)

Freq
RelativeFreq <- prop.table(Freq)
RelativeFreq

Table <- rbind(Freq, RelativeFreq)
Table <- addmargins(Table, margin = 2)
Table
DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')

FactorOfHeight <- cut(DF$height, breaks = 4)
FactorOfHeight

FreqOfHeight <- table(FactorOfHeight)
FreqOfHeight
FreqOfHeight <- rbind(FreqOfHeight, prop.table(FreqOfHeight))
FreqOfHeight
rownames(FreqOfHeight)[2] <- 'RelativeFreq'
FreqOfHeight
CumuFreq <- cumsum(FreqOfHeight[2,])
CumuFreq

FreqOfHeight <- rbind(FreqOfHeight, CumuFreq)
FreqOfHeight
rownames(FreqOfHeight) <- c('도수', '상대도수', '누적도수')
FreqOfHeight
FreqOfHeight <- addmargins(FreqOfHeight, margin = 2)
FreqOfHeight

DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_studentlist.csv')

CT <- table(DF$sex, DF$bloodtype)
CT
#행과 열의 합 구하기
addmargins(CT)
# 상대도수 구하기
PropCT <- prop.table(CT)
PropCT

#상대도수 합 구하기
addmargins(PropCT)

# 남녀별로 상대도수 구하기
PropCT <- prop.table(CT, margin = 1)
PropCT <- prop.table(CT, margin = 2)
PropCT <- prop.table(CT)
PropCT

#상대도수 합 구하기기
addmargins(PropCT, margin = 2)


a <- c(1, 2, 3, 4, NA, 6, 7, 8, 9, 10)
a
complete.cases(a)

a <- a[complete.cases(a)]

a <- na.omit(a)
a
a
