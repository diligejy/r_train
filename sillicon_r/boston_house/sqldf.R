install.packages('sqldf')
library(sqldf)
sqldf('select * from iris')
sqldf('select count(*) from iris')
sqldf('select Species, count(*), avg(`Sepal.Length`)
      from iris
      group by `Species`')
sqldf('select Species, `Sepal.Length`, `Sepal.Width`
      from iris
      where `Sepal.Length` < 4.5
      order by `Sepal.Width`')

library(dplyr)
(df1 <- data_frame(x ))