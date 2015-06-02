m=read.csv("data/movie1.csv",header=TRUE)
shinyServer(
  function(input, output) {
    output$text2 = renderText({ 
      "Top five Movie for you"
    })
    
    
    output$text1 = renderText({ 
      movie_recommender(input$movie)
    })
    
  }
)
movie_recommender=function(n)
{ require(vegan)
  require(stats)
  m1=m[,c(1,5:23)]
  id=m[,1:2]
  #decoding title
  n1=id[as.character(id$movie.title)==n,1]
  #matrix for calculating distance
  m1=m1[,-1]
  row.names(m1)=id[,1]
  vare.dist = vegdist(m1, method = "jaccard")
  dist=as(vare.dist,"matrix")
  clust=hclust(vare.dist, method = "complete", members = NULL)
  plot(clust, labels = NULL, hang = 0.1, check = TRUE,
       axes = TRUE, frame.plot = FALSE, ann = TRUE,
       main = "Cluster",
       sub = NULL, xlab = NULL, ylab = "Height")
  ##cutting the tree
  cut=data.frame(cutree(clust, k = 100, h = NULL))
  cut1=data.frame(row.names(cut),cut)
  cut2=cut1[n1,2]
  similar=row.names(cut1[cut==cut2,])
  similar=similar[similar!=n1]
  recommended=similar[1:5]
  x=NULL
  for(i in 1:5){x[((2*i)-1)]=as.character(id[id$movie.id==as.numeric(recommended[i]),2])
                x[(2*i)]=" ,   "}
  
  return(x)
}