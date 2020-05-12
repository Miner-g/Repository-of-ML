credit <- read.csv("C:\\Users\\lenovo\\Desktop\\Credit.csv",header = T)

#1.编写程序用least square 计算balance对每一个自变量的一元回归系数
b=rep(0,6)
a=rep(0,6)
for (i in c(1,2,4)){
  temp=credit[,(i+3)]
  
  plot(temp,credit$Balance,xlab=colnames(credit)[i+3],ylab="balance",main=paste(colnames(credit)[i+3],"对balance的拟合图像"))
  b[i]=(sum(temp*credit$Balance)-
          sum(temp/400)*sum(credit$Balance))/(sum(temp^2)-sum(temp)^2/400)
  a[i]=sum(credit$Balance)/400-b[i]*sum(temp)/400
  lines(temp,b[i]*temp+a[i],lty=1)
  print(paste("回归结果为：balance=",b[i],"*",colnames(credit)[i+3],"+(",a[i],")"))
}

#2.least square计算balance对limit和rating的回归
b2=rep(0,3)
credit$inva <- rep(1,400)
x2 <- as.matrix(credit[,c(4,5,14)])
y <- as.matrix(credit$Balance)
b2=solve(t(x2)%*%x2)%*%t(x2)%*%y

print(paste("回归结果为：balance=",b2[1],"*",colnames(credit)[4],"+",b2[2],"*",colnames(credit)[5],"+(",b2[3],")"))


#3.least square计算balance对age和rating的回归
b3=rep(0,3)
x3 <- as.matrix(credit[,c(5,7,14)])
b3=solve(t(x3)%*%x3)%*%t(x3)%*%y
print(paste("回归结果为：balance=",b3[1],"*",colnames(credit)[5],"+",b3[2],"*",colnames(credit)[7],"+(",b3[3],")"))

#4.正交系数估计算法计算balance对age和rating的回归
a0 <- credit[,5]
a1 <- credit[,7]
a2 <- credit[,14]
z0 <- a0
z1 <- a1-z0*sum(a1*z0/100)/sum(z0*z0)*100
z2 <- a2-z0*sum(a2*z0)/sum(z0*z0)-z1*sum(a2*z1)/sum(z1*z1)
b3_2 <- rep(0,3)
b3_2[3] <- sum(z2*y)/sum(z2*z2)
b3_2[2] <- sum(z1*(y-b3_2[3]*a2))/sum(z1*z1)
b3_2[1] <- sum(z0*(y-b3_2[3]*a2-b3_2[2]*a1))/sum(z0*z0)
print(paste("回归结果为：balance=",b3_2[1],"*",colnames(credit)[5],"+",b3_2[2],"*",colnames(credit)[7],"+(",b3_2[3],")"))

#第二题 boston
boston <- read.table("C:\\Users\\lenovo\\Desktop\\boston.txt",header = T)
boston$value_square=boston$value^2
erci=t(as.matrix(square$coefficients))%*%t(as.matrix(data.frame(rep(1,506),boston$value,boston$value_square)))
knn.fit <- knn.reg(train = boston$value,y=boston$lowstat,k=15)
knn.fit_2 <- knn.reg(train = boston$value,y=boston$lowstat,k=45)
knn.fit_3 <- knn.reg(train = boston$value,y=boston$lowstat,k=75)
knn.fit_4 <- knn.reg(train = boston$value,y=boston$lowstat,k=105)
##对比k值
qplot(boston$value,boston$lowstat,alpha=I(0.5),main="boston_dataset")+
  geom_line(aes(x=boston$value,y=knn.fit$pred),color="#CAE1FF",size=1)+
  geom_line(aes(x=boston$value,y=knn.fit_2$pred),color="#836FFF",size=1)+
  geom_line(aes(x=boston$value,y=knn.fit_3$pred),color="#7D26CD",size=1)+
  geom_line(aes(x=boston$value,y=knn.fit_4$pred),color="#8B0A50",size=1)

#画图  
qplot(boston$value,boston$lowstat,alpha=I(0.5),main="boston_dataset")+
  stat_smooth(method = "lm",se=FALSE,lwd=1)+
  geom_line(aes(x=boston$value,y=knn.fit_2$pred),color="#009E73",size=1)+
  geom_line(aes(x=boston$value,y=as.vector(erci)),color="#E69F00",size=1)


  
  
  
  