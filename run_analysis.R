## Load all of the required libraries
library(dplyr)
library(tidyr)
library(data.table)

## 1) Merge training and test sets to create one dataset

## get feature names
features <- read.table("./data/features.txt", sep = "", col.names = c("index", "featureName"))
## read training data set
xtrain <- read.table("./data/train/X_train.txt", sep = "", col.names = features$featureName)
ytrain <- read.table("./data/train/Y_train.txt", sep = "", col.names = c("activityCode"))
subject_train <- read.table("./data/train/subject_train.txt", sep = "", col.names = c("subjectId"))

## read the test data set
xtest <- read.table("./data/test/X_test.txt", sep = "", col.names = features$featureName)
ytest <- read.table("./data/test/Y_test.txt", sep = "", col.names = c("activityCode"))
subject_test <- read.table("./data/test/subject_test.txt", sep = "", col.names = c("subjectId"))

## add training x to test x
data_x <- bind_rows(xtrain, xtest)

## add training y to test y
data_y <- bind_rows(ytrain, ytest)

## add training subjects to test subjects
subjects <- bind_rows(subject_train, subject_test)

## add subject ids and labels to values
sensorData <- bind_cols(subjects, data_y, data_x)

## 2) Extract the mean and standard deviation for each measurement
sensorData <- select(sensorData, subjectId, activityCode, grep(".mean|.std", names(sensorData)))

## 3) Name the activities
activities <- read.table("./data/activity_labels.txt", col.names = c("code", "label"))
sensorData <- sensorData %>%
              mutate(activityLabel = factor(sensorData$activityCode, labels = activities$label)) %>%
              select(-activityCode) %>%
              select(subjectId, activityLabel, everything())

## 4) Label dataset variables
## values were labelled throughout

## 5) Create a dataset grouped by subject and activity, that shows the average of each activity
