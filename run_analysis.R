library(dplyr)

#Reading the data:
setwd("~/UCI HAR Dataset")
test <- read.table("X_test.txt")
train <- read.table("X_train.txt")
test2 <- read.table("y_test.txt")
train2 <- read.table("y_train.txt")
testsub <- read.table("subject_test.txt")
trainsub <- read.table("subject_train.txt")
feat <- read.table("features.txt")

#Merging and adding the variable names:
fulld <- rbind(train, test)
names(fulld) <- feat[, 2]

#Deleting some irrelevant variables that cause an error 
#and extracting the means and standard deviations:
delet <- grep("bandsEn", names(fulld))
fulldc <- fulld[, -delet]

logi <- grepl("mean|std", names(fulldc))
meanstd <- select(fulldc, which(logi))

#Adding the activities and subject IDs:
fullact <- rbind(train2, test2)
meanstd <- cbind(fullact, meanstd)
fullsub <- rbind(trainsub, testsub)
meanstd <- cbind(fullsub, meanstd)
names(meanstd)[1] <- "SubjectNo"
names(meanstd)[2] <- "Activity"

#Swapping activity numbers with their proper names:
meanstd[, "Activity"] <- sub("1", "WALKING", meanstd[, "Activity"])
meanstd[, "Activity"] <- sub("2", "WALKING_UPSTAIRS", meanstd[, "Activity"])
meanstd[, "Activity"] <- sub("3", "WALKING_DOWNSTAIRS", meanstd[, "Activity"])
meanstd[, "Activity"] <- sub("4", "SITTING", meanstd[, "Activity"])
meanstd[, "Activity"] <- sub("5", "STANDING", meanstd[, "Activity"])
meanstd[, "Activity"] <- sub("6", "LAYING", meanstd[, "Activity"])

#Making minor changes to variable names for descriptive purposes:
names(meanstd) <- tolower(names(meanstd))
names(meanstd) <- sub("\\()", "", names(meanstd))
names(meanstd) <- sub("tbody", "tbody_", names(meanstd))
names(meanstd) <- sub("fbody", "fbody_", names(meanstd))
names(meanstd) <- sub("gyro", "gyr", names(meanstd))
names(meanstd) <- gsub("-", "_", names(meanstd))

#Extracting the new dataset:
grbysub <- group_by(meanstd, subjectno, activity)
r_analysis <- summarise_each(grbysub, funs(mean), -(subjectno:activity))
write.table(r_analysis, "~/tidydata.txt", row.name=FALSE)
