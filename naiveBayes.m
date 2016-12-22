%-------------------------------------------------------------------------
%   Implementation of Naive Bayes Classifier for Article Classification
%   Programmer : SOUMEN BASU
%   Entry No.  : 2013MCS2584
%-------------------------------------------------------------------------


%   tf[][] stores the term-frequency matrix in sparse format
%   tf[i][j] = k : denotes that the j-th word in vocabulary occurs k-times
%   in i-th article
%   tf[i][LAST_COLUMN] : this is a special entry, which stores the class
%   of the article

clear; % Clear workspace
load('tf.mat'); % Load the tf-matrix saved in sparse format
numArticle = size(tf,1); % Number of Rows in tf-matrix = number of articles
numWord = size(tf,2)-1; % Number of columns in tf-matrix - 1 = vocabulary size
numClass = max(tf(:,numWord+1)); % Number of article classes = Max value in tf[][LAST_COLUMN]

trainSize = numArticle*0.8; % Specify train-size for 5-fold cross validation 
testSetSize = numArticle/5; % Specify test-size for 5 fold cross validation
data = tf(randperm(numArticle) , :); % arrange the tf-matrix rows into random order

save('data.mat');
clearvars tf; % Free the space of tf[][] since we will work with data[][]
startIdx = 1;

testAccuracy = zeros(5,5);

%   Iterating over the randomly split data set for 5 fold testing
crossIdx = 1;
while crossIdx <= 5
    
    testData = data(startIdx:testSetSize+startIdx-1 , :); % Load Test data 
 
    % Load Train data = {data - test data}
    if crossIdx == 1
        trainData = data(testSetSize+1:numArticle , :); 
    elseif crossIdx == 5
        trainData = data(1:trainSize , :);
    else
        trainData = [data(1:startIdx-1 , :) ; data(testSetSize+startIdx:numArticle , :)];
    end
    
    
    for trainIdx = 1:5
       
        if trainIdx == 5
            trainSetSize = trainSize ; %--- for trainSetSize 1000-4000,5784
        else
            trainSetSize = trainIdx*1000;
        end
        
        
        prior = zeros(numClass,1);  %   prior[i] : denotes P(Class = i-thClass)
        likelihood = zeros(numClass,numWord);    
        % likelihood[i][j] : P(j-thWord | i-thClass) 
        
         %Calculate prior & likelihood
        for i = 1:numClass
            Nc = nnz(trainData(1:trainSetSize,numWord+1) == i);
            prior(i) = Nc+1 / trainSetSize+1;         
            sumVec = zeros(1,numWord);
            for j = 1:trainSetSize
                if trainData(j,numWord+1) == i
                    sumVec = sumVec + trainData(j,1:numWord);   % Number of occurrences of Words in Class-i
                end
            end
            V = sum(sumVec, 2);
            likelihood(i,:) = (sumVec+1) / (V+numWord) ; % Laplace Smoothing
        end
        
        clearvars sumVec;
        clearvars V;
        clearvars Nc;
        
        % Conducting the test by the use of Naive Bayes Classifier    
        testResult = zeros(testSetSize,2);
        for i = 1:testSetSize
            I = find(testData(i,1:numWord));
            [~,M] = size(I);
            posterior = zeros(numClass,1);
            for c = 1:numClass
                posterior(c) = log2(prior(c));
                for j = 1:M
                    jj = I(j);
                    posterior(c) = posterior(c) + testData(i,jj)*log2(likelihood(c,jj));
                end
           
            end
        
            [~, predictedClass] = max(posterior);
            testResult(i,1) = predictedClass ; 
            testResult(i,2) = testData(i,numWord+1);
        end
         
        A = nnz(testResult(:,1)==testResult(:,2))/testSetSize;

        testAccuracy(crossIdx,trainIdx) = A;
        %testAccuracy
        
        confusion_m = zeros(8,8);
        for i=1:testSetSize
            ii=testResult(i,2); %   Actual class
            jj=testResult(i,1); %   Predicted class
            confusion_m(ii,jj) = confusion_m(ii,jj)+1;
        end
        confusion_m
        
    end
    startIdx = startIdx + testSetSize;
    crossIdx = crossIdx+1;
end
AvgAcc = sum(testAccuracy,1)/5;
dlmwrite('AvgAcc.dat',AvgAcc,'\t');
save('testAccuracy.mat');
dlmwrite('test.dat',testAccuracy,'\t');


