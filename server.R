library(shiny)
source("mls.R")
# The web scraper and the prediction function are stored in mls.R 


######## FUNCTION FOR THE REACTIVE SERVER ########
predictr <- function(home, away){
  guess<- as.data.frame(cbind(home, away, homeAvg$x[home], awayAvg$x[away]))
  names(guess)<- c("homeTeam", "awayTeam", "homeScore", "awayScore")
  wlt <- predict(modFit, guess) #from mls.R
  if(wlt > 1/3){
    return(paste("We predict", levels(homeAvg$homeTeam)[home], "will win!"))
  }
  if(-1/4 > wlt){
    return(paste("We predict", levels(awayAvg$awayTeam)[away], "will win!"))
  }
  "We predict a tie."
}


######## SETTING UP THE SERVER ########
shinyServer(function(input, output) {
  output$winner <- renderText({predictr(as.numeric(input$homeTeam),
                                        as.numeric(input$awayTeam))})
})