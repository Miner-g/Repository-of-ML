fishing <- read.xlsx("C:\\Users\\lenovo\\Desktop\\fishing.xlsx",sheet=1)

trainingset_model1<- fishing[which(fishing$验证集==1),6:7]
trainingset_model2<- fishing[which(fishing$验证集==1),c(6,8)]
testset_model1<- fishing[which(fishing$验证集==2),6:7]
testset_model2<- fishing[which(fishing$验证集==2),c(6,8)]

for (i in 1:175)
{
  division=trainingset_model1[i,2]
  
  trainingset_model1$judge=trainingset_model1[,2]>=division
  trainingset_model1$TRAIN_M1_P[i]=sum(trainingset_model1$是否钓到鱼==1&trainingset_model1$judge)    /sum(trainingset_model1$judge==T)
  trainingset_model1$TRAIN_M1_R[i]=sum(trainingset_model1$是否钓到鱼==1&trainingset_model1$judge)    /sum(trainingset_model1$是否钓到鱼)
  trainingset_model1$TRAIN_M1_FPR[i]=sum(trainingset_model1$是否钓到鱼==0&trainingset_model1$judge)    /(175-sum(trainingset_model1$是否钓到鱼))
}
plot(trainingset_model1$TRAIN_M1_R,trainingset_model1$TRAIN_M1_P,xlab="trainingset_model1_R",ylab="trainingset_model1_P",main="trainingset_model1  P-R")
#plot(trainingset_model1$TRAIN_M1_FPR,trainingset_model1$TRAIN_M1_R,xlab="trainingset_model1_FPR",ylab="trainingset_model1_R",main="trainingset_model1  ROC")

for (i in 1:175)
{
  division=trainingset_model2[i,2]
  
  trainingset_model2$judge=trainingset_model2[,2]>=division
  trainingset_model2$TRAIN_M2_P[i]=sum(trainingset_model2$是否钓到鱼==1&trainingset_model2$judge)    /sum(trainingset_model2$judge==T)
  trainingset_model2$TRAIN_M2_R[i]=sum(trainingset_model2$是否钓到鱼==1&trainingset_model2$judge)    /sum(trainingset_model2$是否钓到鱼)
  trainingset_model2$TRAIN_M2_FPR[i]=sum(trainingset_model2$是否钓到鱼==0&trainingset_model2$judge)    /(175-sum(trainingset_model2$是否钓到鱼))
}
plot(trainingset_model2$TRAIN_M2_R,trainingset_model2$TRAIN_M2_P,xlab="trainingset_model2_R",ylab="trainingset_model2_P",main="trainingset_model2  P-R")

for (i in 1:75)
{
  division=testset_model2[i,2]
  
  testset_model2$judge=testset_model2[,2]>=division
  testset_model2$TEST_M2_P[i]=sum(testset_model2$是否钓到鱼==1&testset_model2$judge)    /sum(testset_model2$judge==T)
  testset_model2$TEST_M2_R[i]=sum(testset_model2$是否钓到鱼==1&testset_model2$judge)    /sum(testset_model2$是否钓到鱼)
  testset_model2$TEST_M2_FPR[i]=sum(testset_model2$是否钓到鱼==0&testset_model2$judge)    /(75-sum(testset_model2$是否钓到鱼))
}
plot(testset_model2$TEST_M2_R,testset_model2$TEST_M2_P,xlab="testset_model2_R",ylab="testset_model2_P",main="testset_model2  P-R")

for (i in 1:75)
{
  division=testset_model1[i,2]
  
  testset_model1$judge=testset_model1[,2]>=division
  testset_model1$TEST_M1_P[i]=sum(testset_model1$是否钓到鱼==1&testset_model1$judge)    /sum(testset_model1$judge==T)
  testset_model1$TEST_M1_R[i]=sum(testset_model1$是否钓到鱼==1&testset_model1$judge)    /sum(testset_model1$是否钓到鱼)
  testset_model1$TEST_M1_FPR[i]=sum(testset_model1$是否钓到鱼==0&testset_model1$judge)    /(75-sum(testset_model1$是否钓到鱼))
}
plot(testset_model1$TEST_M1_R,testset_model1$TEST_M1_P,xlab="testset_model1_R",ylab="testset_model1_P",main="testset_model1  P-R")


