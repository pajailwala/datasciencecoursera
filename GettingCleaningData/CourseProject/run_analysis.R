####Project goals######
#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
####################################

# Set the initial working directory to download the zip file to
setwd("/Users/jailwalapa/Documents/DataScience/CourseProject/")

# Load required libraries
library(tidyr)
library(dplyr)
library(downloader)
library(reshape2)
library(data.table)

# Clear workspace
rm(list=ls())

# Download the zipped input file from the given URL, only if it does not already exist
if (!file.exists("./dataset.zip")) {
  filename<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download(filename, dest="dataset.zip", mode="wb")
  }

# Unzip the dataset and cd into the unzipped directory
if (!file.exists("./UCI HAR Dataset")) {
  unzip("dataset.zip", exdir="./")
}

# Data is downloaded and unzipped, so set the working directory
setwd("./UCI HAR Dataset")

# Load: activity labels
activity_labels <- read.table("activity_labels.txt")[,2]

# Load: data column names
features <- read.table("features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.

# Create a logical vector showing TRUE/FALSE for the pattern match
# The true mean and std feature names are 66 out of 561: are only those that end in "mean() or "std()"
extract_features <- grepl("-mean\\(\\)|-std\\(\\)", features)

# Load and process X_test & y_test data.
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# Assign the features as names of the variables (columns) in X_test 
colnames(X_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
colnames(y_test) = c("Activity_ID", "Activity_Label")
colnames(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Assign the features as names of the variables (columns) in X_train 
names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
colnames(y_train) = c("Activity_ID", "Activity_Label")
colnames(subject_train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Merge test and train data
data = rbind(test_data, train_data)

# Now make the variable names readable and consistent

# extract existing variable names
colNames=colnames(data)

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Now use the combination of melt and dcast in order to take the mean of duplicate measurements(features)

# First melt the dataset to go from wide-format to long-format
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data  = melt(data, id = id_labels, measure.vars = data_labels)

# Apply dcast on the long-format dataset, apply mean to collapse duplicate features and transform back to wide-format
# tidy_data should have 30 participants*6 activities=180 rows and 69 columns
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# write the tidy data to a file
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
