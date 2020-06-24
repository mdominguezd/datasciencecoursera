### FINAL ASSIGNMENT GETTING AND CLEANING DATA

## READ THE DATA

activity <- read.table("Dataset/activity_labels.txt") # Labels of activities

features <- read.table("Dataset/features.txt") %>% rename(feature_id = V1,feature = V2)

# For the training information
subject_train <- read.table("Dataset/train/subject_train.txt") %>% rename(subject_id = V1) # Subject who performed the activity

train_set <- read.table("Dataset/train/X_train.txt") # X variables for regression model
## 4. Appropriately labels the data set with descriptive variable names.
names(train_set) <- features$feature # rename column names with feature names

train_lab <- read.table("Dataset/train/y_train.txt") %>% rename(activity_label = V1)# Y values predicted labels of activity

TRAIN <- cbind(subject_train, train_lab, train_set) # Complete Training Dataset with X features, y-activities and  


# For the test information
subject_test <- read.table("Dataset/test/subject_test.txt") %>% rename(subject_id = V1) # Subject who performed the activity

test_set <- read.table("Dataset/test/X_test.txt") # X variables for regression model
## 4. Appropriately labels the data set with descriptive variable names.
names(test_set) <- features$feature # rename column names with feature names

test_lab <- read.table("Dataset/test/y_test.txt") %>% rename(activity_label = V1) # Y values predicted labels of activity

TEST <- cbind(subject_test, test_lab, test_set)

## 1. Merges the training and the test sets to create one data set.

COMPLETE <- rbind(TEST, TRAIN)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

COMPLETE_MEAN_STD <- COMPLETE[,grep("[Mm]ean|[Ss]td|activity_label|subject_id", names(COMPLETE))]

## 3. Uses descriptive activity names to name the activities in the data set.

COMPLETE_WITH_ACT <- merge(COMPLETE_MEAN_STD, activity, by.x = "activity_label", by.y = "V1") %>% rename( activity_name = V2)

## 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data_set <- group_by(COMPLETE_WITH_ACT, subject_id, activity_name) %>% summarise_all(.funs = mean)

View(tidy_data_set) # Complete tidy dataset with 180 rows and 89 columns grouped by subject_id and activity_name





