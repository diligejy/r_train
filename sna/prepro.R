library(readxl)
library(dplyr)

# Data Load
# t_jn == 기술혁신학회지
# t_rs == 기술혁신연구구
t_jn <- read_excel("C:/Users/jinyoung/Documents/insightmining/sna/tech_inno_journal_paper.xlsx", col_names = TRUE)
t_rs <- read_excel('C:/Users/jinyoung/Documents/insightmining/sna/tech_inno_research_paper.xlsx')

# Data Exploration
str(t_jn)
str(t_rs)
names(t_jn)
names(t_rs)

nrow(t_jn)
nrow(t_rs)
ncol(t_jn)
ncol(t_rs)

dim(t_jn)
dim(t_rs)

# 데이터프레임 merge
tech_total <- rbind(t_jn, t_rs)
dim(tech_total)

