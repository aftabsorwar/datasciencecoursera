x.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/X_test.txt")
y.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/y_test.txt")
subject.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/subject_test.txt")

body.acc.x.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body.acc.y.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body.acc.z.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body.gyro.x.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body.gyro.y.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body.gyro.z.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
total.acc.x.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total.acc.y.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total.acc.z.test<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")


x.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/X_train.txt")
y.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/y_train.txt")
subject.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/subject_train.txt")

body.acc.x.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body.acc.y.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body.acc.z.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
body.gyro.x.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body.gyro.y.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body.gyro.z.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
total.acc.x.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total.acc.y.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total.acc.z.train<-read.table("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

features = read.table( ("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/features.txt"),header = FALSE)
activityLabels = read.table(("C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/activity_labels.txt"),header = FALSE)

colnames(x.test) = features[,2]
colnames(y.test) = "activityId"
colnames(subject.test) = "subjectId"

colnames(x.train) = features[,2]
colnames(y.train) = "activityId"
colnames(subject.train) = "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

mrg_train = cbind(y.train, subject.train, x.train)
mrg_test = cbind(y.test, subject.test, x.test)
allInOne = rbind(mrg_train, mrg_test)

colNames = colnames(allInOne)
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
setForMeanAndStd <- allInOne[ , mean_and_std == TRUE]

setActivityNames = merge(setForMeanAndStd, activityLabels, by='activityId', all.x=TRUE)

ActivityNames<-setActivityNames%>%
   arrange(subjectId,activityId)

tidydata<-ActivityNames%>% 
  group_by(subjectId,activityId)%>%
  summarize_all(list(mean))

write.table(tidydata, "C:/Users/HP 840/Desktop/testing/UCI HAR Dataset/Tidydata.txt", row.name=FALSE)
