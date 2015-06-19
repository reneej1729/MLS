# MLS

In the mls.R file, you find a program that scrapes the MLSsoccer.com website to pull all of the scores from the regular
season games played this year. After putting that data into a dataframe named mls, I created a prediction function. Commented
out, but run initially by me, you will see where I have cross-validated the results by making a testing data set. In testing,
I realized that my testing set was using the actual scores for the two games in the prediction algorithm, so I went back and 
added in a score "estimator" by find the average goals scored at home games and the average goals scored at away games for every
team in the league.

In the ui.R file, you will see that I changed the page to be a navbarPage (which I think looks a little better) and allows for 
easy scalability, if I wanted to add additional tabs for the MLS Open Cup games or other leagues. I also figured out how to 
embed an html link through Shiny.

My server.R file sources my mls.R file, so you will see that it calls data structures from that file. I have also created a 
predictor function that creates the text output about which team will win. (Soccer allows for tie games in the regular season.) 
You'll notice that I had to fool around a little with the data types to get everything to work properly. I'm not quite sure 
what class the input values were being passed in as, but it seemed that I had to set them to be treated as numeric. Also, to 
get the team names, I had to go back to my average data structures from the mls.R code to change the numbers to the right team
name.
