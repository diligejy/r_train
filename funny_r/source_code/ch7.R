library(car)
library(boot)
library(QuantPsyc)
library(tidyverse)
album1 <- read.delim('./rawdata/ch7/Album Sales 1.dat', header = TRUE)

albumSales.1 <- lm(sales ~ adverts, data = album1)

# 단순회귀분석의 해석
summary(albumSales.1)

sqrt(0.3346)

album2 <- read.delim('./rawdata/ch7/Album Sales 2.dat')

albumSales.2 <- lm(sales ~adverts, data = album2)
albumSales.3 <- lm(sales ~ adverts + airplay + attract, data = album2)

summary(albumSales.2)
summary(albumSales.3)

lm.beta(albumSales.3)

confint(albumSales.3)

anova(albumSales.2, albumSales.3)

album2$standardized.residuals <- rstandard(albumSales.3)
album2$studentized.residuals <- rstudent(albumSales.3)
album2$cooks.distance <- cooks.distance(albumSales.3)
album2$dfbeta <- dfbeta(albumSales.3)
album2$dffit <- dffits(albumSales.3)
album2$leverage <- hatvalues(albumSales.3)
album2$covariance.ratios <- covratio(albumSales.3)


head(album2)

write.table(album2, "./output/Album Sales With Diagnostics.dat", sep = "\t", row.names = FALSE)

album2$standardized.residuals > 2 | album2$standardized.residuals < -2
album2$large.residual <- album2$standardized.residuals > 2 | album2$standardized.residuals < -2

sum(album2$large.residual)

album2[album2$large.residual, c("sales", "airplay", "attract", "adverts", "standardized.residuals")]

album2[album2$large.residual, c("cooks.distance", "leverage", "covariance.ratios")]

durbinWatsonTest(albumSales.3)

vif(albumSales.3)
1/vif(albumSales.3)
mean(vif(albumSales.3))

hist(album2$studentized.residuals)

album2$fitted <- albumSales.3$fitted.values

histogram <- ggplot(album2, aes(studentized.residuals)) + 
  theme(legend.position = "none") +
  geom_histogram(aes(y = ..density..), colour = "black", fill = "white") +
  labs(x = "Studentized Residual", y = "Density") 

histogram + stat_function(fun = dnorm, args = list(mean = mean(album2$studentized.residuals, na.rm = TRUE), sd = sd(album2$studentized.residuals, na.rm = TRUE)), colour = "red", size = 1)

qqplot.resid <- qplot(sample = album2$studentized.residuals) + stat_qq() + labs(x = "Theoretical Values", y = "Observed Values")

# 스튜던트화 잔차 대 예측값의 산점도
scatter <- ggplot(album2, aes(album2$fitted, album2$studentized.residuals))
scatter + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs(x = "Fitted Values", y = "Studentized Residual")

hist(rstudent(albumSales.3))

bootReg <- function(formula, data, indices){
  d <- data[indices, ]
  fit <- lm(formula, data = d)
  return(coef(fit))
}

bootResults <- boot(statistic = bootReg, formula = sales ~ adverts + airplay + attract, data = album2, R = 2000)
boot.ci(bootResults, type = "bca", index = 1)
boot.ci(bootResults, type = "bca", index = 2)
boot.ci(bootResults, type = "bca", index = 3)
boot.ci(bootResults, type = "bca", index = 4)

gfr <- read.delim(file = "./rawdata/ch7/GlastonburyFestivalRegression.dat", header = TRUE)

contrasts(gfr$music) <- contr.treatment(4, base = 4)



crusty_v_NMA <- c(1, 0, 0, 0)
indie_v_NMA <- c(0, 1, 0, 0)
metal_v_NMA <- c(0, 0, 1, 0)

contrast(gfr$music) <- contr.treatment(4, base = 4)

glastonburyModel <- lm(change ~ music, data = gfr)
summary(glastonburyModel)



