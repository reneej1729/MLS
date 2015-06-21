MLS Game Day Predictor Pitch
========================================================
author: reneej1729
date: June 21st, 2015
transition: concave
class: illustration

What You See
========================================================
transition: concave

- Two drop down lists with every Major League Soccer team listed. 
- One list is for the home team at a match, the other list for the 
away team.

***

- The predicted winner of the match.

Behind the Scenes
========================================================
transition: concave

- The additional **mls.R** file contains code that scrapes the
[MLS website](http://www.mlssoccer.com/schedule?month=all&year=2015&club=all&competition_type=46&broadcast_type=all&op=Search&form_id=mls_schedule_form) to get the names of the teams and their scores for all of the games played so far this season.
- This data is then cleaned up and used as a training set in a linear prediction model
that looks at the home team, the away team, and the scores for each to make the win, loss, or tie prediction.
- To predict future game results, since there are not scores for the teams yet, I used the
average number of goals the teams made playing either at home or away during this season.
- The **server.R** code sources the **mls.R** file to use this prediction algorithm and
the average goals to create the final win or tie prediction.

The rvest Pacakge
========================================================
transition: concave 

This package makes it easy to pull out a line of data from a webpage, given that
you know the CSS selector. 

```r
library(rvest)
fileURL = "http://www.mlssoccer.com/schedule?month=all&year=2015&club=all&competition_type=46&broadcast_type=all&op=Search&form_id=mls_schedule_form"
mlsdata <- html(fileURL)
mlsdata %>% html_node(".field-home-team") %>% html_text()
```

```
[1] "LA Galaxy"
```

SelectorGadget
========================================================
transition: concave

After an hour of scouring the html code for the schedule page to try to find the
correct CSS selector, I gave up and searched the web. I immediately fell in love with [SelectorGadget](http://www.selectorgadget.com).
- While running this tool, you click on any text in a webpage that you want the CSS selector for.
- The tool will tell you what it thinks the minimal CSS selector that you will need, but it will highlight all of the text that fits this selector, so you can narrow your search if it is collecting more than you want by clicking the text you want to discard.

