install.packages('dplyr')
library(dplyr)

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

# 복사본 만들기
df_new <- df_raw
df_new

# 변수명 바꾸기
df_new <- rename(df_new, v2 = var2)
df_new



mpg <- as.data.frame(ggplot2::mpg)
mpg_copy <- mpg
mpg_copy <- rename(mpg_copy, city = cty)
mpg_copy <- rename(mpg_copy, highway = hwy)
head(mpg_copy)
