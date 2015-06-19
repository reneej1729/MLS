library(shiny)

shinyUI(navbarPage("MLS Game Day Predictor",
                   tabPanel("Regular Season"),
  
  sidebarLayout(
    sidebarPanel(h3("Choose the Teams"),
                 helpText("Choose the home and away team you wish to predict."),
                  selectInput("homeTeam", label = h4("Home Team:"), 
                              choices = list("Chicago Fire" = 1, "Colorado Rapids" = 2,
                                             "Columbus Crew" = 3, "D.C. United" = 4,
                                             "FC Dallas" = 5, "Houston Dynamos" = 6,
                                             "LA Galaxy" = 7, "Montreal Impact" = 8,
                                             "New England Revolution" = 9, 
                                             "New York City FC" = 10, "NY Red Bulls" = 11,
                                             "Orlando City" = 12, 
                                             "Philadelphia Union" = 13,
                                             "Portland Timbers" = 14, 
                                             "Real Salt Lake" = 15,
                                             "San Jose Earthquakes" = 16, 
                                             "Seattle Sounders" = 17, 
                                             "Sporting Kanas City" = 18,
                                             "Toronto FC" = 19, 
                                             "Vancouver Whitecaps" = 20),
                              selected = NULL),
                  selectInput("awayTeam", label = h4("Away Team:"), 
                              choices = list("Chicago Fire" = 1, "Colorado Rapids" = 2,
                                             "Columbus Crew" = 3, "D.C. United" = 4,
                                             "FC Dallas" = 5, "Houston Dynamos" = 6,
                                             "LA Galaxy" = 7, "Montreal Impact" = 8,
                                             "New England Revolution" = 9, 
                                             "New York City FC" = 10, "NY Red Bulls" = 11,
                                             "Orlando City" = 12, 
                                             "Philadelphia Union" = 13,
                                             "Portland Timbers" = 14, 
                                             "Real Salt Lake" = 15,
                                             "San Jose Earthquakes" = 16, 
                                             "Seattle Sounders" = 17, 
                                             "Sporting Kanas City" = 18,
                                             "Toronto FC" = 19, 
                                             "Vancouver Whitecaps" = 20),
                              selected = NULL)
                  #submitButton(submit, "Submit")
                  ),
    mainPanel(h2(verbatimTextOutput("winner")),
              helpText("This prediction is made based off of data from regular season 
                       games played this season, scraped off of the", 
                       a("MLS Soccer", href = "http://www.mlssoccer.com"), "website."))
  )
))