# 1. Vector의 개념 ----
# 하나의 열(column)로 구성되어 있음. 1차원 구조.
# 하나의 데이터 유형만 가질 수 있음
# 데이터 분석의 가장 기본 단위

# 2. Vector 만들기 ----
# 2.1 하나의 값을 가지는 Vector ----

x1 <- 10
x2 <- "Lee"

# 2.2 2개 이상의 값을 가지는 Vector ----
# (1) c(element1, element2, ....)
# c : concatenate, combine의 약자
# numeric vector, character vector, logical vector, complex vector 만들 수 있음


# element들 간에는 어떤 규칙이 없을 때 주로 사용
age <-c(10, 20, 47, 13)
gender <- c('m', 'm', 'f', 'm')


# (2) start:end

# (3) seq(from = , to = , by = )
# :의 확장
# numeric vector만 만들 수 있음
# 모든 증가 또는 모든 감소 표현 가능능

# from : start
# to : end
# by : 증감폭 

# (4) rep(vector, times = , each = )
# vector를 복사하는 기능
# rep : replicate의 약자, 복사하다
rep(1, times = 10)
rep(1, each = 10)
rep(1:2, each = 10)
rep(1:2, times = 10)
rep(c('A', 'B', 'C'), times = 3)
rep(c('A', 'B', 'C'), each = 3)

c('A', 10, FALSE)

# 3. Vector 데이터 유형의 우선순위 ----
# Character > Numeric > Logical 
c('A', 10, FALSE)