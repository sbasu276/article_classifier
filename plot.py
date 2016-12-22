lst=[]
with open('AvgAcc.dat','rb') as fp:
	for line in fp:
		val = line.split('\t')
		lst.append(val)

y=map(float, lst[0])
i=0
while i<5:
	y[i] = y[i]*100.0
	i = i+1

x = [1000,2000,3000,4000,5784]
import matplotlib as mpl
import matplotlib.pyplot as plt
fig, ax = plt.subplots()
plt.xlabel('Training Data Size')
plt.ylabel('Accuracy(%)')
plt.title('Average Test Accuracy plot for Naive Bayes Classifier')
plt.plot(x,y, 'ms-', linewidth=2)
plt.axis([0,6000,80,100])
plt.show()
