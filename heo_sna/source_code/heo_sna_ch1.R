library(sna)

A <- matrix(c(0, 1, 1, 0, 1,
              0, 0, 1, 0, 0,
              1, 0, 0, 1, 0,
              0, 0, 0, 0, 0,
              1, 0, 0, 0, 0), byrow = T, nrow = 5)
rownames(A) <- c('M1', 'M2','M3', 'M4', 'M5')
colnames(A) <- c('M1', 'M2','M3', 'M4', 'M5')

A.1 <- matrix(0, 5, 5)
edge.list <- matrix(
                  c(1, 2,
                    1, 3,
                    1, 5,
                    2, 3,
                    3, 1,
                    3, 4,
                    5, 1))
A.1[edge.list] <- 1
rownames(A.1) <- c('M1', 'M2', 'M3', 'M4', 'M5')
colnames(A.1) <- c('M1', 'M2', 'M3', 'M4', 'M5')

A.1

gplot(A, displaylabels = T, boxed.labels = F, vertex.cex = 2, arrowhead.cex = 2)

A2 <- A %*% A
A3 <- A2 %*% A
A4 <- A3 %*% A 
A5 <- A4 %*% A

D <- geodist(A)$gdist
apply(D, 1, sum)
apply(D, 2, sum)

D <- geodist(A)$gdist
D

gden(A)

set.seed(123)
network.3 <- rgraph(10, tprob = 0.2)

gplot(network.3, displaylabels = T, boxed.labels = F, vertex.cex = 2, arrowhead.cex =  2)
components(network.3)
network.3

component.dist(network.3)

# small world simulation
library(sna)
n <- 10
N <- n * (n + 1)
mu <- 5
world.n <- rgraph(n+1, tprob = mu/n)
D.n <- geodist(world.n)$gdist
diag(D.n) <- NA
median(D.n, na.rm = T)
addmargins(round(table(D.n)/ N * 100, 1))

# 연습문제
B <- matrix(c(0, 1, 1, 0, 1,
              1, 0, 1, 0, 0,
              1, 1, 0, 1, 0,
              0, 0, 1, 0, 0,
              1, 0, 0, 0, 0), byrow = T, nrow = 5)

degree(B)
degree(B, cmode = 'indegree')
degree(B, cmode = 'outdegree')

gden(B)

components(B)
component.dist(B)
gplot(B, displaylabels = T, boxed.labels = F, vertex.cex = 1, arrowhead.cex = 1)

#2 
library(sna)
set.seed(1234)
ts <- rgraph(10, tprob = 0.2)
components(ts)
component.dist(ts)$membership

#3
library(sna)
n <- 10
N <- n * (n+1)
mu <- 10
world.n <- rgraph(n+1, tprob = mu/n)
D.n <- geodist(world.n)$gdist
diag(D.n) <- NA
median(D.n, na.rm = T)
addmargins(round(table(D.n)/N*100, 1))
