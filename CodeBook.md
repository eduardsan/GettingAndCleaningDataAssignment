# Code Book

The data provided in the _tidy.txt_ and _avg.txt_ have been produced by processing data collected from the accelerometers from a smartphone. The way in which the original measurements and derived results where created is explained in the information files that accompany the original data. Further details can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The _tidy.txt_ file contains the following columns:

- subject: An integer value that indentifies the subject.
- activities: A factor indicating the activity being performed by the subject.
- mean and standard deviation values estimated from the following signals:

  tBodyAcc-XYZ  
  tGravityAcc-XYZ  
  tBodyAccJerk-XYZ   
  tBodyGyro-XYZ  
  tBodyGyroJerk-XYZ  
  tBodyAccMag  
  tGravityAccMag  
  tBodyAccJerkMag  
  tBodyGyroMag  
  tBodyGyroJerkMag  
  fBodyAcc-XYZ  
  fBodyAccJerk-XYZ  
  fBodyGyro-XYZ  
  fBodyAccMag  
  fBodyAccJerkMag  
  fBodyGyroMag  
  fBodyGyroJerkMag  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

  gravityMean  
  tBodyAccMean  
  tBodyAccJerkMean  
  tBodyGyroMean  
  tBodyGyroJerkMean  

As explained in the information files that accompany the orginal data set:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
>'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  

> Features are normalized and bounded within [-1,1].

The train and test data sets, which are provided separately in the original data set, have been merged into a single data set.

The _avg.txt_ has been obtained by computing the average of the of each variable for each activity and each subject. The column names remain the same as in _tidy.txt_.
