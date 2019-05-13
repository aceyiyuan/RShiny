#Decision tree-->not working

install.packages(rpart)
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

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

data[] <- lapply(data, as.factor)


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
  tree_data<-rpart(class~.,data=data_all.train)
  # tree_data<-rpart(class~.,data=data_all.train,method="class",control=rpart.control(cp=0.001),
  #                parms=list(split="gini"))
  
  # rpart.plot(tree_data,branch=0,branch.type=2,type=2,extra=2,shadow.col="gray",
  #      box.col="green",border.col="blue",split.col="red", main="decision tree")
  # printcp(tree_data)
  data.prune=prune(tree_data,cp=tree_data$cptable[which.min(tree_data$cptable[,"xerror"]),"CP"])
  data.prune
  cp=tree_data$cptable[which.min(tree_data$cptable[,"xerror"]),"CP"]
  cp
  # rpart.plot(data.prune,branch=0,branch.type=2,type=2,extra=2,shadow.col="gray",
  #        box.col="green",border.col="blue",split.col="red", main="pruning decision tree")
  
  
  #generit Matrix table
  Prediction <- predict(data.prune,data_all.test,type="class")
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

# move it out of loop 
tree_data<-rpart(class~.,data=data_all.train,method="class",control=rpart.control(cp=0.001),
                 parms=list(split="gini"))

rpart.plot(tree_data,branch=0,branch.type=2,type=2,extra=2,shadow.col="gray",
           box.col="green",border.col="blue",split.col="red", main="decision tree")
rpart.plot(data.prune,branch=0,branch.type=2,type=2,extra=2,shadow.col="gray",
           box.col="green",border.col="blue",split.col="red", main="pruning decision tree")

# console log 


#prediction 
#   0  1
#0 14 15
#1 38 25

#prediction 
#   0  1
#0 14 15
#1 23 40

#prediction 
#  0  1
#0 16 13
#1 24 39

#prediction 
#   0  1
#0 13 16
#1 28 35

#prediction 
#   0  1
#0 14 15
#1 25 38

#prediction  
#   0  1
#0 10 19
#1 28 35

#prediction
#   0  1
#0 14 15
#1 34 29

#prediction 
#   0  1
#0 14 15
#1 31 32

#prediction 
#  0  1
#0 13 16
#1 23 40

#prediction
#   0  1
#0 23  6
#1 12 51
> 
  # accuracy
  #[1] 0.8043478
  #accuracyaverage = mean(accuracy)
  #accuracyaverage
  #[1] 0.8043478
  
  # precision
  #  0         1 
  #0.6571429 0.8947368 
  # precisionaverage = mean(precision)
  #precisionaverage
#[1] 0.7759398

#  recall
#0         1 
#0.7931034 0.8095238 
#recallaverage = mean(recall)
# recallaverage
#[1] 0.8013136

# f_measure<-2*((precision*recall)/(precision+recall))
#f_measure
#0       1 
#0.71875 0.85000 
#f_measureaverage=mean(f_measure)
# f_measureaverage
#[1] 0.784375
