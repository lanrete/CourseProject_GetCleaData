label <- read.table("./train/y_train.txt")
val <- read.table("./train/X_train.txt")
subject <- read.table("./train/subject_train.txt")

train <- cbind(subject,label,val)

label <- read.table("./test/y_test.txt")
val <- read.table("./test/X_test.txt")
subject <- read.table("./test/subject_test.txt")

test <- cbind(subject,label,val)

complete <- rbind(train,test)

var.name <- read.table("./features.txt")
var.name[,2] <- as.character(var.name[,2])
col.num <- NULL

for (i in 1 : length(var.name[,2])) {
    if (grepl("mean", var.name[i,2])) col.num <- c(col.num, i)
    if (grepl("std", var.name[i,2])) col.num <- c(col.num, i)
}

mean_std <- subset(complete, select = c(1,2,col.num+2))

for (i in 1: length(mean_std[,2])) {
  if (mean_std[i,2] == 1) mean_std[i,2] <- "WALKING"
  if (mean_std[i,2] == 2) mean_std[i,2] <- "WALKING_UPSTAIRS"
  if (mean_std[i,2] == 3) mean_std[i,2] <- "WALKING_DOWNSTAIRS"
  if (mean_std[i,2] == 4) mean_std[i,2] <- "SITTING"
  if (mean_std[i,2] == 5) mean_std[i,2] <- "STANDING"
  if (mean_std[i,2] == 6) mean_std[i,2] <- "LAYING"
}

col.name <- c("Subject","Activities")
col.name <- c(col.name, var.name[col.num,2])

colnames(mean_std) <- col.name

category_ave <- NULL

for (i in 3:length(mean_std)) {
  category_ave <- 
    rbind(category_ave,
          tapply(mean_std[,i], list(mean_std[,1],mean_std[,2]), mean)
    )
}

subject <- rep(1:30,length(mean_std)-2)
variable.names <- rep(var.name[col.num,2], each = 30) 

category_ave <- cbind(variable.names, subject, category_ave)


write.table(category_ave, file = "./new_tidy_dataset.txt", row.names = FALSE)
