library(plyr)
library(magrittr)

## download zip file of dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## unzip file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## step 1

## read train data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## read test data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## read features
features <- read.table('./data/UCI HAR Dataset/features.txt')

## read activity labels
activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assign column names
colnames(x_train) <- features[,2] 
      colnames(y_train) <-"activityId"
      colnames(subject_train) <- "subjectId"
      
      colnames(x_test) <- features[,2] 
      colnames(y_test) <- "activityId"
      colnames(subject_test) <- "subjectId"
      
      colnames(activityLabels) <- c('activityId','activityType')
	
## merge data into one set
merge_test <- cbind(x_test, y_test, subject_test)
merge_train <- cbind(x_train, y_train, subject_train)
allData <- rbind(merge_test, merge_train)

# assign column names
colnames(allData) <- c("subject", features[, 2], "activity")

## step 2

## extract only the measurements on the mean and standard deviation
## for each measurement

## according to column name, determine which columns to keep
columnsToKeep <- grepl("subject|activity|mean|std", colnames(allData))

## keep only data in those columns
allData <- allData[, columnsToKeep]

## step 3

## Use descriptive activity names to name data set activities
allData$activity <- factor(allData$activity,
  levels = activityLabels[, 1], labels = activityLabels[, 2])

## step 4

## label data set appropriately with descriptive variable names

## get column names
allDataCols <- colnames(allData)

## remove special characters
allDataCols <- gsub("[\\(\\)-]", "", allDataCols)

## clean up names
allDataCols <- gsub("^f", "frequencyDomain", allDataCols)
allDataCols <- gsub("^t", "timeDomain", allDataCols)
allDataCols <- gsub("Acc", "Accelerometer", allDataCols)
allDataCols <- gsub("Gyro", "Gyroscope", allDataCols)
allDataCols <- gsub("Mag", "Magnitude", allDataCols)
allDataCols <- gsub("Freq", "Frequency", allDataCols)
allDataCols <- gsub("mean", "Mean", allDataCols)
allDataCols <- gsub("std", "StandardDeviation", allDataCols)

## use new labels as column names
colnames(allData) <- allDataCols

## step 5

## create second tidy data set with average of each variable per
## activity and subject

##summarise using mean and group by activity and subject
allDataMeans <- allData %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

## txt file 
write.table(allDataMeans, "tidydata.txt", row.names = FALSE, 
            quote = FALSE)

