install.packages(c('cluster','fpc','arules','class','list'))
library(cluster)
library(fpc)
library(arules)
library(class)


cleveland <- read.csv("datasets/processed.cleveland.csv",header=T)
hungarian <- read.csv("datasets/processed.hungarian.csv",header=T)
va <- read.csv("datasets/processed.va.csv",header=T)
switzerland<- read.csv("datasets/processed.switzerland.csv",header=T)

data<-rbind(cleveland,hungarian,va,switzerland)
data$slope<-NULL
data$ca<-NULL
data$thal<-NULL
data$class[data$class>"1"]<-"1"
#find ? elements
idx<-data =="?"
#replace elements with NA
is.na(data) <- idx

for(i in 1:ncol(data)){ #for every column of our data
  data[is.na(data[,i]), i] <- mean(as.numeric(data[,i]), na.rm =TRUE) 
  #replace every missing values with the mean of that column
}

data[] <- lapply(data, as.integer)

#normalize function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
# we remove the last column class before normalization, otherwise the class value will change to 0, 0.25, 0.50,0.75
# give a new name to the dateset without last row as dataset1
dataset1<-data[,1:10]
# normaliza dataset1
datanorm <- as.data.frame(lapply(dataset1, normalize))
#assign column 11 (i.e the last row class) as class. If we skip this step, the next stp, the last column of the new combined dataset will show the name as data[,11]
class<-data[,11]
# We finished the normalization process, now let's add the last row class back with all the other normalized columns
datanorm1<-cbind(datanorm, class)
#start set seed, split data process. 


accuracy<-vector()
precision<-vector()
recall<-vector()

#split dataset

datarandom<-data[sample(nrow(data)),]
folds<-cut(seq(1,nrow(data)), breaks=10, labels=FALSE)

#generit Matrix table


for(i in 1:10){
  testIndexes <- which(folds==i,arr.ind=TRUE) 
  trainIndexes <- which(folds!=i,arr.ind=TRUE) 
  data_all.test <- datarandom[testIndexes, ] 
  data_all.train <- datarandom[trainIndexes, ]
  #split dataset
  set.seed(10)
  data_pred <- knn(data_all.train, data_all.test, data_all.train[,11], k=2)
  #generit Matrix table
  
  m<-table(data_pred, data_all.test$class)
  
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

# show the summary of table before and after normalization
summary(datarandom[,1:11])
summary(datanorm1[,1:11])
#ref. to Datacamp https://www.datacamp.com/community/tutorials/machine-learning-in-r
# ggvis adds new features to make our plots interactive.
library(ggvis)
data %>% ggvis(~data$thalach,~data$trestbps, fill = ~class) %>% layer_points()
library(gmodels)

# concole log
#data_pred  
#   0  1
#0 23 14
#1 23 32

#data_pred 
#   0  1
#0 21 16
#1 23 32

#data_pred  
#   0  1
#0 24 14
#1 19 35

#data_pred 
#   0  1
#0 22 20
#1 15 35

#data_pred  
#   0  1
#0 20 17
#1 13 42

#data_pred
#   0  1
#0 23 17
#1 17 35

#data_pred
#   0  1
#0 25 10
#1 18 39

#data_pred
#   0  1
#0 27 19
#1 11 35

#data_pred
#   0  1
#0 18 15
#1 16 43

#data_pred 
#   0  1
#0 28  9
#1 25 30

# accuracy
#[1] 0.6304348
# accuracyaverage = mean(accuracy)
# accuracyaverage
#[1] 0.6304348

# precision
#0         1 
#0.5283019 0.7692308 
# precisionaverage = mean(precision)
# precisionaverage
#[1] 0.6487663

# recall
#0         1 
#0.7567568 0.5454545 
#recallaverage = mean(recall)
# recallaverage
#[1] 0.6511057

#f_measure<-2*((precision*recall)/(precision+recall))
# f_measure
#0         1 
#0.6222222 0.6382979 
#f_measureaverage=mean(f_measure)
#f_measureaverage
#[1] 0.63026


