install.packages(c('tree','ISLR','randomForest', 'e1071','naivebayes'))
library(tree)
library(ISLR)
library(randomForest)
library(e1071)
library(naivebayes)

cleveland <- read.csv("datasets/processed.cleveland.csv",header=T)
hungarian <- read.csv("datasets/processed.hungarian.csv",header=T)
va <- read.csv("datasets/processed.va.csv",header=T)
switzerland<- read.csv("datasets/processed.switzerland.csv",header=T)
#data <- bind_rows(cleveland, hungarian, switzerland, va)
data<-rbind(cleveland,hungarian,va,switzerland)
data$slope<-NULL
data$ca<-NULL
data$thal<-NULL

# convert class 1-4 to 1
data$class[data$class>"1"]<-"1"
#find ? elements
idx<-data =="?"
#replace elements with NA
is.na(data) <- idx

for(i in 1:ncol(data)){ #for every column of our data
  data[is.na(data[,i]), i] <- mean(as.numeric(data[,i]), na.rm =TRUE) 
  #replace every missing values with the mean of that column
}

data[] <- lapply(data, as.factor)
# initialize some data structures to store metrics for each model
accuracy<-vector()
precision<-vector()
recall<-vector()


#create 10 folds(partitions of the data after shuffering it)

datarandom<-data[sample(nrow(data)),]
folds<-cut(seq(1,nrow(data)), breaks=10, labels=FALSE)



for(i in 1:10){
  #split dataset
  set.seed(10)
  testIndexes <- which(folds==i,arr.ind=TRUE) 
  trainIndexes <- which(folds!=i,arr.ind=TRUE) 
  data_all.test <- datarandom[testIndexes, ] 
  data_all.train <- datarandom[trainIndexes, ]
  #Train model with naive bayes 
  naive_model<- naive_bayes(class ~., data = data_all.train)
  naive_model
  #train <- sample(nrow(data), nrow(data)*0.7)
  #generit Matrix table
  prediction <- predict(naive_model, data_all.test)
  
  m<- table(prediction, data_all.test$class)
  #calculate accuracy, predict and recall
  print(m)
  n=sum(m)
  nc=nrow(m)
  
  diag=diag(m)
  rowsums=apply(m,1,sum)
  colsums=apply(m,2,sum)
  p=rowsums
  q=colsums
  accuracy=sum(diag)/n
  accuracy
  
  precision=diag/colsums
  
  recall=diag/rowsums
  
}
accuracy
accuracyaverage = mean(accuracy)
accuracyaverage

precision
precisionaverage = mean(precision)
precisionaverage

recall
recallaverage = mean(recall)
recallaverage

f_measure<-2*((precision*recall)/(precision+recall))
f_measure
f_measureaverage=mean(f_measure)
f_measureaverage

#  generate plot e.g. column 4 and 5

data(datarandom) # load datarandom dataset
pairs(datarandom[4:5], main="Heart Disease Prediciton (important factors)", 
      pch=21, bg=c("red","green3","blue")[unclass(datarandom$class)])
#