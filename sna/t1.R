library(devtools)
install_github("DougLuke/UserNetR")
library(UserNetR)

help(package='UserNetR')

library(statnet)
library(UserNetR)
data(Moreno)

gender <- Moreno %v% "gender"
plot(Moreno, vertex.col = gender + 2, vertex.cex = 1.2)

network.size(Moreno)
summary(Moreno,print.adj=FALSE)

dev_hand <- 2*46/(33*32)
dev_hand

gden(Moreno)

components(Moreno)

lgc <- component.largest(Moreno,result="graph")
gd <- geodist(lgc)
max(gd$gdist)

#transitivity
gtrans(Moreno,mode="graph")

netmat1 <- rbind(c(0,1,1,0,0),
                 c(0,0,1,1,0),
                 c(0,1,0,0,0),
                 c(0,0,0,0,0),
                 c(0,0,1,0,0))
rownames(netmat1) <- c("A","B","C","D","E")
colnames(netmat1) <- c("A","B","C","D","E")
net1 <- network(netmat1,matrix.type="adjacency")
class(net1)

summary(net1)

gplot(net1, vertex.col = 2, displaylabels = TRUE)

netmat2 <- rbind(c(1,2),
                 c(1,3),
                 c(2,3),
                 c(2,4),
                 c(3,2),
                 c(5,3))
net2 <- network(netmat2,matrix.type="edgelist")
network.vertex.names(net2) <- c("A","B","C","D","E")
summary(net2)

gplot(net2, vertex.col = 2, displaylabels = TRUE)
as.sociomatrix(net1)
class(as.sociomatrix(net1))
all(as.matrix(net1) == as.sociomatrix(net1))

set.vertex.attribute(net1, "gender", c("F", "F", "M",
                                       "F", "M"))
net1 %v% "alldeg" <- degree(net1)
list.vertex.attributes(net1)

get.vertex.attribute(net1, "gender")

net1 %v% "alldeg"

list.edge.attributes(net1)
set.edge.attribute(net1,"rndval",
                   runif(network.size(net),0,1))


list.edge.attributes(net1)

summary(net1 %e% "rndval")
summary(get.edge.attribute(net1,"rndval"))

netval1 <- rbind(c(0,2,3,0,0),
                 c(0,0,3,1,0),
                 c(0,1,0,0,0),
                 c(0,0,0,0,0),
                 c(0,0,2,0,0))
netval1 <- network(netval1,matrix.type="adjacency",
                   ignore.eval=FALSE,names.eval="like")
network.vertex.names(netval1) <- c("A","B","C","D","E")
list.edge.attributes(netval1)
get.edge.attribute(netval1, "like")

as.sociomatrix(netval1)
as.sociomatrix(netval1,"like")

detach(package:statnet)
library(igraph)

inet1 <- graph.adjacency(netmat1)
class(inet1)
summary(inet1)
str(inet1)



