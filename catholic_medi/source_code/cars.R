library(tidy)

data(cars)

head(cars)
plot(x = cars$speed, y = cars$dist)

names(cars)
head(cars)
str(cars)
summary(cars)

# simple regression
abline(reg = lm(dist~speed, data = cars))

simple_reg <- lm(formula = dist~speed, data = cars)
summary(simple_reg)
anova(simple_reg)

#prediction
predict(object = simple_reg,
        newdata = data.frame(speed = 30),
        interval = 'confidence')

