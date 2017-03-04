## This is the Getting and Cleaning Data Course Project
## we will create a tidy dataset which will:
##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement.
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names.
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#CONSTANTS
localZipFile <- "./data/Dataset.zip"
dataFolder <- "./data/UCI HAR Dataset"
trainSetFile <- file.path(dataFolder,"train","X_train.txt")
trainLabelsFile <- file.path(dataFolder,"train","y_train.txt")
trainSubjectFile <- file.path(dataFolder,"train","subject_train.txt")
testSetFile <- file.path(dataFolder,"test","X_test.txt")
testLabelsFile <- file.path(dataFolder,"test","y_test.txt")
testSubjectFile <- file.path(dataFolder,"test","subject_test.txt")
featuresFile <- file.path(dataFolder,"features.txt")
activitesFile <- file.path(dataFolder,"activity_labels.txt")
#Require relevant R packages
packagesToRequire <- c("dplyr")
lapply(packagesToRequire,require,character.only = TRUE)
source("utils.r")

#Create data Folder
if(!file.exists("data")) 
  dir.create("data")

#Download zip file & unzip it
if(!file.exists(localZipFile)) {
  zipFileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipFileURL,localZipFile,method = "curl")
  unzip(localZipFile, exdir = "./data")
  }

#Load datasets
data <- merged_data(trainSetFile,testSetFile)
labels <-merged_data(trainLabelsFile,testLabelsFile)
subjects <- merged_data(trainSubjectFile,testSubjectFile)
features <- read.table(featuresFile)
activites <- read.table(activitesFile)

#Extract only mean & sum measurments
#By grapping column names that contains either -mean or -std in them
meanStdColumnNumbers <- grep("-(mean|std)",features$V2)
meanStdColumnNames <- grep("-(mean|std)",features$V2, value = TRUE)
data <- data %>% select(meanStdColumnNumbers)

#Use descriptive activity names to name the activities in the data set
#by locating the activitiy label according to the value in the label
label_names <- as.data.frame(sapply(labels,function(x){activites[x,2]}))

#Appropriately labels the data set with descriptive variable names.
names(data) <- meanStdColumnNames
names(label_names) <- c("activity")
names(subjects) <- c("subject_number")

names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
##From the data set in step 4, creates a second, independent tidy data set
##with the average of each variable for each activity and each subject.
unitedData <- cbind(subjects,label_names,data)
tidyDataSet <- unitedData %>% group_by(activity,subject_number) %>% summarise_all(mean)
write.table(tidyDataSet,"./data/tidyDataSet.txt",row.names = FALSE)
