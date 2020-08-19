library(tidyverse)
library(reshape)

satisfactionData <- read.delim('./rawdata/Honeymoon Period.dat', header = TRUE)

head(satisfactionData)
str(satisfactionData)

colSums(is.na(satisfactionData))

colnames(satisfactionData)

satisfactionStacked <- stack(satisfactionData, select = c('Satisfaction_Base', 'Satisfaction_6_Months', 'Satisfaction_12_Months', 'Satisfaction_18_Months'))

satisfactionStacked

satisfactionUnstacked <- unstack(satisfactionStacked)

satisfactionUnstacked

restructuredData <- melt(satisfactionData, id = c('Person', 'Gender'), measured = c('Satisfaction_Base', 'Satisfaction_6_Months', 'Satisfaction_12_Months', 'Satisfaction_18_Months'))

wideData <- cast(restructuredData, Person + Gender ~ variable, value = "value")

