# -*- coding: utf-8 -*-
"""
Created on Thu Apr 23 21:45:36 2020

@author: lenovo
"""


import numpy as np
import pandas as pd
data=pd.read_csv("C:\\Users\\lenovo\\Desktop\\heart.csv",encoding="utf-8")
  
#数据集按瓜好坏分类
dataMat = np.mat([data['tobacco'].tolist(),data['ldl'].tolist(),data['age'].tolist()]).T

X0 = np.array(dataMat[0:302])
X1 = np.array(dataMat[302:462])
#求正反例均值
miu0 = np.mean(X0, axis=0).reshape((-1, 1))
miu1 = np.mean(X1, axis=0).reshape((-1, 1))
#求协方差
cov0 = np.cov(X0, rowvar=False)
cov1 = np.cov(X1, rowvar=False)
#求出w
S_w = np.mat(cov0 + cov1)
S_b = np.dot((miu0-miu1),(miu0-miu1).T)

Omiga = S_w.I * (miu0 - miu1)

Omiga_st=Omiga/pow(np.dot(Omiga.T,Omiga)[0,0],0.5)
Omiga2=(np.mat((0.61,-0.45,0.65))).T

J1=np.dot(np.dot(Omiga_st.T,S_b),Omiga_st)/np.dot(np.dot(Omiga_st.T,S_w),Omiga_st)

J2=np.dot(np.dot(Omiga2.T,S_b),Omiga2)/np.dot(np.dot(Omiga2.T,S_w),Omiga2)

print('miu0',miu0,'\n','miu1',miu1)

print('cov0',cov0,'\n','cov1',cov1)
print(J1,J2)