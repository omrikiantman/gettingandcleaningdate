##codebook elaborating about different variables and transformations usesd in this project

#run_analysis.R
##constants
- localZipFile : the zip file name containning the data for the project
- dataFolder : name of the data folder
- trainSetFile : full file path to the trainning set file
- trainLabelsFile : full file path to the trainning labels file
- trainSubjectFile : full file path to the trainning subjects file
- testSetFile : full file path to the testing set file
- testLabelsFile : full file path to the testing labels file
- testSubjectFile : full file path to the testing subjects file
- featuresFile : full file path to the features file
- activitesFile : full file path to the activity labels file

##variables
- zipFileURL - the URL for the zipped data
- data : combined data from test & train sources
- labels <-combined labels from test & train sources
- subjects <- combined subjects from test & train sources
- features <- features data
- activites <- activites data

##transformations

- data is filtered to have only columns which are either sum or standard deviations variables
- data, labels & subjects column names are modified to have descriptive meaning for each column
- create a tidy dataset and save it locally for summarized data grouped by activity & subject, while applying the mean() function on each un-grouped variable.

#utils.R
functions:
- merged_data(firstFile,secondFile) - use read.table to read both file and bind them together by the rbind function.

#subject
a list of 30 subjects, each subject is identified by a unique number.

#activities 
6 different activites were measured - 
- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

#features
a full list of the features is located inside the zip file (features.txt), for this assignment we've used only the ones who has "mean" or "std" in their feature name.
for each one of these, we've applied the mean() function to summarize the data based on activity and subject
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag