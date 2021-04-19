# Clustering-using-R

## 1. INTRODUCTION

**OVERVIEW**
We know how difficult it is now a days to deal with data. But thanks to the new mining
techniques which helps us to handle data very smoothly.
In this project, we have use the most famous and important technique of data mining
which is clustering.
Clustering is something which helps us find trends in the data and draw conclusions
from it. The project has been implemented in R and has used inbuilt R libraries which
are used for plotting graphs.
Clustering has the following features:
• Scalability − We need highly scalable clustering algorithms to deal with large databases.
• Ability to deal with different kinds of attributes − Algorithms should be capable to be applied on any
kind of data such as interval-based (numerical) data, categorical, and binary data.
• Discovery of clusters with attribute shape − The clustering algorithm should be capable of detecting
clusters of arbitrary shape. They should not be bounded to only distance measures that tend to find
spherical cluster of small sizes.
• High dimensionality − The clustering algorithm should not only be able to handle low-dimensional data
but also the high dimensional space.
The data consists of the number of sales of different products of a retailer who sells
those products in market.

**BACKGROUND AND MOTIVATION**
The motivation of this project is the curiosity we have for handling big data.
Bigger the data, better we can apply the available techniques to it to grab some
useful information from it.
Some points that need to be kept in mind are:
• A cluster of data objects can be treated as one group.
• While doing cluster analysis, we first partition the set of data into groups based on data similarity and
then assign the labels to the groups.
• The main advantage of clustering over classification is that, it is adaptable to changes and helps single
out useful features that distinguish different groups.
• Making Regression models and predicting the data using the model.
Also, R has an amazing variety of functions for cluster analysis. In this section, I will
describe three of the many approaches: hierarchical agglomerative, partitioning, and
model based. While there are no best solutions for the problem of determining the
number of clusters to extract, several approaches are given below.
K-means clustering is the most popular partitioning method. It requires the analyst
to specify the number of clusters to extract. A plot of the within groups sum of
squares by number of clusters extracted can help determine the appropriate
number of clusters. The analyst looks for a bend in the plot similar to a screen test
in factor analysis.
Multiple regression is an extension of linear regression into relationship between
more than two variables. In simple linear relation we have one predictor and one
response variable, but in multiple regression we have more than one predictor
variable and one response variable.
We create the regression model using the lm() function in R. The model
determines the value of the coefficients using the input data. Next we can predict
the value of the response variable for a given set of predictor variables using these
coefficients.

**METHODOLOGY**
The following steps were applied to achieve our goal. These steps can also be found in the
form of comments in the code.
1. Prepare the data for analysis. Remove the missing value and remove “Channel” and
“Region” columns because they are not useful for clustering.
2. Standardize the variables.
3. Determine the number of clusters.
4. The correct choice of k is often ambiguous, but from the above plot, I am going to try
my cluster analysis with 6 clusters.
5. Fit the model and print out the cluster means.
6. Plotting the results.
7. Outlier detection with K-Means
8. the data are partitioned into k groups by assigning them to the closest cluster centers,
as follows
9. Then calculate the distance between each object and its cluster center, then pick those
with largest distances as outliers and print out outliers’ IDs.
10.These are the outliers. Let me make it more meaningful.
11.Making some conclusions by plotting variables together.
12. Prepare the training and test data set using split function
13. Use the training set to train the model which checks the Channel value dependent on
the other dimensions
14. Predict the values using the generated model using the test set
15. Count the correctly matching predictions and calculate the accuracy rate if the
model.

## 2. DATASET EXPLORATION

The dataset has been taken from http://archive.ics.uci.edu/ml/machine-learningdatabases/00292/
This data has 7 attributes. Each attribute describes certain feature of the dataset.
Attribute Information:
1) FRESH: annual spending (m.u.) on fresh products (Continuous);
2) MILK: annual spending (m.u.) on milk products (Continuous);
3) GROCERY: annual spending (m.u.)on grocery products (Continuous);
4) FROZEN: annual spending (m.u.)on frozen products (Continuous)
5) DETERGENTS_PAPER: annual spending (m.u.) on detergents and paper products
(Continuous)
6) DELICATESSEN: annual spending (m.u.)on and delicatessen products (Continuous);
7) CHANNEL: customersâ€™ Channel - Horeca (Hotel/Restaurant/CafÃ©) or Retail
channel (Nominal)
8) REGION: customersâ€™ Region â€“ Lisnon, Oporto or Other (Nominal)

**Descriptive Statistics:**
(Minimum, Maximum, Mean, Std. Deviation)
FRESH ( 3, 112151, 12000.30, 12647.329)
MILK (55, 73498, 5796.27, 7380.377)
GROCERY (3, 92780, 7951.28, 9503.163)
FROZEN (25, 60869, 3071.93, 4854.673)
DETERGENTS_PAPER (3, 40827, 2881.49, 4767.854)
DELICATESSEN (3, 47943, 1524.87, 2820.106)
REGION Frequency
Lisbon 77
Oporto 47
Other Region 316
Total 440
CHANNEL Frequency
Horeca 298
Retail 142
Total 440
