library(corrplot)
# Clustering
library(cluster) 
library(ggplot2)
library(factoextra)
library(car)
library(dplyr)

layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page
customer <- read.csv('Wholesale.csv')
head(customer)
str(customer)
View(customer)
customer1<- customer
customer1<- na.omit(customer1)
customer1$Channel <- NULL
customer1$Region <- NULL

#Standardize the variables.
customer1 <- scale(customer1)
corrmatrix <- cor(customer)
corrplot(corrmatrix, method = 'circle')

#Determine the number of clusters.

wss <- (nrow(customer1)-1)*sum(apply(customer1,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(customer1,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")



#Fit the model and print out the cluster means.
fit <- kmeans(customer1, 6) # fit the model
aggregate(customer1,by=list(fit$cluster),FUN=mean) # get cluster means
customer1 <- data.frame(customer1, fit$cluster) #append cluster assignment


#Plotting the results.
library(cluster)
clusplot(customer1, fit$cluster , color=TRUE, shade=TRUE, labels=2, lines=0)


#Outlier detection with K-Means
customer2 <- customer[, 3:8]
kmeans.result <- kmeans(customer2, centers=6)
kmeans.result$centers


#Then calculate the distance between each object and its cluster center,
#then pick those with largest distances as outliers and print out outliers' IDs.

kmeans.result$cluster # print out cluster IDs
centers <- kmeans.result$centers[kmeans.result$cluster, ]
distances <- sqrt(rowSums((customer2 - centers)^2)) # calculate distances
outliers <- order(distances, decreasing=T)[1:5] # pick up top 5 distances
print(outliers)


#These are the outliers. Let us make it more meaningful.
print(customer2[outliers,])

#Hierarchical Clustering
idx <- sample(1:dim(customer)[1], 40)
customerSample <- customer[idx,]
customerSample$Region <- NULL
customerSample$Channel <- NULL


#There are a wide range of hierarchical clustering methods,
#I heard Ward's method is a good appraoch, so try it out.

d <- dist(customerSample, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D")
plot(fit) # display dendogram
groups <- cutree(fit, k=6) # cut tree into 6 clusters
rect.hclust(fit, k=6, border="red") # draw dendogram with red borders around the 6 clusters

count_fresh=sum(customer$Fresh)
count_Milk=sum(customer$Milk)
count_gro=sum(customer$Grocery)
count_fro=sum(customer$Frozen)
count_Det=sum(customer$Detergents_Paper)
count_del=sum(customer$Delicassen)
data=c(count_fresh,count_Milk,count_gro,count_fro,count_Det,count_del)
vals=c("Fresh","Milk","Grocery","Frozen","Detergents_Paper","Delicassen")
data_vals=data.frame(data,vals)

ggplot(data_vals,aes(x=vals,y=data))+geom_point()

salesfor1 <- customer %>%
  filter(Channel==1)

salesfor2 <- customer %>%
  filter(Channel==2)

c1=count(salesfor1)
c2=count(salesfor2)
max(salesfor1)
max(salesfor2)


a=max(salesfor1$Fresh)
b=max(salesfor2$Fresh)
c=max(salesfor1$Milk)
d=max(salesfor2$Milk)
e=max(salesfor1$Detergents_Paper)
f=max(salesfor2$Detergents_Paper)
g=max(salesfor1$Delicassen)
h=max(salesfor2$Delicassen)
i=max(salesfor1$Frozen)
j=max(salesfor2$Frozen)
k=max(salesfor1$Grocery)
l=max(salesfor2$Grocery)
vals1= c(a,c,e,g,i,k)
vals2=c(b,d,f,h,j,l)
frames_dat=c(vals1,vals2)

chanel=c(1,2)
customer <- customer %>%
  mutate(sum_sale=((Milk+Frozen+Fresh+Detergents_Paper+Grocery+Delicassen)))
barplot(frames_dat,col = c("Blue","Red"),beside = TRUE,legend.text = c("1","2"),main = "Channel Based Expenditure",xlab="Fresh,Milk,Detergents_Paper,Delicassen,Frosen,Grocery",ylab="Expenditure",las=1)
pairs(customer, col=customer$Channel)
plot(customer)
cor(customer)

scatterplot( Fresh ~ Frozen|Channel, data=customer,xlab="Fresh", ylab="Frozen",main="Scatter Plot: Horeca(Hotel/Restaurant/Cafe) vs. Retail Channel (Store)",smooth=T,lty=1, lwd=2, by.groups=T)

ggplot(customer, aes(x = Region , y =  sum_sale ,col=factor(Channel)) ) + geom_point()

library(caTools)
#install.packages('caTools')
set.seed(123)
split=sample.split(customer$Channel, SplitRatio = 0.8)
training_set=subset(customer,split==TRUE)
test_set=subset(customer,split==FALSE)

prediction_model <- lm(Channel~Milk+Frozen+Detergents_Paper+Grocery+Fresh+Delicassen , data=training_set)


plot(prediction_model)

predicted <- predict(prediction_model,newdata = test_set,interval = "prediction")

final_frame=data.frame(predicted,test_set)

correct_guess = final_frame %>%
  mutate(avg_predict_channel=(lwr+upr)/2)

correct_guess= correct_guess %>%
  filter(((lwr+upr)/2 >1.5& Channel==2)|((lwr+upr)/2 <1.5&Channel==1))

accuracy=count(correct_guess)
total=count(test_set)
accuracy_rate=accuracy/total
print("Accurarcy Rate of The prediction model is =")
accuracy_rate

# the model is mostly successful in predicting the value of channel

final_model_obtained=data.frame(correct_guess$avg_predict_channel,correct_guess$Channel)

plot(final_model_obtained)


