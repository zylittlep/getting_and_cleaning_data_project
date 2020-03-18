## Getting and Cleaning Data Project
## My Solutions

## Step1. To read in all the data tables
X_train,y_train,subject_train,X_test,y_test,subject_test,features,activity_labels are data frames correspond to the data files with the exact same name.

- X_train: training dataset
- y_train: activity labels for training dataset (X_train)
- subject_train: subject ids for training dataset (X_train)
- X_test: test dataset
- y_test: activity labels for test dataset (X_test)
- subject_test: subject ids for test dataset (X_test)

- features: features that measured in the dataset
- activity_labels: a lookup table indicating activity label and name

## Step2 (Requirement1). To merge training and test data into one dataset

- X_all: a dataframe containing both training and test data.
- y_all: activity labels corresponding to each observations in X_all

## Step3 (Requirement2). To extract only the measurements on the mean and standard deviation for each measurement
- X_filtered: filtered out the measurements of features that only contain mean and standard deviation measurements of all the observations.


## to make one full data set with both activity labels and subject ids. (Related to Requirement 1.)

- subject_all: subject ids for all the observations in both datasets.

- all: full data set (containing both training and testing) with subject id and        activity for each observation. Variable names are changed to feature names

## Step 6 (Requirement 5). To create a second, independent tidy data set with the average of each variable for each activity and each subject.

- molten_all: a melted long data frame with subject id and activity as unique                identifiers.
- new_tidy: a second tidy data with mean value of each variable calculated for             each subject in a certain activity.

