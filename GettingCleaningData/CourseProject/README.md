## README to accompany the script run_Analysis.R and the codebook CodeBook.md ##
- - - -
##### Course Project for Getting and Cleaning Data (Aug 2015)
##### By: Parthav Jailwala

###Introduction

This repository is hosting the R code for the assignment of the DataScience track's "Getting and Cleaning Data" course which will be peer assessed.

The purpose of this project is to demonstrate the collection, work with, and cleaning of this data set. Tidy data have been prepared so can be used for later analysis.


###Instructions for project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

    1.Merges the training and the test sets to create one data set.
    2.Extracts only the measurements on the mean and standard deviation for each measurement.
    3.Uses descriptive activity names to name the activities in the data set
    4.Appropriately labels the data set with descriptive variable names.
    5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Structure of the dataset

The details of the dataset are in the README.txt file that is part of the unzipped data. From the total dataset, the following files are used here:

- `test/X_test.txt`, `train/x_train.txt`:
	- test and training data sets
	- the data are normalised and bounded within [-1,1]
- `test/subject_test.txt`, `train/subject_train.txt`:
	- each row identifies the individual who performed the activivty 
	- the range is from 1 to 30
- `test/y_test.txt`, `train/y_train.txt`: each row identifies the activity performed
	- the range is from 1 ro 6
- `activity_labels.txt`: labels for the activities in `test/y_test.txt` and `train/y_train.txt`
- `features.txt`: labels for the 561 measurements in the data sets

###Intial setup (data download, unzipping)

- First, the script loads the libraries, clears the workspace and sets the working directory
- The zipped file is downloaded from the given URL, only if is does not already exist in the working directory
- If the folder 'UCI HAR Dataset' does not exist, then the zipped file is unzipped to create this folder and its contents
- Now the working directory is set as the 'UCI HAR Dataset' folder

###Transformations

- Activity labels are read from the second column of the activity_labels.txt file. The list of features is read from the second column of the features.txt file
- As the goal is to keep only the features that represent the mean or standard deviation variables, only those variable-names that end in either '-mean()' or '-std()' are to be selected. So using grepl, a logical vector (*extract_features*) is created indicating TRUE if the variable is selected or FALSE if the variable is to be filtered out. 
- Now we read in the tables *X_test*, *Y_test* and *subject_test*.
- Assign the *features* vector as the column names for *X_test*
- Subset the *X_test* table on the columns, selecting only the columns whose variable names are in *extract_features* set
- Now load the activity labels and label the column in *subject_test* as 'subject'
- Using cbind, we merge the three tables columnwise (X_test, Y_test and subject_test) into a data frame called *test_data*
- The same set of transformations are carried out on the training dataset, creating a data frame called *train_data*
- Now using rbind, we merge the two tables *test_data* and *train_data* row-wise, creating a merged table called *data*
- Now as one the 3rd task for the script is to change the feature names to be more descriptive, a series of *gsub* commands change the feature names to be consistent and descriptive
- Now the final merged dataset *data* is melted, to transform the table from wide-format to long-format. The three columns (subject, Activity_id and Activity_label) is like a unique identifier. This will result in a long-format table with 5 columns
- The melted dataset is now casted back (*dcast*) to a wide-format table, keeping the subject and activity_label as the *id_set* and the rest of the variable to be casted into wide format. As we apply the *mean* to aggregate with, the value will be averaged if there are duplicate feature names
- So we now have a table *tidy_data* which has 66 features + the two id_variables (subject & Activity_ID)

### Output ###

The output dataset (tidy_data.txt) contains the following variables:

- `subject`
	- a numeric vector containing the subject identifiers
	- range: 1-30
- `Activity_label`
	- a factor containing the 6 performed activities
	- levels:
		- WALKING
		- WALKING_UPSTAIRS
		- WALKING_DOWNSTAIRS
		- SITTING
		- STANDING
		- LAYING
- 66 features with feature names that end in either '-mean()' or '-std()'
- the values represent the means of the measurement variables corresponding to each combination of subject, activity and measurement variable
- like the raw data, these are normalised and bounded within [-1,1]