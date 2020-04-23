# factor 만들기 ----
# factor(vector, labels = ,  levels = , ordered = )

bt <- c('a', 'b', 'ab', 'o', 'a')
bt

bt_factor1 <- factor(bt)
bt_factor1
mode(bt_factor1)

bt_factor2 <- factor(bt, labels = c('A', 'AB', 'B', 'O'))
bt_factor2
table(bt_factor2)

bt_factor3 <- factor(bt, levels = c('a', 'b', 'ab', 'o'))
bt_factor3

bt_factor4 <- factor(bt, levels = c('a', 'b', 'ab', 'o'), labels = c('A', 'B', 'AB', 'O'))
bt_factor4
