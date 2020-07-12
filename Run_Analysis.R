#getting the data
x.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/X_test.txt")
y.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/y_test.txt")
subject.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/subject_test.txt")


x.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/X_train.txt")
y.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/y_train.txt")
subject.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/subject_train.txt")

features = read.table( ("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/features.txt"),header = FALSE)
activityLabels = read.table(("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/activity_labels.txt"),header = FALSE)

#naming the columns
colnames(x.test) = features[,2]
colnames(y.test) = "activityId"
colnames(subject.test) = "subjectId"

colnames(x.train) = features[,2]
colnames(y.train) = "activityId"
colnames(subject.train) = "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#merging the data
mrg_train = cbind(y.train, subject.train, x.train)
mrg_test = cbind(y.test, subject.test, x.test)
allInOne = rbind(mrg_train, mrg_test)

#selecting columns with mean and std
colNames = colnames(allInOne)
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
setForMeanAndStd <- allInOne[ , mean_and_std == TRUE]

setActivityNames = merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

#creating the tidy data
ActivityNames<-setActivityNames%>%
   arrange(subjectId,activityId)

tidydata<-ActivityNames%>% 
  group_by(subjectId,activityId)%>%
  summarize_all(list(mean))

#creating the text file
write.table(tidydata, "C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/Tidydata.txt", row.name=FALSE)
