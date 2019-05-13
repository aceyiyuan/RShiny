# install.packages(c('tree','ISLR','randomForest', 'e1071'))
# library(tree)
# library(ISLR)
# library(randomForest)
# library(e1071)
# 
# install.packages(rpart)
# library(rpart)
# install.packages("rpart.plot")
# library(rpart.plot)
# 
# cleveland <- read.csv("datasets/processed.cleveland.csv",header=T)
# hungarian <- read.csv("datasets/processed.hungarian.csv",header=T)
# va <- read.csv("datasets/processed.va.csv",header=T)
# switzerland<- read.csv("datasets/processed.switzerland.csv",header=T)
# 
# data<-rbind(cleveland,hungarian,va,switzerland)
# data$slope<-NULL
# data$ca<-NULL
# data$thal<-NULL
# data$class[data$class>"1"]<-"1"
# #find ? elements
# idx<-data =="?"
# #replace elements with NA
# is.na(data) <- idx
# 
# for(i in 1:ncol(data)){ #for every column of our data
#   data[is.na(data[,i]), i] <- mean(as.numeric(data[,i]), na.rm =TRUE)
#   #replace every missing values with the mean of that column
# }
# 
# data$class <- as.factor(data$class)
# 
# 
# accuracy<-vector()
# precision<-vector()
# recall<-vector()
# 
# 
# 
# #split dataset
# 
# datarandom<-data[sample(nrow(data)),]
# folds<-cut(seq(1,nrow(data)), breaks=10, labels=FALSE)
# 
# # Partition data - train 2/3, test 1/3
# 
# 
# for(i in 1:10){
#   #split dataset
#   set.seed(10)
#   testIndexes <- which(folds==i,arr.ind=TRUE)
#   trainIndexes <- which(folds!=i,arr.ind=TRUE)
#   test <- datarandom[testIndexes, ]
#   train <- datarandom[trainIndexes, ]
# 
# 
#   rf_ntree <- randomForest(class~.,data=train,ntree=300)
#   plot(rf_ntree)
# 
#   RFModel <- randomForest(train$class ~ .,
#                         data=train,
#                         importance=TRUE,
#                         ntree=100)
# #varImpPlot(RFModel)
# RFPrediction <- predict(RFModel, test,type = "class")
# 
# #(m <- table(predicted = RFPrediction, Actual = test$class))
# 
# m<- table(predicted = RFPrediction, test$class)
# #calculate accuracy, predict and recall
# print(m)
# n=sum(m)
# nc=nrow(m)
# 
# diag=diag(m)
# rowsums=apply(m,1,sum)
# colsums=apply(m,2,sum)
# p=rowsums
# q=colsums
# accuracy=sum(diag)/n
# accuracy
# 
# precision=diag/colsums
# 
# recall=diag/rowsums
# 
# }
# 
# accuracy
# accuracyaverage = mean(accuracy)
# accuracyaverage
# 
# precision
# precisionaverage = mean(precision)
# precisionaverage
# 
# recall
# recallaverage = mean(recall)
# recallaverage
# 
# f_measure<-2*((precision*recall)/(precision+recall))
# f_measure
# f_measureaverage=mean(f_measure)
# f_measureaverage


#predicted
#    0  1
# 0 40  6
# 1 12 34

# predicted
#    0  1
# 0 29  9
# 1  8 46
#
# predicted
#    0  1
# 0 27 12
# 1 13 40
#
# predicted
#    0  1
# 0 31  4
# 1 10 47
#
# predicted
#   0  1
# 0 29 11
# 1 10 42
#
# predicted
#    0  1
# 0 31  7
# 1  7 47
#
# predicted
#    0  1
# 0 32  6
# 1 16 38
#
# predicted
#    0  1
# 0 41  9
# 1  4 38
#
# predicted
#    0  1
# 0 26  8
# 1 10 48
#
# predicted
#    0  1
# 0 28 11
# 1  7 46
# >
#   > accuracy
# [1] 0.8043478
# > accuracyaverage = mean(accuracy)
# > accuracyaverage
# [1] 0.8043478
# >
#   > precision
# 0         1
# 0.8000000 0.8070175
# > precisionaverage = mean(precision)
# > precisionaverage
# [1] 0.8035088
# >
#   > recall
# 0         1
# 0.7179487 0.8679245
# > recallaverage = mean(recall)
# > recallaverage
# [1] 0.7929366
# >
#   > f_measure<-2*((precision*recall)/(precision+recall))
# > f_measure
# 0         1
# 0.7567568 0.8363636
# > f_measureaverage=mean(f_measure)
# > f_measureaverage
# [1] 0.7965602
install.packages("shiny")
library(shiny)
run

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello Yi!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)
runExample("01_hello")
