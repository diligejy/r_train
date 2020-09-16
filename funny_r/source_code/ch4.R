install.packages("Hmisc")
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

festivalBoxplot <- ggplot(festivalData, aes(gender, day1)) +
  geom_boxplot() +
  labs(x = "Gender", y = 'Hygiene (Day 1 of Festival)')

festivalBoxplot_day2 <- ggplot(festivalData, aes(gender, day2)) +
  geom_boxplot() +
  labs(x = "Gender", y = 'Hygiene (Day 2 of Festival)')

festivalBoxplot_day3 <- ggplot(festivalData, aes(gender, day3)) +
  geom_boxplot() +
  labs(x = "Gender", y = 'Hygiene (Day 3 of Festival)')

festivalBoxplot
festivalBoxplot_day2
festivalBoxplot_day3

festivalData <- festivalData[order(festivalData$day1), ]



density <- ggplot(festivalData, aes(day1)) +
  geom_density() +
  labs(x = "Hygiene (Day 1 of Festival)", y = "Density Estimate")

density

chickFlick <- read.delim('./rawdata/ChickFlick.dat', header = TRUE)

# stat_summary()
bar <- ggplot(chickFlick, aes(film, arousal)) +
  stat_summary(fun = mean, geom = 'bar', fill = 'White', colour = 'Black')

bar <- ggplot(chickFlick, aes(film, arousal)) +
  stat_summary(fun.data = mean_cl_normal, geom = 'pointrange') +
  labs(x = 'Film', y = 'Mean Arousal')

bar

hiccupsData <- read.delim('./rawdata/Hiccups.dat', header = TRUE)

hiccups <- stack(hiccupsData)
names(hiccups) <- c('Hiccups', 'Intervention')

hiccups$Intervention_Factor <- factor(hiccups$Intervention, levels(hiccups$Intervention))

line <- ggplot(hiccups, aes(Intervention_Factor, Hiccups)) +
  stat_summary(fun = mean, geom = 'line', aes(group = 1), colour = 'Blue', linetype = 'dashed')

line <- ggplot(hiccups, aes(Intervention_Factor, Hiccups)) +
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar')

line <- ggplot(hiccups, aes(Intervention_Factor, Hiccups)) +
  stat_summary(fun = mean, geom = 'line', aes(group = 1), colour = 'Blue', linetype = 'dashed') +
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar', width = 0.2) +
  labs(x = 'Intervention', y = 'Mean Number of Hiccups')

line

textData <- read.delim('./rawdata/TextMessages.dat', header = TRUE)


line <- ggplot(textData, aes(Time, Grammar_Score, colour = Group)) +
  stat_summary(fun = mean, geom = 'point') + 
  stat_summary(fun = mean, geom = 'line', aes(group = Group)) +
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar', width = 0.2) + 
  labs(x = 'Time', y = 'Mean Grammar Score', colour = 'Group')

line

