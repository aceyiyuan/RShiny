library(shiny)

require(reshape2)
#mat$id <- rownames(mat) 
#melt(df)
source('naiveBayes.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  set.seed(1)
  predictevent <- eventReactive(input$predict, {
    df <-data.frame('age' = as.integer(input$age),
                     'sex' = as.factor(input$sex),
                     'cp' = as.factor(input$cp),
                     'trestbps' = as.integer(as.character(input$trestbps)),
                     'chol' = as.integer(as.character(input$chol)),
                     'fbs' = as.factor(input$fbs),
                     'restecg' = as.factor(input$restecg),
                     'thalach' = as.integer(as.character(input$thalach)),
                     'exang' = as.factor(input$exang),
                     'oldpeak' = as.numeric(as.character(input$oldpeak))
 
    )
   
  
    prediction <- predict(naive_model, df)
    prediction
  })
  
  
  output$pred1 <- renderText({
    table<- table (predictevent())
    if(as.integer(table[2]) == 1){
      "You have heart disease"
    } else if (as.integer(table[1]) == 1) {
      "You don't have heart disease"
    }
  }
  )
})




