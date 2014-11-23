#load data
library(plyr)
library(dplyr)
library(reshape2)

#load the data
x_test <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
y_test<-read.table("./UCI_HAR_Dataset/test/y_test.txt")
subject_test<-read.table("./UCI_HAR_Dataset/test/subject_test.txt")

x_train <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
y_train<-read.table("./UCI_HAR_Dataset/train/y_train.txt")
subject_train<-read.table("./UCI_HAR_Dataset/train/subject_train.txt")

features<-read.table("./UCI_HAR_Dataset/features.txt")
activities<-read.table("./UCI_HAR_Dataset/activity_labels.txt")

#Add columns for subject and activity label on test sets
newset<-x_test
colnames(newset)<-features[,2]
newset<-cbind(y_test, newset)
colnames(newset)[1]<-c("activity")
newset<-cbind(subject_test, newset)
colnames(newset)[1]<-c("subject")

#add columns for subject and activity label on training sets
newset2<-x_train
colnames(newset2)<-features[,2]
newset2<-cbind(y_train, newset2)
colnames(newset2)[1]<-c("activity")
newset2<-cbind(subject_train, newset2)
colnames(newset2)[1]<-c("subject")

#Merge test set and training set
combined<-rbind(newset, newset2)

#Extracts only the measurements on the mean and standard deviation for each measurement.
tidy<-combined[,1:2]
search_index<-grep("mean()|std()", colnames(combined))
tidy<-cbind(tidy, combined[,search_index])

#Uses descriptive activity names to name the activities in the data set
colnames(activities)<-c("activity","activity_label")
tidy<-merge(activities, tidy)

#remove extra column and reorder columns
tidy<-subset(tidy, select=-activity)
a<-"subject"
tidy<-tidy2[c(a, setdiff(colnames(tidy), a))]
tidy<-arrange(tidy, subject, activity_label)

#create a tidy data set with the average of each variable for each activity and each subject
tidymelt<-melt(tidy, id=c("subject","activity_label"), measure.vars=c(setdiff(colnames(tidy), c("subject","activity_label"))))
tidyset<-dcast(tidymelt, subject+activity_label~variable, mean)
write.table(tidyset, "tidyset.txt", row.name=FALSE)
