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
## read the test data set
xtest <- read.table("./data/test/X_test.txt", sep = "", col.names = features$featureName)
ytest <- read.table("./data/test/Y_test.txt", sep = "", col.names = c("activityCode"))
## add training x to test x
data_x <- bind_rows(xtrain, xtest)

## add training y to test y
data_y <- bind_rows(ytrain, ytest)
## 2) Extract the mean and standard deviation for each measurement

## 3) Name the activities
## 4) Label dataset variables

## 5) Create a dataset grouped by subject and activity, that shows the average of each activity
