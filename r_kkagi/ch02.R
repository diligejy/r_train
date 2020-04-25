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
