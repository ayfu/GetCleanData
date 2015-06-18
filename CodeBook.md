# (CodeBook) Getting and Cleaning Data: Course Project

This `CodeBook.md` file describes the variables, the data, and any transformations or work that I performed to clean up the data

- The data is collected from the accelerometer and gyroscope measurements from a Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

- The download link for the data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- This code, `run_analysis.r`, in my [GetCleanData repository](https://github.com/ayfu/GetCleanData), performs the following to download, to extract, and to clean up the accelerometer and gyroscope data from a Samsung Galaxy S smartphone
	- The script will automatically download and unzip all the files to the `./UCI HAR Dataset/` directory, which is created when you unzip the files.
	- It will then read in the sensor data for training and testing in `./UCI HAR Dataset/train/X_train.txt` and `./UCI HAR Dataset/test/X_test.txt`. It will also read in the subject # label dataset for training and testing in `./UCI HAR Dataset/train/subject_train.txt` and `./UCI HAR Dataset/test/subject_test.txt`. It will also read in the activity # label dataset for training and testing in `./UCI HAR Dataset/train/y_train.txt` and `./UCI HAR Dataset/test/y_test.txt`.
	- The script will then merge all this data together to form a dataframe with 10299 observations and 563 variables, with 2 of the variable columns being the subject ID label (1-30) and activity ID label (1-6), respectively. The rest of the 561 variables relate to accelerometer and gyroscope measurements taken by the Samsung smartphone.
	- The script then reads `./UCI HAR Dataset/features.txt` and extracts only the indices for the mean and the standard deviation of each measurement taken. Using these indices, the script will subset the merged dataframe for only the data that contains the mean and the standard deviation of each measurement.
	- The code reads `./UCI HAR Dataset/activity_labels.txt` and uses descriptive activity names for each activity in the data frame. It renames each number in the activity ID column of the data frame to a corresponding activity name:
		1. WALKING
		2. WALKING_UPSTAIRS
		3. WALKING_DOWNSTAIRS
		4. SITTING
		5. STANDING
		6. LAYING
	- The code reads from `./UCI HAR Dataset/features.txt` to extract measurement names, and then it appropriately labels each column in the data frame with descriptive variable names. It does this by extracting the character strings with the "mean" and "std" in them and then replaces each column name with the extracted string (excluding the activity column and the subject column). The final data frame is still 10299 x 68, so there are a total of 66 variable names, which are:
		1. "tBodyAcc-mean()-X" 
		2. "tBodyAcc-mean()-Y"
		3. "tBodyAcc-mean()-Z"
		4. "tBodyAcc-std()-X"
		5. "tBodyAcc-std()-Y" 
		6. "tBodyAcc-std()-Z" 
		7. "tGravityAcc-mean()-X" 
		8. "tGravityAcc-mean()-Y" 
		9. "tGravityAcc-mean()-Z" 
		10. "tGravityAcc-std()-X" 
		11. "tGravityAcc-std()-Y" 
		12. "tGravityAcc-std()-Z" 
		13. "tBodyAccJerk-mean()-X" 
		14. "tBodyAccJerk-mean()-Y" 
		15. "tBodyAccJerk-mean()-Z" 
		16. "tBodyAccJerk-std()-X" 
		17. "tBodyAccJerk-std()-Y" 
		18. "tBodyAccJerk-std()-Z" 
		19. "tBodyGyro-mean()-X" 
		20. "tBodyGyro-mean()-Y" 
		21. "tBodyGyro-mean()-Z" 
		22. "tBodyGyro-std()-X" 
		23. "tBodyGyro-std()-Y" 
		24. "tBodyGyro-std()-Z" 
		25. "tBodyGyroJerk-mean()-X" 
		26. "tBodyGyroJerk-mean()-Y" 
		27. "tBodyGyroJerk-mean()-Z" 
		28. "tBodyGyroJerk-std()-X" 
		29. "tBodyGyroJerk-std()-Y" 
		30. "tBodyGyroJerk-std()-Z" 
		31. "tBodyAccMag-mean()" 
		32. "tBodyAccMag-std()" 
		33. "tGravityAccMag-mean()" 
		34. "tGravityAccMag-std()" 
		35. "tBodyAccJerkMag-mean()" 
		36. "tBodyAccJerkMag-std()" 
		37. "tBodyGyroMag-mean()" 
		38. "tBodyGyroMag-std()" 
		39. "tBodyGyroJerkMag-mean()" 
		40. "tBodyGyroJerkMag-std()" 
		41. "fBodyAcc-mean()-X" 
		42. "fBodyAcc-mean()-Y" 
		43. "fBodyAcc-mean()-Z" 
		44. "fBodyAcc-std()-X" 
		45. "fBodyAcc-std()-Y" 
		46. "fBodyAcc-std()-Z" 
		47. "fBodyAccJerk-mean()-X" 
		48. "fBodyAccJerk-mean()-Y" 
		49. "fBodyAccJerk-mean()-Z" 
		50. "fBodyAccJerk-std()-X" 
		51. "fBodyAccJerk-std()-Y" 
		52. "fBodyAccJerk-std()-Z" 
		53. "fBodyGyro-mean()-X" 
		54. "fBodyGyro-mean()-Y" 
		55. "fBodyGyro-mean()-Z" 
		56. "fBodyGyro-std()-X" 
		57. "fBodyGyro-std()-Y" 
		58. "fBodyGyro-std()-Z" 
		59. "fBodyAccMag-mean()" 
		60. "fBodyAccMag-std()" 
		61. "fBodyBodyAccJerkMag-mean()" 
		62. "fBodyBodyAccJerkMag-std()" 
		63. "fBodyBodyGyroMag-mean()" 
		64. "fBodyBodyGyroMag-std()" 
		65. "fBodyBodyGyroJerkMag-mean()" 
		66. "fBodyBodyGyroJerkMag-std()"
	- The script finally creates a tidy data set, `tidyData.txt`, that calculates and describes the average (mean()) of each measurement for each activity and each subject. The data has been normalised into a range between -1 and 1, so they are unitless. The size of the data frame is 180x68 where the 68 columns corresponds to the columns from the previous data frame. The first column describes the 30 subject ID #s, which are numbers between 1-30, and the second column describes the specific activity. The rest of the columns correspond to the 66 variable names above. Since there are 30 subjects and 6 different activities, the data frame will have 180 rows describing each observation.