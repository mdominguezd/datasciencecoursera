# CodeBook

### Origin of DataSet
The Dataset is taken from th UC Irvine Machine Learning Repository, further information can be found in this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The Data Downloaded includes a Training Dataset and a Test Dataset that both include 561 features used to determine the activity that 30 subjects performed using the senosr signals provided by a smartphone Samsung Galaxy SII on the waist.


### Features 

Some of the 561 features presente in the training and testing data set are listed below:
+ tBodyAcc-mean()-X                    
+ tBodyAcc-mean()-Y                   
+ tBodyAcc-mean()-Z                    
+ tBodyAcc-std()-X                    
+ tBodyAcc-std()-Y                     
+ tBodyAcc-std()-Z                    
+ tBodyAcc-mad()-X                     
+ tBodyAcc-mad()-Y                    
+ tBodyAcc-mad()-Z                     
+ tBodyAcc-max()-X                    
+ tBodyAcc-max()-Y                     
+ tBodyAcc-max()-Z                    
+ tBodyAcc-min()-X                     
+ tBodyAcc-min()-Y                    
+ tBodyAcc-min()-Z                     
+ tBodyAcc-sma()                      
+ tBodyAcc-energy()-X                  
+ tBodyAcc-energy()-Y                 
+ tBodyAcc-energy()-Z                 
+ tBodyAcc-iqr()-X                    
+ tBodyAcc-iqr()-Y                    
+ tBodyAcc-iqr()-Z                    
+ tBodyAcc-entropy()-X               
+ tBodyAcc-entropy()-Y                
+ tBodyAcc-entropy()-Z                
+ tBodyAcc-arCoeff()-X,1              
+ tBodyAcc-arCoeff()-X,2             
+ tBodyAcc-arCoeff()-X,3              

### Merging process

In the run_Analyisis.R file the training and test data sets are downloaded from the Dataset folder and then merged using the `rbind` function. Exactly the process takes place in the line 34 `COMPLETE <- rbind(TEST, TRAIN)`.


### Mean and Standard deviation information

In order to summarize the data the features `mean` and `std` in their names were etracted and added into a new data set called `COMPLETE_MEAN_STD`.

### Final analysis

Finally, a new dataset was created with the mean value of the features extracted before and grouped by the acivity_name and the subject_id.

The code is presented below:

`tidy_data_set <- group_by(COMPLETE_WITH_ACT, subject_id, activity_name) %>% summarise_all(.funs = mean)`.



