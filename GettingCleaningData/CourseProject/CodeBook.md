## CODEBOOK to accompany the script run_Analysis.R and the readme README.md ##
- - - -

### Loading the tidy data

The tidy data in tidy_data.txt can be read into R with the following code:

```
read.table("tidy_data.txt", header=TRUE, colClasses=c('factor', 'factor', rep('numeric', 66)))
dim(tidy_data)
```

### What information is in tidy data

*The tidy_data.txt should have 68 columns and 180 rows. It is a tidy subset of the data provided in the Human Activity Recognition Using Smartphones Data Set. The source data is available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones# and it's also included in the UCI HAR Dataset directory in this repo.

*tidy_data.txt includes the combined test and training data sets. README.md includes a walk through of the data transformation steps used to create tidy_data.txt.

*The tidy dataset includes only measurements on the mean and standard deviation for each measure. This reduces the data to 68 columns (66 feature variable measurements, plus the TestSubject and Activity columns). The size of the tidy data set was further reduced by averaging each variable for each activity and each subject. This resulted in 180 rows of data, with a unique combination of Subject and Activity values in each row. 
- - - 

### Data Dictionary

The variables in this tidy data set are a subset of the variables described in the features_info.txt file in the original data set. 

 1 "subject"            : numerical integer from 1 to 30 indentifying the participant           
 2 "Activity_Label"     : Identifies the activity being performed. Values: Walking, WalkingUpStairs, WalkingDownStairs, Sitting, Standing, Lying       
 
##### Means & standard deviations of body accelerations on X-, Y- and Z- axis

 3 "tBodyAcc-mean()-X"         
 4 "tBodyAcc-mean()-Y"          
 5 "tBodyAcc-mean()-Z"
 6 "tBodyAcc-std()-X"           
 7 "tBodyAcc-std()-Y"            
 8 "tBodyAcc-std()-Z"    
 
##### Means & standard deviations of gravity accelerations on X-, Y- and Z- axis
9 "tGravityAcc-mean()-X"        
10 "tGravityAcc-mean()-Y"       
11 "tGravityAcc-mean()-Z" 
12 "tGravityAcc-std()-X"        
13 "tGravityAcc-std()-Y"         
14 "tGravityAcc-std()-Z" 

#####The mean and standard deviations of the body acceleration on the X, Y and Z- axis, derived in time to obtain Jerk signals. 

15 "tBodyAccJerk-mean()-X"       
16 "tBodyAccJerk-mean()-Y"      
17 "tBodyAccJerk-mean()-Z" 
18 "tBodyAccJerk-std()-X"       
19 "tBodyAccJerk-std()-Y"        
20 "tBodyAccJerk-std()-Z"

#####The mean  & standard deviations of the body accelaration on the X-, Y- and Z- axis, derived in time to obtain the gyroscope 3-axial raw signals

21 "tBodyGyro-mean()-X"          
22 "tBodyGyro-mean()-Y"         
23 "tBodyGyro-mean()-Z"          
24 "tBodyGyro-std()-X"          
25 "tBodyGyro-std()-Y"           
26 "tBodyGyro-std()-Z"

##### The means and standard deviations of the angular velocity derived in time to obtain the Jerk signals

27 "tBodyGyroJerk-mean()-X"      
28 "tBodyGyroJerk-mean()-Y"     
29 "tBodyGyroJerk-mean()-Z"      
30 "tBodyGyroJerk-std()-X"      
31 "tBodyGyroJerk-std()-Y"       
32 "tBodyGyroJerk-std()-Z" 

##### Mean and Standard deviation of the magnitude of 3-dimensional body acceleration calculated using the Euclidean norm
33 "tBodyAccMag-mean()"          
34 "tBodyAccMag-std()" 

##### Mean and Standard deviation of the magnitude of 3-dimensional gravity acceleration 

35 "tGravityAccMag-mean()"       
36 "tGravityAccMag-std()" 

#####The mean and standard deviations of the magnitude of body acceleration on the X, Y and Z- axis, derived in time to obtain Jerk signals,  

37 "tBodyAccJerkMag-mean()"      
38 "tBodyAccJerkMag-std()"   

#####The mean  & standard deviations of the magnitude of  body accelaration on the X-, Y- and Z- axis, derived in time to obtain the gyroscope 3-axial raw signals 

39 "tBodyGyroMag-mean()"         
40 "tBodyGyroMag-std()" 

##### The means and standard deviations of the magnitude of  the angular velocity derived in time to obtain the Jerk signals

41 "tBodyGyroJerkMag-mean()"     
42 "tBodyGyroJerkMag-std()"   

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyAcc

43 "fBodyAcc-mean()-X"           
44 "fBodyAcc-mean()-Y"          
45 "fBodyAcc-mean()-Z"           
46 "fBodyAcc-std()-X"           
47 "fBodyAcc-std()-Y"            
48 "fBodyAcc-std()-Z"        

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyAccJerk

49 "fBodyAccJerk-mean()-X"       
50 "fBodyAccJerk-mean()-Y"      
51 "fBodyAccJerk-mean()-Z"       
52 "fBodyAccJerk-std()-X"       
53 "fBodyAccJerk-std()-Y"        
54 "fBodyAccJerk-std()-Z" 

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyGyro

55 "fBodyGyro-mean()-X"          
56 "fBodyGyro-mean()-Y"         
57 "fBodyGyro-mean()-Z"          
58 "fBodyGyro-std()-X"          
59 "fBodyGyro-std()-Y"           
60 "fBodyGyro-std()-Z"   

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyAccMag

61 "fBodyAccMag-mean()"          
62 "fBodyAccMag-std()" 

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyBodyAccJergMag

63 "fBodyBodyAccJerkMag-mean()"  
64 "fBodyBodyAccJerkMag-std()"  

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyBodyGyroMag

65 "fBodyBodyGyroMag-mean()"     
66 "fBodyBodyGyroMag-std()"  

##### Mean & standard deviations of the Fast Fourier transform (frequency domain signal) of the tBodyBodyGyroJerkMag

67 "fBodyBodyGyroJerkMag-mean()" 
68 "fBodyBodyGyroJerkMag-std()"

- - - -