roc(trainingset_model1$是否钓到鱼,trainingset_model1$`模型1预测值:.钓鱼`,legacy.axes=T,main="trainingset_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(trainingset_model2$是否钓到鱼,trainingset_model2$`模型2预测值:.钓鱼`,legacy.axes=T,main="trainingset_model2  ROC",plot=T,print.thres=T,print.auc=T)

roc(testset_model1$是否钓到鱼,testset_model1$`模型1预测值:.钓鱼`,legacy.axes=T,main="testset_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(testset_model2$是否钓到鱼,testset_model2$`模型2预测值:.钓鱼`,legacy.axes=T,main="testset_model2  ROC",plot=T,print.thres=T,print.auc=T)

model1_cut=3.335
model2_cut=1.138
testset_model1$gg1=as.integer(testset_model1$`模型1预测值:.钓鱼`>=model1_cut)
table(testset_model1$是否钓到鱼,testset_model1$gg1)   #横向一行表示实际值，纵向一行表示预测值

testset_model2$gg2=as.integer(testset_model2$`模型2预测值:.钓鱼`>=model2_cut)
table(testset_model2$是否钓到鱼,testset_model2$gg2)   #横向一行表示实际值，纵向一行表示预测值

#testset_model1 CC
for (i in 1:75){
  if(i ==1)
  plot(c(0,1),c(testset_model1$TEST_M1_FPR[i],1-testset_model1$TEST_M1_R[i]),type="l",xlab="正例概率代价",ylab="归一化代价",main="testset_model1 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(testset_model1$TEST_M1_FPR[i],1-testset_model1$TEST_M1_R[i]),type="l")
}
#testset_model2 CC
for (i in 1:75){
  if(i ==1)
    plot(c(0,1),c(testset_model2$TEST_M2_FPR[i],1-testset_model2$TEST_M2_R[i]),type="l",xlab="正例概率代价",ylab="归一化代价",main="testset_model2 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(testset_model2$TEST_M2_FPR[i],1-testset_model2$TEST_M2_R[i]),type="l")
}

#通过比较，可知模型1的期望总体代价小于模型二


#PART TWO
handwriting <- read.xlsx("C:\\Users\\lenovo\\Desktop\\手写体数据.xlsx",sheet=1)

roc(handwriting$数据标签,handwriting$模型1预测,legacy.axes=T,main="handwring_model1  ROC",plot=T,print.thres=T,print.auc=T)

roc(handwriting$数据标签,handwriting$模型2预测,legacy.axes=T,main="handwring_model2  ROC",plot=T,print.thres=T,print.auc=T)

roc(handwriting$数据标签,handwriting$模型3预测,legacy.axes=T,main="handwring_model3  ROC",plot=T,print.thres=T,print.auc=T)

moxing_cut=c(0.572,0.618,0.394)


tp=rep(0,30)
fp=rep(0,30)
fn=rep(0,30)
p=rep(0,30)
r=rep(0,30)
k=1
for(i in 1:3){
  for(j in 1:5){
    
    tp[k]=sum(handwriting[,j+1]==2&handwriting$数据标签==1&handwriting[,i+6]>=moxing_cut[i])
    fp[k]=sum(handwriting[,j+1]==2&handwriting$数据标签==0&handwriting[,i+6]>=moxing_cut[i])
    fn[k]=sum(handwriting[,j+1]==2&handwriting$数据标签==1&handwriting[,i+6]<moxing_cut[i])
    
    p[k]=tp[k]/(tp[k]+fp[k])
    r[k]=tp[k]/(tp[k]+fn[k])
   
    k=k+1
    
    tp[k]=sum(handwriting[,j+1]==1&handwriting$数据标签==1&handwriting[,i+6]>=moxing_cut[i])
    fp[k]=sum(handwriting[,j+1]==1&handwriting$数据标签==0&handwriting[,i+6]>=moxing_cut[i])
    fn[k]=sum(handwriting[,j+1]==1&handwriting$数据标签==1&handwriting[,i+6]<moxing_cut[i])
    
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

##绘制期望代价曲线
for (i in 1:479)
{
  division=handwriting[i,7]
  
  handwriting$judge1=handwriting[,7]>=division
  handwriting$M1_R[i]=sum(handwriting$数据标签==1&handwriting$judge1)/sum(handwriting$数据标签)
  handwriting$M1_FPR[i]=sum(handwriting$数据标签==0&handwriting$judge1)/sum(479-sum(handwriting$数据标签))
  
}

for (i in 1:479)
{
  division=handwriting[i,8]
  
  handwriting$judge2=handwriting[,8]>=division
  handwriting$M2_R[i]=sum(handwriting$数据标签==1&handwriting$judge2)/sum(handwriting$数据标签)
  handwriting$M2_FPR[i]=sum(handwriting$数据标签==0&handwriting$judge2)/sum(479-sum(handwriting$数据标签))
}

for (i in 1:479)
{
  division=handwriting[i,9]
  
  handwriting$judge3=handwriting[,9]>=division
  handwriting$M3_R[i]=sum(handwriting$数据标签==1&handwriting$judge3)/sum(handwriting$数据标签)
  handwriting$M3_FPR[i]=sum(handwriting$数据标签==0&handwriting$judge3)/sum(479-sum(handwriting$数据标签))
}

for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M1_FPR[i],1-handwriting$M1_R[i]),type="l",xlab="正例概率代价",ylab="归一化代价",main="handwriting_model1 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M1_FPR[i],1-handwriting$M1_R[i]),type="l")
}

for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M2_FPR[i],1-handwriting$M2_R[i]),type="l",xlab="正例概率代价",ylab="归一化代价",main="handwriting_model2 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M2_FPR[i],1-handwriting$M2_R[i]),type="l")
}
for (i in 1:479){
  if(i ==1)
    plot(c(0,1),c(handwriting$M3_FPR[i],1-handwriting$M3_R[i]),type="l",xlab="正例概率代价",ylab="归一化代价",main="handwriting_model3 CC",ylim = c(0,1))  
  else
    lines(c(0,1),c(handwriting$M3_FPR[i],1-handwriting$M3_R[i]),type="l")
}


#计算错误率
thetaC=rep(0,5) 
thetaB=rep(0,5)
for(i in 1:5){
  thetaC[i]=sum(handwriting[,i+1]==2&((handwriting$数据标签==1&handwriting$模型3预测>=0.394)|(handwriting$数据标签==0&handwriting$模型3预测<0.394)))/99
  
  
}

for(i in 1:5){
  thetaB[i]=sum(handwriting[,i+1]==2&((handwriting$数据标签==1&handwriting$模型2预测>=0.618)|(handwriting$数据标签==0&handwriting$模型2预测<0.618)))/99
  
  
}

miu=mean(thetaB-thetaC)
sigma=sd(thetaB-thetaC)

print(miu*sqrt(5)/sigma)












