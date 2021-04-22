---
title: "README"
author: "Wilson"
date: "2021/4/22"
output:
  word_document: default
---

The dataset is gathered from a dataset on UCI Machine Learning Repository - Human Activity Recognition Using Smartphones Data Set, and later went through a series of data manipulation. 

For the purpose of the JHU Data Science Program Assignment, we were asked to: 
- Merges the training and the test sets to create one data set. 
- Extract only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set. 
- Uses descriptive activity names to name the activities in the data set. 
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The `run_analysis.R` file is the R code to implement above operation.(Although not in the above order due to other consideration.) Below please find further explanation of the script.

`Prerequisite: dplyr package`

1. Because the dataset is stored in txt file, I use read.table() function to load 6 file. X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt.

2. To identify which features ( measurement of mean and standard deviation). After carefully reading features_info.txt, we can know that these mean-related measurements must contain string "std", and standard deviation measurement must contain char "std". Thus I  and use grep function to list out every feature contain either "mean" or "std".

3. We are ready to complete a series of operation through power dplyr library and thanks to "%>%" operators. First we use select function to extract columns in our interest. (Index comes from grep function.), use mutate function to add subject and activity column. Also recode function was used to use descriptive activity name to name the activities in data set.

4. Complete same operation for test set.

5. Use rbind to merge training set and test set.

6. Output final dataset into a csv file use write.csv funciton.
