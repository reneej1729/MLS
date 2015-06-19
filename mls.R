library(rvest)
library(caret)

### Collecting the data set ###

fileURL = "http://www.mlssoccer.com/schedule?month=all&year=2015&club=all&competition_type=46&broadcast_type=all&op=Search&form_id=mls_schedule_form"
mlsdata <- html(fileURL)

# Pulling the wanted data from the html, making them factors, using only the played games
scores <- mlsdata %>% html_nodes(".field-score") %>% html_text()
homeTeam <- mlsdata %>% html_nodes(".field-home-team") %>% html_text()
homeTeam <- as.factor(homeTeam)
homeTeam <- homeTeam[1:length(scores)]
awayTeam <- mlsdata %>% html_nodes(".field-away-team") %>% html_text()
awayTeam <- as.factor(awayTeam)
awayTeam <- awayTeam[1:length(scores)]

# Making a list of the home team scores
  # Note that this only works for scores in the single digits!
homeScore <- sapply(strsplit(scores, "-"), "[", 1)
homeScore <- sapply(homeScore, substr, 18, 18)
homeScore <- sapply(homeScore, as.numeric)

# Making a list of the away team scores
  # Note that this only works for scores in the single digits!
awayScore <- sapply(strsplit(scores, "-"), "[", 2)
awayScore <- sapply(awayScore, substr, 2, 2)
awayScore <- sapply(awayScore, as.numeric)

# Making an aggregate score that determines the winner of the match
  # Positive score, home team wins. Negative score, away team wins. Zero, tie.
winLossTie <- function (x) {
  if(x > 0.5){
    return(1)
  }
  if(-0.5 > x){
    return(-1)
  }
  0
}
wlt <- homeScore - awayScore
wlt <- sapply(wlt, winLossTie)

# Creating the dataframe
mls <- as.data.frame(cbind(homeTeam, awayTeam, homeScore, awayScore, wlt))

### Making the Model ###
set.seed(1729)
inTrain <- createDataPartition(mls$wlt, p = 0.8, list = FALSE)
training <- mls[inTrain,]
testing <- mls[-inTrain,]
modFit <- train(wlt~., data = mls, method ="glm")
#pred <- predict(modFit, testing)
#pred <- sapply(pred, winLossTie)
#confusionMatrix(testing$wlt, pred) # Accuracy: .7931

#Make function that finds the mean goals for each team at home and away and use this
#when making prediction instead of known values.
homeAvg <- aggregate(homeScore, by = list(homeTeam=homeTeam), data = mls, mean)
awayAvg <- aggregate(awayScore, by = list(awayTeam=awayTeam), data = mls, mean)

#testing$homeScore <- homeAvg[testing$homeTeam,]$x
#testing$awayScore <- awayAvg[testing$awayTeam,]$x
#predAvg <- predict(modFit, testing)
#winLossTieEst <- function (x) {
#  if(x > 1/3){
#    return(1)
#  }
#  if(-1/3 > x){
#    return(-1)
#  }
#  0
#}
#predAvg <- sapply(pred, winLossTieEst)  # Accuracy: Same!
