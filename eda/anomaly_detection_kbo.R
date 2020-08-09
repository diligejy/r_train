# KBO 2018 아시안게임브레이크 직전까지의 타자 성적 통계 데이터 로딩

hit0 <- read.csv("https://t1.daumcdn.net/cfile/blog/99B515435B87998B07?download")

hit0 <- hit0[,!(names(hit0) %in% c("선수명","순위","팀명"))]
hit0 <- hit0[,(names(hit0) %in% c("HR","PA", "BB.K", "RBI","TB"))]


install.packages("IsolationForest", repos="http://R-Forge.R-project.org")

head(hit0)

dim(hit0)
library(IsolationForest)

# train a model of Isolation Forest
tr<-IsolationTrees(hit0, ntree=1000, rFactor=0.5, nmin=3)

#evaluate anomaly score
as<-AnomalyScore(hit0,tr)
# show anomaly score
plot(density(as$outF ))
sort(as$outF, decreasing=T)[1:2]

# check what matters the most
library(party)
hit0v <- hit0 
hit0v$outF <- as$outF 
hit0v1 <- hit0v[,!(names(hit0v) %in% "선수명")]
ctv1 <- ctree(outF~., data=hit0v1)
plot(ctv1)

# 랜덤포리스트를 활용한 변수별 Anomaly Score 생성 영향도 파악

#install.packages("randomForest")
library(randomForest)
rfv1 <- randomForest(outF~., data=hit0v1,nodesize=3, ntree=3000)
varImpPlot(rfv1)

hit0 <- read.csv("https://t1.daumcdn.net/cfile/blog/99B515435B87998B07?download")

hit0$outF <- as$outF 

#head(hit0[order(hit0$outF, decreasing=T),])

# UDF for standardize anomaly score

# 스코어의 스케일을 0~1 사이로 변환하기 위한 사용자정의함수

stnd <- function(x) {
  x1 <- (x-min(x)) / (max(x)-min(x))
  return(x1)
}

stndoutF<- stnd(as$outF)

# 핵심변수 두 가지를 활용한 scatterplot 생성
# 시각적 EDA 데이터 분석을 통한 Score 이해
plot(hit0$BB.K, hit0$TB/hit0$PA, col=rgb(stndoutF, 0,1-stndoutF) , pch=19, cex=1.5, main="KBO Hitting (2018-08-16) - Anomaly Detection",
     xlab="볼넷삼진비율 BB/K",
     ylab="타수당루타 TB/PA",
     sub="red: anomaly")

text(hit0$BB.K, hit0$TB/hit0$PA, 
     labels=as.character(hit0$'선수명'),
     pos=2)

polygon(c(0.9, 1.22, 1.22),c(0.58, 0.58, 0.47), col=rgb(0,0,0.6,0.5), lty=0)

abline(v=c(quantile(hit0$BB.K, probs=c(0.9,0.8,0.7))), lty=2, col="grey")

points(hit0$BB.K, hit0$TB/hit0$PA, 
       col=rgb(stndoutF, 0,1-stndoutF) , pch=19, cex=1.5)
