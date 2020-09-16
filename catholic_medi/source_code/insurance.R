library(tidyverse)
library(corrplot)
library(car)
insurance <- read.csv('./rawdata/insurance.csv', stringsAsFactors = TRUE)

names(insurance)
head(insurance)
str(insurance)
summary(insurance)

plot(insurance)

# correlation index
cor(insurance$age, insurance$bmi)
corrplot(corr = cor(insurance[, c('bmi', 'age')]), addCoef.col = TRUE)

# multiple regression
multiple_reg <- lm(formula = charges~., data = insurance)

# multicollinearity
vif(multiple_reg)

summary(multiple_reg)
anova(multiple_reg)

# prediction
newdata <- data.frame(age = 40, sex = 'female', bmi = 27,  children = 5,
                      smoker = 'yes', region = 'southwest')
predict(object = multiple_reg, newdata = newdata, interval = 'confidence')


# variable
forward <- step(object = multiple_reg, direction = 'forward')
formula(forward)

backward <- step(object = multiple_reg, direction = 'backward')
formula(backward)

stepwise <- step(object = multiple_reg, direction = 'both')
formula(stepwise)
