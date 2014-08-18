#===============================================================================
# Peer Assessments/Getting and Cleaning Data, by Francisco J. Álvarez-Vargas
#===============================================================================
# =============================< CREDITS
# --- --- --- --- --- --- --- ---< Data origin > --- --- --- --- --- --- --- ---
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Citation Request:        
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
# Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
# using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). 
# Vitoria-Gasteiz, Spain. Dec 2012

# --- --- --- --- --- --- --- ---< Assign working directory >--- --- --- --- ---
#                                  (one level up from "UCI HAR DAtaset")
setwd("D:/aToCoursera/M3_PA/")

# --- --- --- --- --- --- --- ---< Output directory >--- --- --- --- --- --- ---
if (!file.exists("data")) {dir.create("data")}

# --- --- --- --- --- --- --- ---< Load requiered packages > --- --- --- --- --- 
library(data.table)

# --- --- --- --- --- --- --- ---< Read general info >--- --- --- --- --- --- --
activity_name <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                            stringsAsFactors=F)
feature_name  <- read.table("./UCI HAR Dataset/features.txt", 
                            stringsAsFactors=F)

# --- --- --- --- --- --- --- ---< Read test data >--- --- --- --- --- --- --- -
data_test <- cbind(read.table("./UCI HAR Dataset/test/subject_test.txt"), 
                   read.table("./UCI HAR Dataset/test/y_test.txt"), 
                   read.table("./UCI HAR Dataset/test/X_test.txt"))

# --- --- --- --- --- --- --- ---< Read train data > --- --- --- --- --- --- --- 
data_train <- cbind(read.table("./UCI HAR Dataset/train/subject_train.txt"), 
                    read.table("./UCI HAR Dataset/train/y_train.txt"), 
                    read.table("./UCI HAR Dataset/train/X_train.txt"))

# --- --- --- --- --- --- --- ---< Assign test & train names >--- --- --- --- --
activity_name_ch        <- activity_name[, 2]
names(activity_name_ch) <- 1:length(activity_name_ch)

colnames(data_test) <- c("subject", "activity", 
                         as.character(feature_name[, 2]))
data_test$activity  <- activity_name_ch[data_test$activity]

colnames(data_train) <- c("subject", "activity", 
                          as.character(feature_name[, 2]))
data_train$activity  <- activity_name_ch[data_train$activity]

# --- --- --- --- --- --- --- ---< Registring data origin >--- --- --- --- --- -
data_train$origin <- as.factor("train")
data_test$origin  <- as.factor("test")

# --- --- --- --- --- --- --- ---< Merge the two data sets > --- --- --- --- ---
total_data <- rbind(data_test, data_train)

# --- --- --- --- --- --- --- ---< Extract mean & std measurements > --- --- --- 
col.means <- grep("mean()", names(total_data), ignore.case=T)
col.std   <- grep("std()",  names(total_data), ignore.case=T)
cols.ext  <- sort(c(col.means, col.std))

mean.std.data <- cbind(total_data[, c("subject", "activity")],
                       total_data[, cols.ext])

# --- --- --- --- --- --- --- ---< Average variables for activity and subject >-
mean.std.data <- data.table(mean.std.data)
average.data  <- mean.std.data[, lapply(.SD, mean), 
                               by=c("activity", "subject")]
average.data  <- average.data[order(average.data$activity), ]

# --- --- --- --- --- --- --- ---< Copy files with tables >--- --- --- --- --- -
write.table(total_data,    "./data/merged_data.txt",    sep=",", row.names=F)
write.table(mean.std.data, "./data/extracted_data.txt", sep=",", row.names=F)
write.table(average.data,  "./data/average_data.txt",   sep=",", row.names=F)
