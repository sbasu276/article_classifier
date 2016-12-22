# article_classifier

This repository contains code for a news paper article classifier.

1. Run "python preprocess.py" it will take 8-10 minutes to complete

2. The class names are stored in "classList.txt" and the list of unique words are stored in "wordList.txt"

3. Now the TF matrix is stored in "tf.mat" 

4. Open Matlab and type "naiveBayes" in the command line. Make sure that the "naiveBayes.m" and "tf.mat" files are in Matlab's working directory.

5. The random split is stored in "data.mat" 

6. The test accuracy results are given in "test.csv" 

7. The average accuracy is stored in "AvgAcc.dat"

8. The confusion matrices are displayed in screen, copy them to a seperate file for later analysis.

9. On an average, 1st (rec.autos) and 2nd (rec.motorcycles) classes are having the highest diagonal entry in confusion matrix. This means, these two classes are least confused.

10. The rows in the confusion matrix denotes the actual class and the columns denote the predicted class.

11. The highest non-diagonal entry is (7,5). The 7th (talk.politics.misc) class is most confused with 5th(talk.politics.guns) class.

12. Run "python plot.py" it will show the Accuracy vs. Train data size plot.
