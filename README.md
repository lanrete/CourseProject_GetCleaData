# Code Explanation

This document explains how all of the scripts work and how they are connected.  

## Merges the Training and the Test Sets to Create One Data Set

For the first part, the script reads two parts of the data seperately. Since the the value and the labels of the variables are stored in different raw files,  what the script does is to read these values and properties into three vectors, and then combines these vectors into a matrix by using 'cbind'.

```r
label <- read.table("./train/y_train.txt")
val <- read.table("./train/X_train.txt")
subject <- read.table("./train/subject_train.txt")
train <- cbind(subject,label,val)

label <- read.table("./test/y_test.txt")
val <- read.table("./test/X_test.txt")
subject <- read.table("./test/subject_test.txt")
test <- cbind(subject,label,val)
```

To combine these two matrixs, 'rbind' were used.

```r
complete <- rbind(train,test)
```

## Extracts Only the Measurements on the Mean and Standard Deviation for Each Measurement. 

To extract measurements on the mean and std, we need to know which columns contains the information we want to extract.  The script read 'features.txt' to get the list of all features, among which the script search for the feature whose name contains 'mean' or 'std', and record the columns which these features are saved in.

```r
var.name <- read.table("./features.txt")
var.name[,2] <- as.character(var.name[,2])
col.num <- NULL

for (i in 1 : length(var.name[,2])) {
    if (grepl("mean", var.name[i,2])) col.num <- c(col.num, i)
    if (grepl("std", var.name[i,2])) col.num <- c(col.num, i)
}
```

Since we know which exact columns to extract, we can simply get the data set we want.

```r
mean_std <- subset(complete, select = c(1,2,col.num+2))
```

## Uses Descriptive Activity Names to Name the Activities in the Data Set

A Simple `if ` statement can help us to name the activites in the data set.

```r
for (i in 1: length(mean_std[,2])) {
  if (mean_std[i,2] == 1) mean_std[i,2] <- "WALKING"
  if (mean_std[i,2] == 2) mean_std[i,2] <- "WALKING_UPSTAIRS"
  if (mean_std[i,2] == 3) mean_std[i,2] <- "WALKING_DOWNSTAIRS"
  if (mean_std[i,2] == 4) mean_std[i,2] <- "SITTING"
  if (mean_std[i,2] == 5) mean_std[i,2] <- "STANDING"
  if (mean_std[i,2] == 6) mean_std[i,2] <- "LAYING"
}
```

## Appropriately Labels the Data Set with Descriptive Variable Names. 

To label the data set, again we need to use the information of the list of all features. From the list, we can extract the name of each column in our data set.

```r
col.name <- c("Subject","Activities")
col.name <- c(col.name, var.name[col.num,2])

colnames(mean_std) <- col.name
```

## Creates a Tidy Data Set with the Average of Each Variable for Each Activity and Each Subject.

To apply a mean function on different groups of the data set, a `tapply` function can be very helpful.

For variable stored in column i, `tapply(mean_std[,i], list(mean_std[,1],mean_std[,2]), mean)` returns a matrix with average of this variable for each activty and each subject.

To get the complete matrix contains average of each variables, a `for` loop is used.

```r
category_ave <- NULL

for (i in 3:length(mean_std)) {
  category_ave <- 
    rbind(category_ave,
          tapply(mean_std[,i], list(mean_std[,1],mean_std[,2]), mean)
    )
}
```

Subjects and variable names are added to the data set to make it more friendly.

```r
subject <- rep(1:30,length(mean_std)-2)
variable.names <- rep(var.name[col.num,2], each = 30) 

category_ave <- cbind(variable.names, subject, category_ave)
```
