# Run analysis

First we nead to load the data into our workbook.
I have sored the data into the following files: "x.test", "y.test", "subject.test", "x.train", "y.train", "subject.train", "features", "activityLabels".
This time I set the column names of the test and train data's.
then I merged the test and train data's into seperate variables named "mrg_test", "mrg_train" with cbind command.
Now, with the help of rbind command I merged this two variable into another called "allInOne".

here my first task is done. Merging the data.

secondly I had to seperate the columns with mean and std with it.
so first I set the column names into a variable named "colNames"
then I used grepl command to identify which variables has "mean" and "std" with it. It returned a logical vector.
Now it's time to create a subset, where there are "subjectId","activityId" and the variables with mean and std in it. I named the subset "setForMeanAndStd".

my second task is done.

Now I have to make a tidy data...

For this I merged the subset with "activityLabels" by activityId.
here I used dplyr package to arrange the subjectId and activityId ,
then grouped it by subjectId and activityId, and lastly used summarise_all(list(mean)) to apply summarise to multiple columns and stored it in "tidydata"

And my tidy data is ready.


