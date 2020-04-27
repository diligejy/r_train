DF <- read.csv('C:/Users/jinyoung/Pictures/example/example_cancer.csv')

str(DF)

DegreeOfAge <- table(cut(DF$age, breaks=(1:11)*10))
DegreeOfAge

# 열 값이름 바꾸기
rownames(DegreeOfAge) <- c('10s', '20s', '30s', '40s', '50s', '60s', '70s', '80s', '90s', '100s')
DegreeOfAge

library('ggplot2')
library('ggthemes')
ggplot(data=DF, aes(x=age)) + geom_freqpoly(binwidth=10, size=1.4, colour='orange') + theme_wsj()
