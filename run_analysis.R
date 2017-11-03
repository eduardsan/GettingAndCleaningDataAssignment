## Load required libraries
library(dplyr)

## Define variables that will be used in the script
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
featuresFile <- "UCI HAR Dataset/features.txt"
activityLabelsFile <- "UCI HAR Dataset/activity_labels.txt"

trainSubjectFile <- "UCI HAR Dataset/train/subject_train.txt"
trainXFile <- "UCI HAR Dataset/train/X_train.txt"
trainYFile <- "UCI HAR Dataset/train/y_train.txt"

testSubjectFile <- "UCI HAR Dataset/test/subject_test.txt"
testXFile <- "UCI HAR Dataset/test/X_test.txt"
testYFile <- "UCI HAR Dataset/test/y_test.txt"

##
## Downloads project data into a local directory. Returns the destination 
## file name with its relative path.
##
## destFile: destination file to store the data.
## destDir: destination directory to store the data.
##
download.project.data <- function(destFile, destDir) {
  ## Create data directory
  if (!file.exists(destDir)) {
    dir.create(destDir)
  }
  
  ## Download dataset into data dir
  dest <- paste0("./", destDir, "/", destFile);
  if (!file.exists(dest)) {
    download.file(fileUrl, destfile = dest)
  }
  
  dest
}

##
## Reads feature names and turns them into syntactically valid names.
##
get.feature.names <- function(zipFilename) {
  feat_names <- read.table(unz(zipFilename,featuresFile), stringsAsFactors = FALSE)
  
  ## Turn feature names into syntactically valid names
  valid_names <- gsub("\\(\\)$", "", feat_names$V2)                     ## remove parenthesis at the end
  valid_names <- gsub("(\\(\\)\\-)|(\\(\\))|\\(|\\)", "_", valid_names) ## replace parenthesis with underscores
  valid_names <- gsub("\\-", ".", valid_names)                          ## replace remaining hyphens with dots

  valid_names
}

##
## Returns a factor using the activity labels.
##
get.activity.factor <- function(zipFilename) {
  activity_names <- read.table(unz(zipFilename, activityLabelsFile))
  activity_factor <- factor(activity_names$V2, levels = activity_names$V2)
  
  activity_factor
}

##
## Reads the data set from the specified files.
##
read.data.set <- function (zipFilename, subjectFile, XFile, yFile, featureNames, activityFactor) {
  subjects <- read.table(unz(zipFilename, subjectFile), col.names = c("subject"))  
  
  features <- read.table(unz(zipFilename, XFile), col.names = featureNames)
  
  activity_nums <- read.table(unz(zipFilename, yFile))
  activities <- sapply(activity_nums$V1, function(n) {activityFactor[n]})

  ## merge contents from different files into a single dataframe
  df <- cbind(subjects, features, activities)
  
  df
}

##
## Extracts only mean and standard deviation columns
##
do.select <- function(df) {
  colNames <- names(df)[grep("mean|std", names(df))]
  colNames <- c("subject", colNames, "activities")
  
  select(df, colNames)
}

##
## Prepares data set using helper methods
##

zipFilename <- download.project.data("UCI HAR Dataset.zip", "data")

featureNames <- get.feature.names(zipFilename)
activityFactor <- get.activity.factor(zipFilename)

trainDF <- read.data.set(zipFilename, trainSubjectFile, trainXFile, trainYFile, 
                         featureNames, activityFactor)
reducedTrainDF <- do.select(trainDF) ## Restrict cols to mean and standard deviation

testDF  <- read.data.set(zipFilename, testSubjectFile, testXFile, testYFile, 
                         featureNames, activityFactor)
reducedTestDF <- do.select(testDF)   ## Restrict cols to mean and standard deviation

## Merge values from the train and the test sets
mergedDF <- rbind(reducedTrainDF, reducedTestDF)

## Create output directory and write results
if (!file.exists("output")) {
  dir.create("output")
}

write.csv(mergedDF, "./output/tidy.csv")

##
## Computes averages of each variable
##

subjectActivityAvg <- summarise_all(group_by(mergedDF, subject, activities), mean)
write.csv(subjectActivityAvg, "./output/avg.csv")