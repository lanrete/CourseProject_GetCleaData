# Code Book

This document describe the data in `new_tidy_dataset.txt`.

Basically, this txt file contains the average of each variable for each activity and each subject.

The txt file contians a matrix of 8 columns and 2371 rows. While the first rows contains the name of each coulmn, the data set is actually a 8*2370 matrix. 

The first column contains the name of the variable whose average is stored in certain row.
The second column contains the subject whose average is stored in certain row.
The third to eighth columns contains the average of six different activities, in the order of laying, sitting, standing, walking, walking downstairs and walking upstairs.

>"tBodyAcc-std()-Y" "23" "-0.976309827361111" "-0.934933559264706" "-0.9584444925" "-0.119020586510678" "0.10825903416963" "0.0448435785868627"
 
For example, the first column of row 143 is "tBodyAcc-std()-Y", which means in this row, the average of "tBodyAcc-std()-Y" for each activity and each subject are saved. The second column of row 143 is 23, which means this row contains the average of subject No23.
The sixth column of row 143 is -0.11902, So we know that the average of tBodyAcc-std()-Y for subject No23 when subject is walking is -0.11902.
