# (README) Getting and Cleaning Data: Course Project

This `README.md` file describes how `run_analysis.r` works and how to use the script properly.

1. Please place the `run_analysis.r` script in your working directory. If you don't know your working directory, please type `getwd()` in RStudio or R to find the location of the working directory.

2. Please type `source("run_analysis.r")` in RStudio or R to load the script. Follow this by typing `run_analysis()` in RStudio or R to run the script.

3. Once you run the script, it will automatically download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip the zip file to the working directory. This data is from the UCI Human Activity Recognition Using Smartphones Data Set http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
	- The unzipped folder will be called `UCI HAR Dataset` and it will be in the working directory.

4. The script will automatically read the data and merge the data together into one data frame. It reads the data from: 
	- The sensor data for training and testing in `./UCI HAR Dataset/train/X_train.txt` and `./UCI HAR Dataset/test/X_test.txt`.
	- The subject # label dataset for training and testing in `./UCI HAR Dataset/train/subject_train.txt` and `./UCI HAR Dataset/test/subject_test.txt`.
	- The activity # label dataset for training and testing in `./UCI HAR Dataset/train/y_train.txt` and `./UCI HAR Dataset/test/y_test.txt`.

5. The script will then 
	- Subset just the mean and standard deviation data using the `./UCI HAR Dataset/features.txt` to locate these variables in the data.
	- Extract the activity labels from `./UCI HAR Dataset/activity_labels.txt` to label the activity column of the subsetted data frame.
	- Extract the variable names from `./UCI HAR Dataset/features.txt` to label each column of the subsetted data frame other than the subject column and the activity column.

6. The script will then create `tidyData.txt`, which will be in the `./UCI HAR Dataset/` folder.
	- This data will be a dataset describing the average of each mean/std variable for each activity and each subject of the previously subsetted data.

7. You can read the data into R or RStudio by typing `data <- read.table("./UCI HAR Dataset/tidyData.txt", header = TRUE)`.
	- This dataset describes 6 different activities for 30 different individuals, which produces a data set with 180 rows and 68 columns for 66 different features.

