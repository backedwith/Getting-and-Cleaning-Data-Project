Getting and Cleaning Data Course Project

This repository contains the following files:

readme.md - overview
tidydata.txt - data set
codeBook.md - data set contents
run_analysis.R - R script that was used to create the data set

R script run_analysis.R performs the following:
** Download and unzip dataset
1. Merge train and test data sets to create one data set (read files, assign column names, merge files into one set)
2. Extract only measurements on the mean and standard deviation (read column names, create vector for defining ID, mean and standard deviation, make subset from allData)
3. Use descriptive names to name data set activities
4. Label data set appropriately with descriptive variable names
5. Create a second tidy data set with average of each variable per activity and subject as txt file 

Above steps generate a tidy data text file that meets the principles of TIDY DATA:
1. Column headings
2. Variables in different columns
3. No duplicate columns