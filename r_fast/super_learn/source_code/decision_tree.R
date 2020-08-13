library(tree)

treeRaw <- tree(Class~.,
                data = train)
plot(treeRaw)