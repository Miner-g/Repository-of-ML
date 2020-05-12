# -*- coding: utf-8 -*-
"""
Created on Wed May  6 17:12:16 2020

@author: lenovo
"""
from pandas import read_csv
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import confusion_matrix,precision_score
from sklearn.metrics import accuracy_score,recall_score,f1_score
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis

f=open(r'C:\Users\lenovo\Desktop\boston_house_prices.csv',encoding='UTF-8')
boston=read_csv(f,names=["INDUS","CHAS","NOX","RM","AGE","DIS","MEDV","CLASS"])

from sklearn.multiclass import OneVsOneClassifier
from sklearn.multiclass import OutputCodeClassifier


le=LabelEncoder()
y=le.fit_transform(boston["CLASS"].tolist())
X=np.mat([boston["INDUS"].tolist(),boston["CHAS"].tolist(),
          boston["NOX"].tolist(),boston["RM"].tolist(),
          boston["AGE"].tolist(),boston["DIS"].tolist()]).T

"INDUS","CHAS","NOX","RM","AGE","DIS","MEDV","CLASS"
clf=LinearDiscriminantAnalysis()
ovo=OneVsOneClassifier(clf)
ovo.fit(X,y)
print(ovo.score(X,y))
#print(ovo.fit(X,y).predict(X))


mvm=OutputCodeClassifier(clf)
mvm.fit(X,y)
print(mvm.score(X,y))
#print(mvm.fit(X,y).predict(X))


