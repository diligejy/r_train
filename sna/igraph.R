detach(package:statnet)
library(igraph)

inet1 <- graph.adjacency(netmat1)
class(inet1)
summary(inet1)
str(inet1)
