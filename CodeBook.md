# Background

The data are divided into several *.txt files which are described as follows:

#### activity_labels.txt

A file containing two columns and 6 records. The first column is an activity code as used in the rest of the data, the second column is the description of the action represented by the activity code.

There are six different activities:

 

| **activity code** | **activity label** |
| ----------------: | ------------------ |
|                 1 | Walking            |
|                 2 | Walking upstairs   |
|                 3 | Walking downstairs |
|                 4 | Sitting            |
|                 5 | Standing           |
|                 6 | Laying             |



#### features.txt

A file containing a list of all of the feature names for the measurement data. There are 561 features in total.

### Measurement data

The measurement data are split into two directories `train` and `test`. Each of these directories contains three files, a file with subject data, a file with measurement data, and a file with activity data.

#### subject_test.txt / subject_train.txt

This file contains the subject id linked to each of the measurements. There are 2947 entries in the test data, and 7352 entries in the train data (10299 total).

The data set contains info on 30 subject, so the subject ids range from 1:30.

#### X_test.txt / X_train.txt

This file contains all of the measurement data. Each column is separated by whitespace and is linked to a feature name in `features.txt`. All of the values are numeric and there are no missing values. There are 2947 x 561 entries in the test data, and 7352 x 561 entries in the train data (10299 x 561 total).

The data are normalized (range -1:1) and already summarized into variables based on the following functions:

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

More information about each of these measurements can be found in `features_info.txt`.

#### Y_test.txt / Y_train.txt

This file contains the activity code for each of the measurements. These codes correspond to the codes in `activity_labels.txt`. There are 2947 entries in the test data, and 7352 entries in the train data (10299 total).

# Goals

The goal of this analysis is to obtain a single, tidy dataset that contains all of the test and training data. The data should be correctly labelled and each observation should be attributable to a specific person (by subject id) and activity (by activity name).

Only the variables with regards to *mean* and *standard deviation* are of interest.

# Method

In order to get from the data in separate files and directories to one tidy data set, the following steps are performed:

1. Read the measurement data from the `/train` and `/test` directories and combine them with the feature names as well as the subject ids
2. Remove the variables that are not related to mean or standard deviation
3. Label each observation with the appropriate activity name
4. Find the mean of each variable, when the data are grouped by subject and activity

#### Combine train and test data

This step is divided into the following sub-steps

1. Read the feature names from `features.txt`
2. Read the measurements data (train and test), using the feature names as column names
3. Read the activity data (train and test) and label it as `activityCode`
4. Read the subject data (train and test) and label it as `subjectId`
5. Combine the train and test measurements data
6. Combine the train and test activity data
7. Combine the train and test subject data
8. Combine the subject, activity, and measurements data into one dataframe (called `sensorData`)

#### Use only the columns relating to mean and standard deviation

First filter the `sensorData` column names and keep only those containing either the word "mean" or "std". Then select these column names as well as the `subjectId` and `activityCode`

#### Replace the activity codes with activity names

First read the activity names from the file `activity_labels.txt`. Add a column `activityLabel` to the `sensorData` dataframe that contains the correct activity name for each corresponding activity code. Finally, drop the `activityCode` column from the dataframe and reorder the columns so the `subjectId` column is first and the `activityLabel` column is second, followed by all the rest of the measurements data.

#### Find the mean of each variable, by subject and activity

First create a data table from the dataframe, this will allow for easier group by operations. Then group by `subjectId` and `activityLabel`. Finally, summarize each variable by calling the `summarise_all()` function and assigning the result to a new variable.

This new variable is then written to a file `sensor_summary.txt`.
