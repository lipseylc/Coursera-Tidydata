setwd("./UCI HAR Dataset")

library(data.table)
library(dplyr)

################################################################################
##     1. Merges the training and the test sets to create one data set.      
################################################################################


##                       READ IN TEST DATA
# Read in the feature names
features <- fread("features.txt", colClasses = "character",
                        col.names = c("index","featurename"))

# Read in accelerometer data, using feature names as column names
test <- fread("./test/X_test.txt",col.names = features$featurename)

# Read in activity coding and join it to accelerometer data
test$Activity <- fread("./test/y_test.txt", col.names = "Activity")


##                      READ IN TRAINING DATA
# Read in accelerometer data, using feature names as column names
train <- fread("./train/X_train.txt",col.names = features$featurename)

# Read in activity coding and join it to accelerometer data
train$Activity <- fread("./train/y_train.txt", col.names = "Activity")


##                      ADD SUBJECT IDENTIFIERS
train$Subject <- fread("./train/subject_train.txt", col.names = "Subject")
test$Subject <- fread("./test/subject_test.txt", col.names = "Subject")


##                      MERGE TEST AND TRAINING DATA
fulldata <- rbind(test,train)

################################################################################
##    2. Extracts only the measurements on the mean and
##       standard deviation for each measurement.                             
################################################################################


# Creates index vector of column numbers for mean and sd variables
# Plus the Activity column
colindex <- grep("[^Jerk][Mm]ean[^Freq][^gravity]|std|Activity",
                 colnames(fulldata))

# Subsets to only those column numbers in the index vector
data <- select(fulldata, colindex)


################################################################################
##   3. Uses descriptive activity names to name the activities in the data set
################################################################################


data$Activity <- factor(data$Activity,
                        labels = c("WALKING","WALKING_UPSTAIRS",
                                   "WALKING_DOWNSTAIRS","SITTING",
                                   "STANDING","LAYING"))


################################################################################
##   4. Appropriately labels the data set with descriptive variable names.
################################################################################


# I feel that these are already pretty descriptive, and without knowing anything
# about accelerometers I can't clarify them


################################################################################
##   5. From the data set in step 4, creates a second, independent tidy data set
##      with the average of each variable for each activity and each subject.
################################################################################


##                      READ IN SUBJECTS DATA   
data$Subject <- rbind(fread("./test/subject_test.txt", col.names = "Subject"),
                      fread("./train/subject_train.txt", col.names = "Subject"))


##                      CREATE SECOND DATA SET
# Melt data
datamelt <- melt.data.table(data, id.vars = c("Subject","Activity"))

# Cast melted data into new data table
data2 <- dcast(datamelt, Subject + Activity ~ variable, fun = mean)

##                      WRITE SECOND DATA SET TO FILE
write.table(data2, file = "tidyUCIHAR2.txt", row.name = FALSE)
