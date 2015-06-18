run_analysis <- function(){
	# This script will 
	# 1) Merges the training and the test sets to create one data set.
    # 2) Extracts only the measurements on the mean and standard deviation 
	#	 for each measurement. 
    # 3) Uses descriptive activity names to name the activities in the data set
    # 4) Appropriately labels the data set with descriptive variable names. 
	# 5) From the data set in step 4, creates a second, independent tidy data 
	#	 set with the average of each variable for each activity and 
	#	 each subject.
	
	# Download  and unzip Samsung data into the working directory
	# The extracted folder is "./UCI HAR Dataset"
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl, destfile = "./GalaxSData.zip")
	unzip("./GalaxSData.zip", exdir = ".")
	directory <- "./UCI HAR Dataset/"
	
	# (1) Merge training and test sets into one data set
	############################################################################
	
	trainData <- read.table(paste(directory,"train/X_train.txt", sep = ""))
	testData <- read.table(paste(directory,"test/X_test.txt", sep = ""))
	# Add subject type column and activity type column to data frames
	trainData$subject <- read.table(paste(directory,"train/subject_train.txt", 
										  sep = "", row.names = NULL))$V1
	testData$subject <- read.table(paste(directory,"test/subject_test.txt", 
										  sep = "", row.names = NULL))$V1
	trainData$activity <- read.table(paste(directory,"train/y_train.txt", 
										  sep = "", row.names = NULL))$V1
	testData$activity <- read.table(paste(directory,"test/y_test.txt", 
										  sep = "", row.names = NULL))$V1
	combinedData <- rbind(trainData,testData)

	
	# (2) Extracts only the mean() and the standard deviation std()
	############################################################################
	
	feature <- read.table(paste(directory,"features.txt", sep = ""))
	# Need \\ to recognize (,),other symbols and need | for -mean() OR -std()
	index <- c(562,563, grep("\\-mean\\(\\)|\\-std\\(\\)",feature[,2])) 
	combinedData <- combinedData[,index]
	
	
	# (3) Uses descriptive activity names to name the activities in the data set
	############################################################################
	# Create actLabels dataframe to use to label final tidy dataset
	# Assign label as as.character(actLabels[row,2])
	activLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
	combinedData$activity <- as.character(activLabels[combinedData$activity,2])
	
	# (4) Appropriately labels the data set with descriptive variable names.
	variableNames <- grep("\\-mean\\(\\)|\\-std\\(\\)",feature[,2], 
						  value = TRUE)
	names(combinedData)[3:68] <- variableNames
	
	# (5) From the data set in step 4, creates a second, independent tidy data 
	# set with the average of each variable for each activity and 
	# each subject. Create a text file of the generated tidy data with avg of 
	# each variable
	
	labelSub <- as.numeric(gl(length(unique(combinedData[,1])),
						   length(which(unique(combinedData[,c(1,2)])[,1]==1))))
	labelAct <- as.character(rep(activLabels$V2,
								length(unique(combinedData[,1]))))
	tidySet <- as.data.frame(matrix(nrow=length(labelSub),
									ncol=length(names(combinedData))))
	names(tidySet) <- names(combinedData)
	tidySet$subject <- labelSub
	tidySet$activity <- labelAct
	rowTracker <- 1 # Want to avoid another for loop
	for (i in 1:30){
		for (t in 1:6){
			tidyTemp <- combinedData[combinedData$subject == i & 
									combinedData$activity == activLabels[t,2],]
			tidySet[rowTracker,3:68]<-as.numeric(colMeans(tidyTemp[,3:68]))
			rowTracker <- rowTracker + 1
		}
	}
	write.table(tidySet, file = "./UCI HAR Dataset/tidyData.txt", 
				row.names = FALSE)
}