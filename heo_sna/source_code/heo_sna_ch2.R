# Social Network Analysis : Closeness Centrality
library(sna)

# The nearly linear network
L <- matrix(c(0, 0, 0, 1, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 0, 0, 0, 0, 0,
              1, 1, 1, 0, 1, 0, 0, 0, 0,
              0, 0, 0, 1, 0, 1, 0, 0, 0,
              0, 0, 0, 0, 0, 1, 0, 1, 0,
              0, 0, 0, 0, 0, 0, 1, 0, 1,
              0, 0, 0, 0, 0, 0, 0, 1, 0), byrow = T, nrow = 9)
gplot(L, displaylabels = T, vertex.cex = 2, label.cex = 2, edge.col = 'red',
      boxed.labels = F, arrowhead.cex = 2, mode = 'kamadakawai')
round(closeness(L), 2) # Type 1 Closeness
round(closeness(L, cmode = 'suminvundir'), 2) # Type 2 Closeness
# Knoke's information network (Hanneman and Riddle, 2005)
knoke.infor <- as.matrix(read.table('./rawdata/knoke-infor.txt', header = T))

rownames(knoke.infor) <- colnames(knoke.infor)
gplot(knoke.infor, displaylabels = T, vertex.cex = 2, edge.col = 'blue', boxed.labels = F, arrowhead.cex = 1.25)
round(closeness(knoke.infor, cmode = 'suminvdir'), 2)
round(closeness(t(knoke.infor), cmode = 'suminvdir'),2)

# Social Network Analysis : Betweenness Centrality
library(sna)
# The nearly linear network L is given Section 1
betweenness(L)

# The start network
S <- matrix(c(0, 1, 1, 1, 1, 1, 1, 1, 1,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 0, 0, 0, 0), byrow = T, nrow = 9)
gplot(S, displaylabels = T, vertex.cex = 2, label.cex = 2, edge.col='red', boxed.labels = T, arrowhead.cex = 2, mode = 'kamadakawai')
betweenness(S)
# Knoke's information network is given Section 1
round(betweenness(knoke.infor),1)

# Two starts network
twostars <- matrix(0, 13, 13)
edges <- matrix(c(1, 2, 1, 3, 1, 4, 1, 5, 1, 6,
                  6, 7, 7, 8, 8, 13, 9, 13, 10, 13, 11, 13, 12, 13),
                byrow = T, ncol = 2)
twostars[edges] <- 1
twostars <- twostars + t(twostars) - twostars * t(twostars)
gplot(twostars, displaylabels = T, vertex.cex = 2, label.cex = 2, edge.col = 'red', boxed.labels = F, arrowhead.cex = 2, mode = 'kamadakawai')
betweenness(twostars)
closeness(twostars)

# eigen vector centrality
rownames(knoke.infor)
round(evcent(knoke.infor), 2)
round(evcent(t(knoke.infor)), 2)
