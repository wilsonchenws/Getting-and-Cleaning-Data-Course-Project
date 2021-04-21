library(dplyr)

# Read features(X_traing), activity(Y_train), subject for training set.
train_data_df <- read.table("./UCI HAR Dataset/train/X_train.txt",header = F)
train_subject_df <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = F)
train_activity_df <- read.table("./UCI HAR Dataset/train/y_train.txt",header = F)

#Read data(X_test), activity(Y_test), subject of testing set.
test_data_df <- read.table("./UCI HAR Dataset/test/X_test.txt",header = F)
test_subject_df <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = F)
test_activity_df <- read.table("./UCI HAR Dataset/test/y_test.txt",header = F)

#Read feature list and identify measurement of mean and standard deviation.
feature_info <- read.table("./UCI HAR Dataset/features.txt")
feature_index <- grep("(mean|std)",feature_info[[2]])
name_list <- feature_info[feature_index,2]

# Use select function to select necessary column (mean and std),
# Use mutate function to add activity column and subject column, also
# Recode function to rename activity value into more descriptive name.
train_df <- train_data_df %>%
            select(all_of(feature_index)) %>%
            mutate(SUBJECT = train_subject_df,activity = recode_factor(train_activity_df$V1,
                                            '1' = "WALKING",
                                            '2' = "WALKING_UPSTAIRS",
                                            '3' = "WALKING_DOWNSTAIRS",
                                            '4' = "SITTING",
                                            '5' = "STANDING",
                                            '6' = "LAYING"
                                            ))
#reorder column sequence (Making subject and activty 1st and 2nd column)
train_df <- train_df[,c(80,81,1:79)]

#repeat above code for test_set
test_df <- test_data_df %>%
    select(all_of(feature_index)) %>%
    mutate(SUBJECT = test_subject_df,activity = recode_factor(test_activity_df$V1,
                                                               '1' = "WALKING",
                                                               '2' = "WALKING_UPSTAIRS",
                                                               '3' = "WALKING_DOWNSTAIRS",
                                                               '4' = "SITTING",
                                                               '5' = "STANDING",
                                                               '6' = "LAYING"
    ))
#reorder column sequence (Making subject and activty 1st and 2nd column)
test_df <- test_df[,c(80,81,1:79)]
#Merge testing test and training set
final_df <- rbind(train_df,test_df)
#Give Columns meaningful name
names(final_df) <- c(c("SUBJECT","ACTIVITY"),name_list)

#(Optional) Output dataframe as a csv file.
write.csv(final_df,"./Result.csv",row.names = F)
