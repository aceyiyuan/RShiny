library(shiny)
source('svm.r')

  server <- function(input, output){
    
    randomVals <- eventReactive(input$go, {
      runif(data[input$var1], data[input$var2])
    })
    
    output$keepAlive <- renderText({
      req(input$count)
      paste("keep alive ", input$count)
    })
    
    
    #Assign reactive variables
    var1<-reactive({input$var1})
    var2<-reactive({input$var2})
    
    #Output reactive variables
    output$selected_var1<- renderText({ 
      paste("You have selected", var1())
    })
    hr()
    output$selected_var2<- renderText({ 
      paste("You have selected", var2())
    })
    
    output$title<-renderText({
      paste("The correclation between", var1()," and ",var2())
    })
   
    output$img <- renderPlot({
        
        if(var1()!=var2()){
          var1<-data[input$var1]
          var2<-data[input$var2]
         # df<-data.frame(var1,var2)
          df<-data.frame(var1,var2)
         
          plot(df, col=c(28,32))
          #plot(randomVals())
          #polygon(df, col="red", border="blue")
        }else{
          
          shinyalert("Warning","Please select non-duplicate paramaters")}
  
  })
  } 
  
  

  
  
  