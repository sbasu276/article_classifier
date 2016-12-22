articleList = []
numArticle = 0
wordList = []
string = []
with open('./20ng-rec_talk.txt','r') as fp:
    for line in fp:

	numArticle = numArticle + 1
	string = line.split()
	print string 
	
	if string[0] not in articleList:
		articleList.append(string[0])
	i = 1
	N = len(string)
	while i<N:
		if string[i] not in wordList:
			wordList.append(string[i])
		i = i + 1

fp.close()

fo1 = open('./wordList.txt','w')
fo2 = open('./classList.txt','w')
for item in wordList:
	print>>fo1, item
for item in articleList:
	print>>fo2, item

fo1.close()
fo2.close()

C=len(wordList)
tf = [[0 for x in xrange(C+1)] for x in xrange(numArticle)]

numArticle = 0
with open('./20ng-rec_talk.txt','r') as fp:
    for line in fp:
	string = line.split()
	print '\nProcessing line '; print (numArticle+1)
	k = 1	
	N = len(string)
	while k<N:
		if string[k] in wordList:
			j=wordList.index(string[k])
			tf[numArticle][j] = tf[numArticle][j] + 1
		k = k + 1
	tf[numArticle][C] = articleList.index(string[0]) + 1
	numArticle = numArticle + 1

print '\n All Processing Done, Saving Tf-Matrix ...'

from scipy import sparse
T = sparse.csr_matrix(tf)
import scipy.io
scipy.io.savemat('./tf.mat', mdict={'tf': T})

print '\nTf-Matrix saved' 



