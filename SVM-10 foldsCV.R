install.packages(c('tree','ISLR','randomForest', 'e1071'))
library(tree)
library(ISLR)
library(randomForest)
library(e1071)

cleveland <- read.csv("datasets/processed.cleveland.csv",header=T)
hungarian <- read.csv("datasets/processed.hungarian.csv",header=T)
va <- read.csv("datasets/processed.va.csv",header=T)
switzerland<- read.csv("datasets/processed.switzerland.csv",header=T)
#data <- bind_rows(cleveland, hungarian, switzerland, va)
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

data[] <- lapply(data, as.factor)

accuracy<-vector()
precision<-vector()
recall<-vector()

#split dataset
set.seed(10)
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
  svm.model<-svm(data_all.train$class~.,data=data_all.train,  kernel ="linear")
  #generit Matrix table
  prediction <- predict(svm.model, data_all.test) 
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

#console log
# 
# prediction  0  1
#          0 40  6
#          1 12 34
# 
# prediction  0  1
#          0 27  8
#          1 10 47
# 
# prediction  0  1
#          0 28 14
#          1 12 38
# 
# prediction  
#    0  1
# 0 32 11
# 1  9 40
# 
# prediction  
#    0  1
# 0 27 13
# 1 12 40
# 
# prediction  
#    0  1
# 0 24  7
# 1 14 47
# 
# prediction#
#    0  1
# 0 30  9
# 1 18 35
# 
# prediction  0  1
# 0 40  9
# 1  5 38
# 
# prediction  
#    0  1
# 0 24 13
# 1 12 43
# 
# prediction  
#    0  1
# 0 23  6
# 1 12 51
# > accuracy
# [1] 0.8043478
# > accuracyaverage = mean(accuracy)
# > accuracyaverage
# [1] 0.8043478
# > 
#   > precision
# 0         1 
# 0.6571429 0.8947368 
# > precisionaverage = mean(precision)
# > precisionaverage
# [1] 0.7759398
# > 
#   > recall
# 0         1 
# 0.7931034 0.8095238 
# > recallaverage = mean(recall)
# > recallaverage
# [1] 0.8013136

#f_measure<-2*((precision*recall)/(precision+recall))
#f_measure
#  0       1 
#  0.71875 0.85000 
# f_measureaverage=mean(f_measure)
# f_measureaverage
#[1] 0.784375


# 
# old console log based on 5 classes
# prediction 
#   0  1  2  3  4
# 0 63 13  3  1  0
# 1 13 28 10 13  2
# 2  3  9  2  3  1
# 3  2  5  5  4  1
# 4  0  1  0  2  0
# 
# prediction 
#    0  1  2  3  4
# 0 50 20  5  6  1
# 1 20 27 12  9  2
# 2  1  3  7  4  0
# 3  5  3  4  2  2
# 4  0  0  0  1  0
# 
# prediction  
#  0  1  2  3  4
# 0 57 16  1  2  1
# 1 20 27 15 13  3
# 2  3  6  1  2  0
# 3  2  6  2  3  1
# 4  0  1  1  1  0
# 
# prediction  

#    0  1  2  3  4
# 0 54 12  4  3  1
# 1 21 29 11 13  5
# 2  4  3  5  4  1
# 3  5  1  4  0  4
# 4  0  0  0  0  0
# 
# prediction  
#  0  1  2  3  4
# 0 73 15  4  3  1
# 1 12 18  8  8  1
# 2  0  8  2  4  1
# 3  3 14  2  5  0
# 4  0  0  1  1  0
# > accuracy
# [1] 0.5326087
# > accuracyaverage = mean(accuracy)
# > accuracyaverage
# [1] 0.5326087
# > 
#   > precision
# 0         1         2         3         4 
# 0.8295455 0.3272727 0.1176471 0.2380952 0.0000000 
# > precisionaverage = mean(precision)
# > precisionaverage
# [1] 0.3025121
# > 
#   > recall
# 0         1         2         3         4 
# 0.7604167 0.3829787 0.1333333 0.2083333 0.0000000 
# > recallaverage = mean(recall)
# > recallaverage
# [1] 0.2970124

