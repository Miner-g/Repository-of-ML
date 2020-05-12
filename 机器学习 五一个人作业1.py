 # -*- coding: utf-8 -*-
"""
Created on Tue May  5 12:02:33 2020

@author: lenovo
"""
import numpy as np
import pandas as pd
from sklearn.utils import shuffle
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import confusion_matrix,precision_score,accuracy_score,recall_score,f1_score
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

x1=np.random.multivariate_normal([3,6],[[0.5,0],[0,2]],1000)
x2=np.random.multivariate_normal([3,-2],[[2,0],[0,2]],1000)


#画散点图
fig = plt.figure()
ax1 = plt.axes(projection='3d')

ax1.scatter3D(x1[:,0],x1[:,1],np.repeat(0,1000),cmap='Blues')
ax1.scatter3D(x2[:,0],x1[:,1],np.repeat(1,1000),cmap='Reds')


##构建一个dataframe，有2000行数据，每类1000
x3=x1.tolist()
x3.extend(x2.tolist())

data=pd.DataFrame(x3,columns=["1","2"])
classcol=np.zeros(1000).tolist()+np.ones(1000).tolist()
data["class"]=classcol
data = shuffle(data)


#预处理
le=LabelEncoder()
y=le.fit_transform(data["class"].tolist())
X=np.mat([data["1"].tolist(),data["2"].tolist()]).T
#求μ
miu0 = np.mean(x1, axis=0).reshape((-1, 1))
miu1 = np.mean(x2, axis=0).reshape((-1, 1))
#求协方差
cov0 = np.cov(x1, rowvar=False)
cov1 = np.cov(x2, rowvar=False)


#开始LDA
clf=LinearDiscriminantAnalysis()
clf.fit(X,y)
y_pred=clf.predict(X)
C2=confusion_matrix(y,y_pred,labels=[0,1])
print(C2)
print(accuracy_score(y,y_pred),precision_score(y,y_pred),recall_score(y,y_pred),f1_score(y,y_pred))

#下面开始按计算公式算系数和x0
cov=np.cov(np.vstack((x1,x2)),rowvar=False)

w=np.dot(np.matrix(cov).I,(miu0-miu1))
x0=0.5*(miu0+miu1)

#print(w,x0)

#定义三维数据
xx = np.arange(0,10,0.1)
yy = np.arange(0,10,0.1)
X1, Y1 = np.meshgrid(xx, yy)
Z1=np.arange(10000).reshape(100,100)

for m in range(100):
    for n in range(100):
        Z1[m][n] = np.array(np.dot(np.array([X1[m][n],Y1[m][n]])-x0,w))[0]
        if Z1[m][n] > 0.5:
            Z1[m][n] = 0
        else:
            Z1[m][n] = 1
#作图
ax1.plot_surface(X1,Y1,Z1,)



#Fisher判别法
 
S_w = np.mat(cov0 + cov1)
S_b = np.dot((miu0-miu1),(miu0-miu1).T)

Omiga = S_w.I * (miu0 - miu1)   ##求出欧米伽

Omiga0=-0.5*np.diag(np.dot(Omiga.T,(miu0+miu1)/2))

y_fisher_pred=np.dot(X,Omiga)+np.repeat(Omiga0,2000)

y_fisher_pred=y_fisher_pred[:,0].tolist()
    
for i in range(2000):
    if y_fisher_pred[i][0] > 0.5:
        y_fisher_pred[i] = 0
    else:
        y_fisher_pred[i] = 1

C3=confusion_matrix(y,y_fisher_pred,labels=[0,1])

#print(Omiga,Omiga0)
print(C3)
print(accuracy_score(y,y_fisher_pred),precision_score(y,y_fisher_pred),recall_score(y,y_fisher_pred),f1_score(y,y_fisher_pred))

#作图
Z2=np.arange(10000).reshape(100,100)

for m in range(100):
    for n in range(100):
        Z2[m][n] = np.array(np.dot(np.array([X1[m][n],Y1[m][n]]),w))[0]+Omiga0
        if Z2[m][n] > 0.5:
            Z2[m][n] = 0
        else:
            Z2[m][n] = 1
    

ax1.plot_surface(X1,Y1,Z2)
plt.show()

