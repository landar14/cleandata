cleandata
=========

Getting and Clean Data Course Project

The following steps were performed to transform raw data to tidy data. Please refer to the code book for details.

1. download raw data from
2. extract folder to working directory
3. load all the raw data into R and type source("run_analysis.R") in the R console to generate the tidy set
===The script will perform below actions===
4. add columns and activity labels to test and training data
5. combine test and training data sets
6. Extract only the measurements on means and standar deviation
7. Change the data in activity column from number to descriptive text
8. rearranage column orders so the ID variables (subject and activity) are on the left
9. melt the data so it can be reshaped
10. create a new tidy data set with the average of each variable for each activity and each subject
11. write the output in "tidyset.txt"
