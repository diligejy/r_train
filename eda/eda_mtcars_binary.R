
head(mtcars, 3)
mtc <- mtcars

# V엔진은 파워는 강하지만 효율은 낮음
mtc$vsc <- ifelse(mtc$vs == 0, "V", "Straight")

plot(mtc$vsc, mtc$mpg)
boxplot(mtc$mpg~mtc$vsc)

# v엔진이 1인 정수로 변환
mtc$vsnum <- ifelse(mtc$vsc == "V", 1, 0)

# 기본 플롯
plot(mtc$vsnum, mtc$mpg)

# 정리된 플롯
plot(jitter(mtc$vsnum), mtc$mpg,
     pch = 19, cex = 1.5,
     col = rgb(mtc$vsnum, 0, 1-mtc$vsnum, 0.6))

abline(lm(mtc$mpg~mtc$vsnum))
