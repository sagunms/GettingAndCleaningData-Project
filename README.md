Coursera Getting and Cleaning Data Course Project
==================

This is a peer-assessed assignment for Getting and Cleaning Data course using R programming language.

`run_analysis.R` is a script that tidies up and produces aggregate data for dataset downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The training and test sets are merged together, provided with meaningful labels, activity labels are converted to sensible names and only the mean and standard deviation observations are kept. This script produces mean for all subject-activity groups, and writes a text file called `TidyData.txt` containing tidy data. In addition, the script also auto-generates the `CodeBook.md` file as a summary of the resulting data sets. 

The `run_analysis.R` script is commented to indicate which parts of the code are responsible for which transformations. After downloading the dataset, please edit the `datasetLocation` and `workspaceLocation` variables according to your desired location.