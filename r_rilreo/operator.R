# 연산자 ----
# 1. 산술 연산자 ----

# 2. 할당 연산자 ----
x <- rnorm(n = 100, mean = 0, sd = 2)
rnorm(n = 100, mean = 10, sd = 1) -> y

# 3. 비교 연산자 ----
3 > 4
!(3 == 4)
iris[(iris$Sepal.Length > 5) & (iris$Sepal.Width > 3.6), ]
iris[(iris$Sepal.Length > 5) | (iris$Sepal.Width > 3.6), ]
