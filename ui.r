library(shiny)
library(shinyalert)

# tags$head(
#   HTML(
#     "
#     <script>
#     var socket_timeout_interval
#     var n = 0
#     $(document).on('shiny:connected', function(event) {
#     socket_timeout_interval = setInterval(function(){
#     Shiny.onInputChange('count', n++)
#     }, 15000)
#     });
#     $(document).on('shiny:disconnected', function(event) {
#     clearInterval(socket_timeout_interval)
#     });
#     </script>
#     "
#   )
# ) 

textOutput("keepAlive")
# Define UI ----
ui<-fluidPage(
  
  # App title ----
  titlePanel("SVM Classifier"),
  
  
  #test now
  
  
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a dataset ----
      selectInput("var1", "Choose the first variable:",
                  choices=c("age",
                            "sex",
                            "cp",
                            "chol",
                            "fbs",
                            "exang",
                            "thalach",
                            "restecg",
                            "oldpeak",
                            "trestbps",
                            "class"),
                  selected ="age"),
      
      
      selectInput("var2", "Choose the second variable:",
                  choices=c("age",
                            "sex",
                            "cp",
                            "chol",
                            "fbs",
                            "exang",
                            "thalach",
                            "restecg",
                            "oldpeak",
                            "trestbps",
                            "class"),
                  selected ="cp"),
      
      
      # Input: Specify the number of observations to view ----
     # numericInput("obs", "Number of observations to view:", 10),
      
      # Include clarifying text ----
      helpText("Note: Please select a different variable.")
      
      # Input: actionButton() to defer the rendering of output ----
      # until the user explicitly clicks the button (rather than
      # doing it immediately when inputs change). This is useful if
      # the computations required to render output are inordinately
      # time-consuming.
     # actionButton("update", "Update View")
      
    ),

  mainPanel(
    titlePanel( textOutput(outputId="title")),

    #textOutput("selected_var1"),
   # textOutput("selected_var2"),
     plotOutput(outputId="img"),
     hr(),
     useShinyalert()
   
   # actionButton("go", "Go")
  )   
  
) 

)






