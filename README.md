## Getting and Cleaning Data Project
## My Solutions
This repo contains 
- run_analysis.R: the script that performs analysis yielding new_tidy.txt.
- new_tidy.txt: the second tidy dataset that shows the mean for each variable  of each subject and activity.
- codebook: that explains the variables and data frames generated.

#Working directory is set as the UCI HAR Dataset folder.
## Step1. To read in all the data tables
```
X_train<-read.table('train/X_train.txt')
y_train<-read.table('train/y_train.txt')
subject_train<-read.table('train/subject_train.txt')

X_test<-read.table('test/X_test.txt')
subject_test<-read.table('test/subject_test.txt')
y_test<-read.table('test/y_test.txt')

features<-read.table('features.txt')
activity_labels<-read.table('activity_labels.txt')
```

## Step2 (Requirement1). To merge training and test data into one dataset
I bind the training and test data set by rows. I also did this with the corresponding activity labels. 
```
X_all<-rbind(X_train,X_test) 
y_all<-rbind(y_train,y_test)
```
## Step3 (Requirement2). To extract only the measurements on the mean and standard deviation for each measurement (redundant step here, only to satisfy requirement 2, regenerated later)
I filter the full dataset X_all to only columns corresponding to features that are only mean and std measurements. (I haven't changed the column names of the dataset to features yet.)
```
X_filtered<-X_all[,grep('[Mm]ean|std',features[,2])]
```
## Step 4 (Requirement3). To Use descriptive activity names to name the activities in the data set
I match activity labels in y_all to corresponding names by using activity_labels table. I also renamed the y_all column name to 'activity'.
```
y_all[,1]<-activity_labels[match(y_all[,1],activity_labels[,1]),2]
colnames(y_all)<-'activity'
```
##Step 5 (Requirement4). To appropriately label the data set with descriptive variable names
I first changed the data set column names to feature names. I think the feature names are pretty clear what they mean. So I just cleaned the colmn names a bit by deleting the unecessary (). I also fixed the column names on row 556, deleting the extra ).
```
colnames(X_all)<-features[,2]
colnames(X_all)<-gsub("\\()","",colnames(X_all))
colnames(X_all)[556]<-sub("\\)","",colnames(X_all)[556])
```
# to make one full data set with both activity labels and subject ids. (Related to Requirement 1 and 2.)
Then I generate the final dataset with the full dataset (containing both training and test data) as well as activity labels and subject ids using column binding. I also regenerated the filtered dataset with only mean and standard deviation measurements, this time with subject id and activity labeled.
```
subject_all<-rbind(subject_train,subject_test)
colnames(subject_all)<-'subject_id'
all<-cbind(subject_all,y_all,X_all)
all_filtered<-all[,c(1,2,grep('[Mm]ean|[Ss]td',colnames(all)[1:563]))]
```

# Step 6 (Requirement 5). To create a second, independent tidy data set with the average of each variable for each activity and each subject.
I first melt the dataset from step 5 using subject_id and activity as unique ids and then recast it to generate mean value for all the features. Notice that there are columns with the same names, so recasted tidy data does not have fewer columns.
```
library(reshape2)
molten_all_filtered<-melt(all_filtered,id= c('subject_id','activity'))
new_tidy<-dcast(molten_all_filtered,subject_id+activity~variable,mean)
write.table(new_tidy,'new_tidy.txt',row.names=F)
```
