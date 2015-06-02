m=read.csv("data/movie1.csv",header=TRUE)
choices=list()
for(i in 1:1682){ name=as.character(m$movie.title[i]); 
                  c=list(name);
                  choices=append(choices,c)}
shinyUI(fluidPage(
  titlePanel("Movie Recommender System"),
  
  fluidRow(    
    column(3,
           selectInput("movie", label = h3("Select a Movie you have watched"), 
                       choices, selected = 1))),
  mainPanel(
    textOutput("text2"),
    textOutput("text1")
  )
))

