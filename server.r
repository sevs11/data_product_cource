library(e1071)
library(kernlab)
library(caret)
library(rpart)
library(randomForest)
library(gbm)
#load data
dataSet <- read.csv("train.csv")
set.seed(31415926)
#mark predicted data as a factor
dataSet$Survived <- as.factor(dataSet$Survived)
#divide on train and test datasets
testIndex = createDataPartition(dataSet$Survived, p = 0.30,list=FALSE)
training = dataSet[-testIndex,]
testing =  dataSet[testIndex,]
#change all the NA values to means by column
for (i in which(sapply(training, is.numeric))) {
 training[is.na(training[, i]), i] <- mean(training[, i],  na.rm = TRUE)
 testing[is.na(testing[, i]), i] <- mean(training[, i],  na.rm = TRUE) 
}

shinyServer(
  function (input,output){
# SVM calcultion
    trainSVM <- train(Survived~Pclass+Age+Sex+Fare+SibSp+Parch+Embarked, method='svmLinear', data=training)
    predsSVM <-predict(trainSVM,testing)
    resSVM <- sum(predsSVM==testing$Survived)/length(predsSVM)
    output$SVM <- renderPrint(if ("LM" %in% input$id1) resSVM else 'not checked')
# regression trees calculation    
    trainRP <- train(Survived~Pclass+Age+Sex+Fare+SibSp+Parch+Embarked, method='rpart2', data=training)
    predsRP <-predict(trainRP,testing)
    resRP <- sum(predsRP==testing$Survived)/length(predsRP)
    output$RT <- renderPrint(if ("RT" %in% input$id1) resRP else 'not checked')
# random forest calculation 
    trainRF <- train(Survived~Pclass+Age+Sex+Fare+SibSp+Parch+Embarked, method='rf', data=training)
    predsRF <-predict(trainRF,testing)
    resRF <- sum(predsRF==testing$Survived)/length(predsRF)
    output$RF <- renderPrint(if ("RF" %in% input$id1) resRF else 'not checked')

    trainComb <- data.frame(predict(trainSVM,training),predict(trainRP,training), predict(trainRF,training), Survived=training$Survived)
    testComb <- data.frame(predsSVM,predsRP, predsRF, Survived=testing$Survived)
    names(testComb) <- names(trainComb)
    combModFit <- train(Survived ~.,method="gbm",data=trainComb)
    predComb <- predict(combModFit,testComb)    
    resComb <- sum(predComb==testing$Survived)/length(predComb)
    output$Comb <- renderPrint(if ("Comb" %in% input$id1) resComb else 'not checked')
  }  
)