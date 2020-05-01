DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_population.csv')
str(DF)

head(DF)

# 문자열 정리를 위해 외부 패키지 설치
install.packages('stringr')
library('stringr')

# '('를 기준으로 나눠서 앞 문자열만 사용
temp <-  str_split_fixed(DF[,1], "\\(", 2)

head(temp, 10)

# 공백을 기준으로 시와 구를 나누기
NewCity <- str_split_fixed(temp[,1], ' ', 2)
head(NewCity, 10)

# 변수 이름 바꾸기
colnames(NewCity) <- c('Provinces', 'City')

# 작업한 변후들을 합치기
DF <- data.frame(NewCity, DF[, c(2:7)])
head(DF, 10)

# city 값 중 빈 곳을 NA로 바꾸기
DF[DF == ' '] <- NA
head(DF, 10)

DF <- DF[complete.cases(DF), ]
head(DF, 10)

# Factor 변수를 수치형 변수로 변경
for(i in 3:9){
  DF[,i] <- sapply(DF[,i], function(x) gsub(',', '', x))
  DF[,i] <- as.character(DF[,i])
  DF[,i] <- as.numeric(DF[,i])
}

