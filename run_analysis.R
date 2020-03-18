## Step1. Read in all the data tables
X_train<-read.table('train/X_train.txt')
y_train<-read.table('train/y_train.txt')
subject_train<-read.table('train/subject_train.txt')

X_test<-read.table('test/X_test.txt')
subject_test<-read.table('test/subject_test.txt')
y_test<-read.table('test/y_test.txt')

features<-read.table('features.txt')
activity_labels<-read.table('activity_labels.txt')
## Step2(Requirement1). Merge training and test data into one dataset

X_all<-rbind(X_train,X_test) 
y_all<-rbind(y_train,y_test)
#colnames(all)[1:2]<-c('subject_id','activity_id')
#colnames(all)[3:ncol(all)]<-as.characters(features[,2])

## Step3(Requirement2)Extracts only the measurements on the mean and standard deviation for each measurement.
X_filtered<-X_all[,grep('[Mm]ean|std',features[,2])]

## Step 4(requirement3) Uses descriptive activity names to name the activities in the data set
y_all[,1]<-activity_labels[match(y_all[,1],activity_labels[,1]),2]
colnames(y_all)<-'activity'

##Step 5(requirement4), Appropriately labels the data set with descriptive variable names.
colnames(X_all)<-features[,2]
colnames(X_all)<-gsub("\\()","",colnames(X_all))
colnames(X_all)[556]<-sub("\\)","",colnames(X_all)[556])

# to make one full data set, also make the filtered dataset (related to Requirement 1 and 2)
subject_all<-rbind(subject_train,subject_test)
colnames(subject_all)<-'subject_id'
all<-cbind(subject_all,y_all,X_all)
all_filtered<-all[,c(1,2,grep('[Mm]ean|[Ss]td',colnames(all)[1:563]))]

# to make a second tidy data set
library(reshape2)
molten_all_filtered<-melt(all_filtered,id= c('subject_id','activity'))
new_tidy<-dcast(molten_all_filtered,subject_id+activity~variable,mean)
write.table(new_tidy,'new_tidy.txt',row.names=F)
