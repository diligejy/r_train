# n : 뽑고싶은 숫자개수
# p : parameter
n <- 10
p <- 1/3


rbernoulli <- function(n, p){
  random_num0to1 <- runif(n)
  result <- rep(0, n)
  result[random_num0to1 < p] <- 1
  return(result)
}

rbernoulli(10, 1/3)
