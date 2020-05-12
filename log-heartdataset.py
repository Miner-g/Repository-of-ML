# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.linear_model import LogisticRegression

###使用老师视频中的方法
'''
heart=pd.read_csv("C:\\Users\\lenovo\\Desktop\\heart.csv",encoding="utf-8")
le=LabelEncoder()
ones=[1 for i in range(462)]
y=le.fit_transform(heart['chd'].tolist())
X=np.mat([heart['tobacco'].tolist(),heart['ldl'].tolist(),heart['age'].tolist(),ones]).T

clf=LogisticRegression(random_state=0).fit(X,y)
print(clf.intercept_,clf.coef_)
print(clf.score(X, y))
'''
###编程实现逻辑回归并用梯度下降算法求解

def sigmoid(x):
    return 1 / (1 + np.exp(-x))


def parse_data():
    data = pd.read_csv("C:\\Users\\lenovo\\Desktop\\heart.csv",encoding="utf-8")
    
    dataMat = np.mat([data['tobacco'].tolist(),data['ldl'].tolist(),data['age'].tolist()]).T
    classLabels = np.mat([data['chd'].tolist()]).T
    dataMat = np.insert(dataMat, 0, 1, axis=1)
    return dataMat, classLabels


def loss_funtion(dataMat, classLabels, weights):
    m, n = np.shape(dataMat)
    loss = 0.0
    for i in range(m):
        sum_theta_x = 0.0
        for j in range(n):
            sum_theta_x += dataMat[i, j] * weights.T[0,j]
        propability = sigmoid(sum_theta_x)
        loss += -classLabels[0,i] * np.log(propability) - (1 - classLabels[0,i]) * np.log(1 - propability)
    return loss


def grad_descent(dataMatIn, classLabels):
    dataMatrix = np.mat(dataMatIn)  #(m,n)
    labelMat = np.mat(classLabels).T
    m, n = np.shape(dataMatrix)
    
    weights=np.zeros((n,1))
    alpha = 0.00001
    maxstep = 2000
    eps = 0.001
    count = 0
    loss_array = []

    for i in range(maxstep):
        loss = loss_funtion(dataMatrix, labelMat, weights)

        h_theta_x = sigmoid(dataMatrix.dot(weights))
        e = h_theta_x - labelMat.T
        new_weights = weights - alpha * (dataMatrix.T).dot(e)
         
        new_loss = loss_funtion(dataMatrix, labelMat, new_weights)
        loss_array.append(new_loss)
        if abs(new_loss - loss) < eps:
            break
        else:
            weights = new_weights
            count += 1

    print ("count is: ", count)
    print ("loss is: ", loss)
    print ("weights is: ", weights)
    return weights, loss_array

data, labels = parse_data()
r, loss_array = grad_descent(data, labels)


