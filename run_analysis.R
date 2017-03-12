#download file

if(!file.exists("./data")) 
{dir.create("./data")}
fileurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./data/Datasets.zip")

#unzip files

unzip(zipfile = "./data/Datasets.zip",exdir = "./data")

#read files

x_train<-read.table('./data/UCI HAR Dataset/train/X_train.txt')
Y_train<-read.table('./data/UCI HAR Dataset/train/Y_train.txt')
subject_train<- read.table('./data/UCI HAR Dataset/train/subject_train.txt')

x_test<-read.table('./data/UCI HAR Dataset/test/X_test.txt')
Y_test<-read.table('./data/UCI HAR Dataset/test/Y_test.txt')
subject_test<- read.table('./data/UCI HAR Dataset/test/subject_test.txt')

features<- read.table('./data/UCI HAR Dataset/features.txt')
activity_labels<- read.table('./data/UCI HAR Dataset/activity_labels.txt')

# give column names
colnames(x_train) <- features[,2]
colnames(Y_train) <- "activityID"
colnames(subject_train) <-"subjectID"

colnames(x_test) <- features[,2]
colnames(Y_test) <- "activityID"
colnames(subject_test) <-"subjectID"

colnames(activity_labels) <-c("activityID", "activity_type")

#merge in one test and train dataset

merge_train <- cbind(Y_train,subject_train,x_train)
merge_test <-cbind(Y_test, subject_test,x_test)

complete_data<-rbind(merge_test,merge_train)

colnames<-colnames(complete_data)

#extract only mean and standard deviation

col_mean_std<- (grepl("activityID", colnames)| grepl("subjectID",colnames) | 
            grepl("mean..", colnames) | grepl("std..", colnames))          

mean_std <- complete_data[,col_mean_std==TRUE]

#bringing in name of activity

mean_std_w_act_name<- merge(mean_std,activity_labels, by = 'activityID')

#apprioprately naming the data set

colnames<-colnames(mean_std_w_act_name)

for(i in 1:length(colnames))
{
  colnames[i] = gsub("\\()","",colnames[i])
  colnames[i] = gsub("-std$","StdDev",colnames[i])
  colnames[i] = gsub("-mean","Mean",colnames[i])
  colnames[i] = gsub("^(t)","time",colnames[i])
  colnames[i] = gsub("^(f)","freq",colnames[i])
  colnames[i] = gsub("([Gg]ravity)","Gravity",colnames[i])
  colnames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colnames[i])
  colnames[i] = gsub("[Gg]yro","Gyro",colnames[i])
  colnames[i] = gsub("AccMag","AccMagnitude",colnames[i])
  colnames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colnames[i])
  colnames[i] = gsub("JerkMag","JerkMagnitude",colnames[i])
  colnames[i] = gsub("GyroMag","GyroMagnitude",colnames[i])
};

colnames(mean_std_w_act_name) <- colnames

mean_std_w_act_name<- mean_std_w_act_name[,names(mean_std_w_act_name)!= "activity_type"]

new_data <- aggregate(mean_std_w_act_name,
                      by = list(mean_std_w_act_name$subjectID,mean_std_w_act_name$activityID),
                      mean)
new_data<-merge(new_data, activity_labels , by = "activityID")

#Storing output to new data set and exporting it

new_data<- new_data[,names(new_data)!= "Group.1" ]
new_data<- new_data[,names(new_data)!= "Group.2" ]


write.table(new_data,"final_data.txt", row.names = FALSE, sep = "\t")