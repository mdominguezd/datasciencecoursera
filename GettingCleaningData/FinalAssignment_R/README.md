# README

## Dataset folder

This repository contains a Dataset taken from the UC Irvine Machine Learning Repository, further information can be found in this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The Data Downloaded includes a Training Dataset and a Test Dataset that both include 561 features used to determine the activity that 30 subjects performed using the senosr signals provided by a smartphone Samsung Galaxy SII on the waist.

## run_Analysis.R file

The `run_analysis.R` file reads the data downloaded from thre training set and the test set. Then it merges both datasets, extracts the features that include mean or std in their names adds the activity names and finally summarises the information grouped by subject and activity. The final tidy data set is found in the `tidy_data_set` and contains 180 rows (6 activities and 30 subjects) and 89 features.