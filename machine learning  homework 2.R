fishing <- read.xlsx("C:\\Users\\lenovo\\Desktop\\fishing.xlsx",sheet=1)

trainingset_model1<- fishing[which(fishing$��֤��==1),6:7]
trainingset_model2<- fishing[which(fishing$��֤��==1),c(6,8)]
testset_model1<- fishing[which(fishing$��֤��==2),6:7]
testset_model2<- fishing[which(fishing$��֤��==2),c(6,8)]

for (i in 1:175)
{
  division=trainingset_model1[i,2]
  
  trainingset_model1$judge=trainingset_model1[,2]>=division
  trainingset_model1$TRAIN_M1_P[i]=sum(trainingset_model1$�Ƿ������==1&trainingset_model1$judge)    /sum(trainingset_model1$judge==T)
  trainingset_model1$TRAIN_M1_R[i]=sum(trainingset_model1$�Ƿ������==1&trainingset_model1$judge)    /sum(trainingset_model1$�Ƿ������)
  trainingset_model1$TRAIN_M1_FPR[i]=sum(trainingset_model1$�Ƿ������==0&trainingset_model1$judge)    /(175-sum(trainingset_model1$�Ƿ������))
}
plot(trainingset_model1$TRAIN_M1_R,trainingset_model1$TRAIN_M1_P,xlab="trainingset_model1_R",ylab="trainingset_model1_P",main="trainingset_model1  P-R")
#plot(trainingset_model1$TRAIN_M1_FPR,trainingset_model1$TRAIN_M1_R,xlab="trainingset_model1_FPR",ylab="trainingset_model1_R",main="trainingset_model1  ROC")

for (i in 1:175)
{
  division=trainingset_model2[i,2]
  
  trainingset_model2$judge=trainingset_model2[,2]>=division
  trainingset_model2$TRAIN_M2_P[i]=sum(trainingset_model2$�Ƿ������==1&trainingset_model2$judge)    /sum(trainingset_model2$judge==T)
  trainingset_model2$TRAIN_M2_R[i]=sum(trainingset_model2$�Ƿ������==1&trainingset_model2$judge)    /sum(trainingset_model2$�Ƿ������)
  trainingset_model2$TRAIN_M2_FPR[i]=sum(trainingset_model2$�Ƿ������==0&trainingset_model2$judge)    /(175-sum(trainingset_model2$�Ƿ������))
}
plot(trainingset_model2$TRAIN_M2_R,trainingset_model2$TRAIN_M2_P,xlab="trainingset_model2_R",ylab="trainingset_model2_P",main="trainingset_model2  P-R")

for (i in 1:75)
{
  division=testset_model2[i,2]
  
  testset_model2$judge=testset_model2[,2]>=division
  testset_model2$TEST_M2_P[i]=sum(testset_model2$�Ƿ������==1&testset_model2$judge)    /sum(testset_model2$judge==T)
  testset_model2$TEST_M2_R[i]=sum(testset_model2$�Ƿ������==1&testset_model2$judge)    /sum(testset_model2$�Ƿ������)
  testset_model2$TEST_M2_FPR[i]=sum(testset_model2$�Ƿ������==0&testset_model2$judge)    /(75-sum(testset_model2$�Ƿ������))
}
plot(testset_model2$TEST_M2_R,testset_model2$TEST_M2_P,xlab="testset_model2_R",ylab="testset_model2_P",main="testset_model2  P-R")

for (i in 1:75)
{
  division=testset_model1[i,2]
  
  testset_model1$judge=testset_model1[,2]>=division
  testset_model1$TEST_M1_P[i]=sum(testset_model1$�Ƿ������==1&testset_model1$judge)    /sum(testset_model1$judge==T)
  testset_model1$TEST_M1_R[i]=sum(testset_model1$�Ƿ������==1&testset_model1$judge)    /sum(testset_model1$�Ƿ������)
  testset_model1$TEST_M1_FPR[i]=sum(testset_model1$�Ƿ������==0&testset_model1$judge)    /(75-sum(testset_model1$�Ƿ������))
}
plot(testset_model1$TEST_M1_R,testset_model1$TEST_M1_P,xlab="testset_model1_R",ylab="testset_model1_P",main="testset_model1  P-R")


