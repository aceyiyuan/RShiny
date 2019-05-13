library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Heart Disease Predictor"),
  # Sidebar with a number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("age",label = ("Enter Your Age"),min = 1,max = 120,value = 42),
      selectInput("sex", label= ("Enter Your Gender"), selectize = TRUE, choices = c("0", "1")),
      selected = "1",helpText("1=male,0=female"),
      selectInput("cp",label = ("Chest Pain Type:"),selectize = TRUE, choices = c("1","2","3","4")), 
      helpText("1. Typical Angina   2. Atypical Angina    3.Non Anginal   4. Asymptotic"),
      sliderInput("trestbps", label = ("Resting Blood Pressure"),min = 0, max = 300,value = 120),
      helpText("Range=0-300 mm/Hg"),
      numericInput("chol", label = ("Serum Cholestrol"),min = 0, max = 700,value = ""), 
      helpText("Range=0-700 mg/dL"),
      selectInput("fbs", label = ("Fasting Blood Sugar"), selectize = TRUE, choices = c("0", "1")), 
      helpText(" >120mg/dl -> 1; <120mg/dl -> 0"),
      selectInput("restecg", label =("Resting ECG result"), selectize = TRUE, choices = c("0","1","2")), 
      helpText("0: normal, 1:having ST-T wave abnormality , 2: showing ventricular hypertrophy "),
      sliderInput("thalach", label =("Max Heart Rate Achieved"), min = 0, max = 250,value = 80),
      selectInput("exang", label =("Exercise induced angina"),  selectize = TRUE, choices = c("0", "1")), 
      helpText("0 -> no, 1 -> yes"),
      textInput("oldpeak", label =("ST depression induced due to exercise"),value = ""), helpText("Range=-3-6.2"),
      actionButton("predict", "Predict")
      
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Instruction",
                           p(" "),
                           p("This web application calculates the whether you have Heart Disease based on ten variables."),
                           p("Just change the ten values and see the probability value changes correspondingly.")),
                  tabPanel("Results", h1(textOutput("pred1")))
                  
      )     
    )
  )
)
)