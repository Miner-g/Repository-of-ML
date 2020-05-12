
#预处理
auto <- read.csv('C:/Users/lenovo/Desktop/Auto_data.csv',)
auto$mpghat=40-0.15*auto$horsepower
for(i in 1:392)
{
  auto[i,'newid']=i
}
##第一问
x1 =matrix(nrow=100,ncol=79,data=NA)
y1=matrix(nrow=100)

for(i in 1:100)
{ x1[i,]<- sample(1:392,79)
  y1[i] <- sum((auto[x1[i,],'mpghat']-auto[x1[i,],'mpg'])^2)/79
}  
paste("（a）十次直接留出法试验泛化误差为",mean(y1))
##第二问
x2 <- matrix(nrow=20,ncol=10,data=NA)
y2 <- matrix(nrow=20)
for(j in 1:20)
{
  x2[j,] <- sample(1:392,10)
  y2[j] <- sum((auto[x2[j,],'mpghat']-auto[x2[j,],'mpg'])^2)/10
}
paste("（b）20次留p(p=10)交叉验证试验泛化误差为",mean(y2,na.rm = T))
##第三、四问（对比结果）
q=quantile(auto$mpg,0.75)
for(i in 1:392){
  if (auto$mpg[i]>q) {auto$bool[i] <- 1} else {auto$bool[i] <- 0}
}
auto$boolhat <- exp(3.85-0.01*auto$weight)/(1+exp(3.85-0.01*auto$weight))  
mpg1 <- auto$newid[which(auto$bool==1)]
mpg0 <- auto$newid[which(auto$bool==0)]

x3 =x4=matrix(nrow=100,ncol=79,data=NA)
y3=y4=matrix(nrow=100)

for(k in 1:100)
{ x3[k,]<- c(sample(mpg1,19),sample(mpg0,60))
  x4[k,] <- sample(1:392,79)
  y3[k] <- sum((auto[x3[k,],'bool']    -   auto[x3[k,],'boolhat'] )^2)/79
  y4[k] <- sum((auto[x4[k,],'bool']    -   auto[x4[k,],'boolhat'] )^2)/79
 
}

paste("一百次直接留出法泛化误差",mean(y4),"一百次分层抽样留出泛化误差",mean(y3))