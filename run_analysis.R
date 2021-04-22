library(dplyr)
library(reshape2)
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
#name_list <- feature_info[feature_index,2]

#Merge dataset first:

df.afterMerge <- rbind(cbind(test_data_df,test_subject_df),
                  cbind(train_data_df,train_subject_df))
names(df.afterMerge) <- c(feature_info$V2,"SUBJECT")
#activity is named seperately to use mutate plus recode_factor function.+
df.activity <- rbind(test_activity_df,train_activity_df)


df.beforefinal <- df.afterMerge %>%
            select(all_of(feature_index),562) %>%
            mutate(ACTIVITY = recode_factor(df.activity[[1]],
                                            '1' = "WALKING",
                                            '2' = "WALKING_UPSTAIRS",
                                            '3' = "WALKING_DOWNSTAIRS",
                                            '4' = "SITTING",
                                            '5' = "STANDING",
                                            '6' = "LAYING"
                                            ))

#Melt the dataframe into a long format then recast it and average out.
df.melted <- melt(df.beforefinal,id = c("SUBJECT","ACTIVITY"))
df.final <- dcast(df.melted, SUBJECT+ACTIVITY ~ variable,fun.aggregate = mean)


# Output dataframe as a text file.
write.table(final_df,"./Final_Dataset.txt",row.names = F)
