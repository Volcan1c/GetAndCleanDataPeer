# How does the script work?

This script is supposed to be executed after the following files are in the "UCI HAR Dataset" folder:
X_test.txt, X_train.txt, y_test.txt, y_train.txt, subject_test.txt, subject_train.txt, features.txt.
The library dplyr is also required to be installed.

The script begins by reading the text files and assign the data to data.table variables.
Then it merges the test and train sets by row and adds the variable names 
(from the features.txt file) that describe the various measurements.

The only variables we need are the means and standard deviations (arguably the meanfreq too).
We procced to select those variables but due to identical variable names an error occurs.
To overcome this, we delete those identical variables (they are not needed anyway).
Then we continue to select the variables as planed. (Using a regular expression I select
only the names that contain mean or std, creating a logical vector.)

The next step is to add the activities and subject numbers. We merge them with our dataset by column.
We swap the activity number identifiers with their respective name.
Then the script does some changes to the variable names to make them more descriptive and easy to opperate.

Finally, we group our data by subject number and activity in order to calculate the means needed.
We use the summarise_each() function (excluding the first two columns) to calculate the mean 
for each subject and each activity. We then extract our new tidy data set using the write.table() function.

All of the above can be done in a function, but it is a very specific task and its reproducible value is little.
<p>Variables used:</p>
<p>test: The test part of the research.</p>
<p>train: The train part of the research.</p>
<p>test2: The activity IDs for test.</p>
<p>train2: The activity IDs for train.</p>
<p>testsub, trainsub: The subject IDs.</p>
<p>feat: The variable names.</p>
<p>fulld: The full set of data.</p>
<p>delet: The indices of the names causing the error.</p>
<p>fulldc: The full and clean set of data.</p>
<p>logi: The logical vector (TRUE contains mean or std).</p>
<p>meanstd: The new data set containing only means and St.Ds.</p>
<p>fullact, fullsub: Merged activity and subject IDs.</p>
<p>grbysub: meanstd grouped by Subject and activity.</p>
<p>r_analysis: The final data set required by the assignment.</p>
