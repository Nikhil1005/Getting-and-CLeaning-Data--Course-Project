# Getting-and-CLeaning-Data--Course-Project

# download file

Downlaod the file from the given URL
# unzip files

Unzip the files to your local machine to use for analysis

# read files
Read test and training data sets, feature data set, whcich is bascially the column headers for X-train and test dataset

Read subject and activity dataset as well

# give column names

Give column headers to all the data set read above
1. X_train and X_test- Headers from feature data
2. Y_train and Y-test - Activity ID is header as it contains activity ID
3. Subject_train and subject_test- Subject ID is header as it contains subjects on which experiment is performed
4. activity labes- Has unique activity and activity labels

# merge in one test and train dataset

Merge x_train y_train and subject_train dataset similarly do it for test datasets

Now merge both test and train data set to make them one unified data set 

# extract only mean and standard deviation

Extract only mean and standard deviation columns using grepl function maintain activity ID and subject ID in the new data set


# apprioprately naming the data set

Rename columns in a more genric manner using gsub function

# Create summary

Summarize data set on to find mean for all variable at activity ID and subject ID level using aggregrate function

Bring in Activity naem column

# Storing output to new data set and exporting it

Store the final output in new data set and export using write.table function