roc(trainingset_model1$�Ƿ������,trainingset_model1$`ģ��1Ԥ��ֵ:.����`,legacy.axes=T,main="trainingset_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(trainingset_model2$�Ƿ������,trainingset_model2$`ģ��2Ԥ��ֵ:.����`,legacy.axes=T,main="trainingset_model2  ROC",plot=T,print.thres=T,print.auc=T)

roc(testset_model1$�Ƿ������,testset_model1$`ģ��1Ԥ��ֵ:.����`,legacy.axes=T,main="testset_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(testset_model2$�Ƿ������,testset_model2$`ģ��2Ԥ��ֵ:.����`,legacy.axes=T,main="testset_model2  ROC",plot=T,print.thres=T,print.auc=T)

model1_cut=3.335
model2_cut=1.138
testset_model1$gg1=as.integer(testset_model1$`ģ��1Ԥ��ֵ:.����`>=model1_cut)
table(testset_model1$�Ƿ������,testset_model1$gg1)   #����һ�б�ʾʵ��ֵ������һ�б�ʾԤ��ֵ

testset_model2$gg2=as.integer(testset_model2$`ģ��2Ԥ��ֵ:.����`>=model2_cut)
table(testset_model2$�Ƿ������,testset_model2$gg2)   #����һ�б�ʾʵ��ֵ������һ�б�ʾԤ��ֵ

#testset_model1 CC
for (i in 1:75){
  if(i ==1)
  plot(c(0,1),c(testset_model1$TEST_M1_FPR[i],1-testset_model1$TEST_M1_R[i]),type="l",xlab="�������ʴ���",ylab="��һ������",main="testset_model1 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(testset_model1$TEST_M1_FPR[i],1-testset_model1$TEST_M1_R[i]),type="l")
}
#testset_model2 CC
for (i in 1:75){
  if(i ==1)
    plot(c(0,1),c(testset_model2$TEST_M2_FPR[i],1-testset_model2$TEST_M2_R[i]),type="l",xlab="�������ʴ���",ylab="��һ������",main="testset_model2 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(testset_model2$TEST_M2_FPR[i],1-testset_model2$TEST_M2_R[i]),type="l")
}

#ͨ���Ƚϣ���֪ģ��1�������������С��ģ�Ͷ�


#PART TWO
handwriting <- read.xlsx("C:\\Users\\lenovo\\Desktop\\��д������.xlsx",sheet=1)

roc(handwriting$���ݱ�ǩ,handwriting$ģ��1Ԥ��,legacy.axes=T,main="handwring_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(handwriting$���ݱ�ǩ,handwriting$ģ��2Ԥ��,legacy.axes=T,main="handwring_model2  ROC",plot=T,print.thres=T,print.auc=T)

roc(handwriting$���ݱ�ǩ,handwriting$ģ��3Ԥ��,legacy.axes=T,main="handwring_model3  ROC",plot=T,print.thres=T,print.auc=T)

moxing_cut=c(0.572,0.618,0.394)


tp=rep(0,30)
fp=rep(0,30)
fn=rep(0,30)
p=rep(0,30)
r=rep(0,30)
k=1
for(i in 1:3){
  for(j in 1:5){
    
    tp[k]=sum(handwriting[,j+1]==2&handwriting$���ݱ�ǩ==1&handwriting[,i+6]>=moxing_cut[i])
    fp[k]=sum(handwriting[,j+1]==2&handwriting$���ݱ�ǩ==0&handwriting[,i+6]>=moxing_cut[i])
    fn[k]=sum(handwriting[,j+1]==2&handwriting$���ݱ�ǩ==1&handwriting[,i+6]<moxing_cut[i])
    
    p[k]=tp[k]/(tp[k]+fp[k])
    r[k]=tp[k]/(tp[k]+fn[k])
   
    k=k+1
    
    tp[k]=sum(handwriting[,j+1]==1&handwriting$���ݱ�ǩ==1&handwriting[,i+6]>=moxing_cut[i])
    fp[k]=sum(handwriting[,j+1]==1&handwriting$���ݱ�ǩ==0&handwriting[,i+6]>=moxing_cut[i])
    fn[k]=sum(handwriting[,j+1]==1&handwriting$���ݱ�ǩ==1&handwriting[,i+6]<moxing_cut[i])
    
    p[k]=tp[k]/(tp[k]+fp[k])
    r[k]=tp[k]/(tp[k]+fn[k])
    k=k+1
  }
}
model_macro_P=rep(0,3)
model_macro_R=rep(0,3)
model_micro_P=rep(0,3)
model_micro_R=rep(0,3)
for(k in 1:3){
  i=k*10-9
  model_macro_P[k]=sum(p[i:(i+9)])/10
  model_macro_R[k]=sum(r[i:(i+9)])/10
  
  model_micro_P[k]=mean(tp[i:(i+9)])/(mean(tp[i:(i+9)])+mean(fp[i:(i+9)]))
  model_micro_R[k]=mean(tp[i:(i+9)])/(mean(tp[i:(i+9)])+mean(fn[i:(i+9)]))
}

##����������������
for (i in 1:479)
{
  division=handwriting[i,7]
  
  handwriting$judge1=handwriting[,7]>=division
  handwriting$M1_R[i]=sum(handwriting$���ݱ�ǩ==1&handwriting$judge1)/sum(handwriting$���ݱ�ǩ)
  handwriting$M1_FPR[i]=sum(handwriting$���ݱ�ǩ==0&handwriting$judge1)/sum(479-sum(handwriting$���ݱ�ǩ))
  
}

for (i in 1:479)
{
  division=handwriting[i,8]
  
  handwriting$judge2=handwriting[,8]>=division
  handwriting$M2_R[i]=sum(handwriting$���ݱ�ǩ==1&handwriting$judge2)/sum(handwriting$���ݱ�ǩ)
  handwriting$M2_FPR[i]=sum(handwriting$���ݱ�ǩ==0&handwriting$judge2)/sum(479-sum(handwriting$���ݱ�ǩ))
}

for (i in 1:479)
{
  division=handwriting[i,9]
  
  handwriting$judge3=handwriting[,9]>=division
  handwriting$M3_R[i]=sum(handwriting$���ݱ�ǩ==1&handwriting$judge3)/sum(handwriting$���ݱ�ǩ)
  handwriting$M3_FPR[i]=sum(handwriting$���ݱ�ǩ==0&handwriting$judge3)/sum(479-sum(handwriting$���ݱ�ǩ))
}

for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M1_FPR[i],1-handwriting$M1_R[i]),type="l",xlab="�������ʴ���",ylab="��һ������",main="handwriting_model1 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M1_FPR[i],1-handwriting$M1_R[i]),type="l")
}

for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M2_FPR[i],1-handwriting$M2_R[i]),type="l",xlab="�������ʴ���",ylab="��һ������",main="handwriting_model2 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M2_FPR[i],1-handwriting$M2_R[i]),type="l")
}
for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M3_FPR[i],1-handwriting$M3_R[i]),type="l",xlab="�������ʴ���",ylab="��һ������",main="handwriting_model3 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M3_FPR[i],1-handwriting$M3_R[i]),type="l")
}


#���������
thetaC=rep(0,5) 
thetaB=rep(0,5)
for(i in 1:5){
  thetaC[i]=sum(handwriting[,i+1]==2&((handwriting$���ݱ�ǩ==1&handwriting$ģ��3Ԥ��>=0.394)|(handwriting$���ݱ�ǩ==0&handwriting$ģ��3Ԥ��<0.394)))/99
  
  
}

for(i in 1:5){
  thetaB[i]=sum(handwriting[,i+1]==2&((handwriting$���ݱ�ǩ==1&handwriting$ģ��2Ԥ��>=0.618)|(handwriting$���ݱ�ǩ==0&handwriting$ģ��2Ԥ��<0.618)))/99
  
  
}

miu=mean(thetaB-thetaC)
sigma=sd(thetaB-thetaC)

print(miu*sqrt(5)/sigma)











