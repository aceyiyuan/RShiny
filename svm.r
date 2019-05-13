install.packages(c('ISLR', 'e1071'))

library(e1071)
library(ISLR)

    cleveland <- read.csv("~/datasets/processed.cleveland.csv",header=T)
    hungarian <- read.csv("~/datasets/processed.hungarian.csv",header=T)
    va <- read.csv("~/datasets/processed.va.csv",header=T)
    switzerland<- read.csv("~/datasets/processed.switzerland.csv",header=T)
  
    data<-rbind(cleveland,hungarian,va,switzerland)
    data$slope<-NULL
    data$ca<-NULL
    data$thal<-NULL
    data$class<-as.numeric(data$class)
    data$class[(data$class>1)]<-"1"
   
       
    #find ? elements
     idx<-data =="?"
     #replace elements with NA
     is.na(data) <- idx
    
     for(i in 1:ncol(data)){ #for every column of our data
     data[is.na(data[,i]), i] <- mean(as.numeric(data[,i]), na.rm =TRUE) 
     #replace every missing values with the mean of that column
     }
    
      data[] <- lapply(data, as.factor)
          
      library(e1071)
      #split dataset
      set.seed(3233)
      train =sample(nrow(data), nrow(data)*2/3)
      test=-train
      data_test=data[test,]
      data_train=data[train,]
      #generit Matrix table
      svm.data <- svm(data_train$class ~., data_train, kernel ="linear", cost=.1,
                      preprocess=c("center","scale"), metric="ROC",scale=FALSE) 
      prediction <- predict(svm.data, data_test, type = 'class') 
      summary(svm.data)
     
      m<- table(prediction, data_test$class)
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
       accuracyaverage = mean(accuracy)
       accuracyaverage
       
       precision=diag/colsums
       precision
       
       
       recall=diag/rowsums
       recall

       
       recall
       recallaverage = mean(recall)
       recallaverage
       plot(data$class,data$age, col=c(28,32))
       
       
#    # Create model and save in a separate file
# svm_model<- svm(class ~., data = data)
# svm_model
# 
# save(svm.r, file="svm.r")   
    