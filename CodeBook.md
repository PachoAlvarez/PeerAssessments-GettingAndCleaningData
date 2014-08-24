CodeBook for PeerAssessments-GettingAndCleaningData

SCRIPT: run_Analysis.R

In addition to the original information in the ICU HAR Dataset folder, the files (1) README.txt and (2) features_info.txt, the necessary information about the variables handled and reported as follows:

In the output folder "data", these files appear: 
1. merged_data.txt    = train data + test data
2. extracted_data.txt = only means and standard deviation for each measurement
3. average_data       = the average of each variable for each activity and each subject
4. README.txt         = contains the above information about the three files
 
In step No. 8 of the analysis, a new variable: "origin", the set of which came this record is recorded if it was "train" or was "test", is added.

Generated in step No. 9 analysis, shared database of data {train} and {test}, with 564 variables, all described in the file (2) features_info.txt above, and 10,300 records.
Here the only new variable is "origin".
This database is reported as "merged_data.txt"

In step No. 10, from the previous database, the variables relate to the average values of the measured properties, and their standard deviations are extracted.
This extracted database, containing 88 variables, and the same 10,300 records, is reported as "extracted_data.txt"

Finally, in step 11, summarize the 10,300 records in the 180 records resulting from averaging all observations by activity and person executor of the activity.
The latter database, with the average is stored in the "average_data.txt" file, as indicated in the assignment.
