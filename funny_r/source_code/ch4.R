library(tidyverse)

facebookData <- read.delim('./rawdata/FacebookNarcissism.dat', header = TRUE)

facebookData

graph <- ggplot(facebookData, aes(NPQC_R_Total, Rating)) +
  geom_point(aes(colour = Rating_Type), position = 'jitter', shape = 17)

graph <- ggplot(facebookData, aes(NPQC_R_Total, Rating)) +
  geom_point(aes(shape = Rating_Type), position = 'jitter')
  
graph

# Scatter Plot

examData <- read.delim('./rawdata/Exam Anxiety.dat', header = TRUE)

scatter <- ggplot(examData, aes(Anxiety, Exam)) +
  geom_point() +
  geom_smooth(method = 'lm', colour = 'Red', fill = 'Blue') +
  labs(x = "Exam Anxiety", y = "Exam Performance % ")

scatter <- ggplot(examData, aes(Anxiety, Exam)) +
  geom_point() +
  geom_smooth(method = 'lm', colour = 'Red', se = F) +
  labs(x = "Exam Anxiety", y = "Exam Performance % ")

scatter

scatter <- ggplot(examData, aes(Anxiety, Exam, colour = Gender)) +
  geom_point() +
  geom_smooth(method = 'lm', aes(fill = Gender), alpha = 0.1) +
  labs(x = "Exam Anxiety", y = 'Exam Performance %', colour = 'Gender')


scatter

festivalData <- read.delim('./rawdata/DownloadFestival.dat', header = TRUE)

festivalHistogram <- ggplot(festivalData, aes(day1)) + 
  theme(legend.position = 'none') +
  geom_histogram(bindwidth = 0.4) +
  labs(x = 'Hygiene (Day 1 of Festival)', y = 'Frequency')

festivalHistogram
