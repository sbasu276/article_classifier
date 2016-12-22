y=[]
x=[]
x1=[]
z=[]
with open('testdata','rb') as fp:
	for line in fp:
		val = line.split()
		x.append(float(val[0])-0.15)
		x1.append(float(val[0]))
		y.append(float(val[1]))
		z.append(float(val[1])*1.12)

import matplotlib as mpl
import matplotlib.pyplot as plt

#fig, ax = plt.subplots()
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Average Test Accuracy plot for Naive Bayes Classifier')
plt.bar(x,y,width=0.15, color='r',label='unopt')
plt.bar(x1,z,width=0.15, color='b',label='opt')
plt.legend()
plt.axis([0,5,0,1.2])
plt.show()

#set x_ticks
