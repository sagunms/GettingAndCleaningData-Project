# Initial path configuration (modify according to need)
datasetLocation <- "~/Getting and Cleaning Data/Project/UCI HAR Dataset/"
workspaceLocation <- "~/Getting and Cleaning Data/Project/GettingAndCleaningData-Project/"
setwd(workspaceLocation)

#install.packages('plyr')
library('plyr') # For ddply function

# Read table helper function
readTable <- function(file) {
    read.table(paste(datasetLocation, file, ".txt", sep=""))
} 

# Load all training and test data
trainData <- readTable("train/X_train")
trainLabel <- readTable("train/Y_train")
trainSubject <- readTable("train/subject_train")
testData <- readTable("test/X_test")
testLabel <- readTable("test/Y_test")
testSubject <- readTable("test/subject_test")
featureName <- readTable("features")
activityLabel <- readTable("activity_labels")

# Merge training and test data sets to create one data set
allData <- rbind(trainData, testData)
colnames(allData) <- featureName$V2

# Extract only measurements on the mean and standard deviation for each measurement
allData <- allData[grep("mean\\(\\)|std\\(\\)", names(allData))]

# Bind activity names and subjects to respective names in the data set
allLabels = rbind(trainLabel, testLabel)
allSubjects = rbind(trainSubject, testSubject)
allLabels = merge(allLabels, activityLabel, by.x="V1", by.y="V1", all=TRUE)
colnames(allLabels) <- c("Activity", "ActivityName")
colnames(allSubjects) <- c("SubjectID")
allData = cbind(allData, allLabels)
allData = cbind(allData, allSubjects)

# Create independent tidy data set with the average of each variable for each activity and each subject
tidyData = ddply(allData, c("SubjectID", "ActivityName"), function (x) { 
        colMeans(x[1:(length(allData)-3)])
    })

# Write tidyData to file
write.table(tidyData, "TidyData.txt", row.names=FALSE)

# Write codebook to file
cbContent = paste("* ", names(tidyData), sep="")
write.table(cbContent, file="CodeBook.md", quote=FALSE,
            row.names=FALSE, col.names=FALSE, sep="\t")