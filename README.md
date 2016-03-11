# Coursera-Tidydata
Class project for Coursera "Getting and Cleaning Data"

The script "run_analysis.R" is intended to work with the 
"Human Activity Recognition Using Smartphones Data Set" available at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

That data set should be extracted to the working directory in order for the script to work

run_analysis script will take the HAR data as downloaded and:
- Combine test and training data
- Attach variable names (found in features.txt) to columns
- Append the codes for subject to the data set
- Append the codes for activity to the data set
- Recast the data into a table of variable means by subject and activity
          (i.e. mean of each variable per combination of subject/activity)
- Write that table to the file "tidyUCIHAR.txt"

This should prepare the data for analysis.

Additional details can be found in comments of run_analysis.R
