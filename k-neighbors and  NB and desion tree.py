#!/usr/bin/env python
# coding: utf-8

# In[50]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import style
style.use('ggplot')
from sklearn.cluster import KMeans
import seaborn as sns

df=pd.read_excel("injury2.xlsx")
df.convert_dtypes(convert_boolean=True)
df.fillna(0,inplace=True)
#print(df.head())

def handle_non_numerical_data(df):
    columns=df.columns.values
     
    for column in columns:
        text_digit_vals = {}
        def convert_to_int(val):
            return text_digit_vals[val]
        
        if df[column].dtype != np.int64 and df[column].dtype != np.float64:
            column_contents = df[column].values.tolist()
            unique_elements = set(column_contents)
            x=0
            
            for unique in unique_elements:
                if unique not in text_digit_vals:
                    text_digit_vals[unique] = x
                    x+=1
                
            df[column] = list(map(convert_to_int , df[column]))
            
    return df
df = handle_non_numerical_data(df)
print(df.head())
            


# In[51]:


#K-Neighbors__KNN
from sklearn.model_selection import train_test_split
from sklearn import neighbors, datasets, preprocessing
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report

#df
X=df.drop('Status',axis=1)
y=df['Status']
X_train,X_test,y_train,y_test=train_test_split(X, y, test_size=0.20)
#X_train
#X_test

#model sazi
eror_rate=[]
for i in range(5,51,5):
    knn=neighbors.KNeighborsClassifier(n_neighbors=i)
    knn.fit(X_train,y_train)
    pred_i=knn.predict(X_test)
    eror_rate.append(np.mean(pred_i != y_test))

num=[]
for i in range(5,51,5):
    num+=[i]

dictionary=dict(zip(num,eror_rate))
print(dictionary)
    

#eror

knn.score(X_test,y_test)


# In[52]:


#best k:
my_best_k = min(eror_rate)
#print(my_best_k) 
for i in num:
    if dictionary[i] == my_best_k:
        print('best_k =',i)
        break


# In[53]:


#k hay mokhtalef:
plt.xlabel('its k')
plt.ylabel('its eror')
plt.plot(num,eror_rate,color='blue')


# In[54]:


plt.xlabel('its k')
plt.ylabel('its eror')
plt.bar(num,eror_rate,color='green')


# In[ ]:





# In[55]:


# naive_bayes - NB
from sklearn.naive_bayes import GaussianNB

#model sazi
gnb= GaussianNB()
gnb.fit(X_train,y_train)

#error
gnb.score(X_test,y_test)


# In[ ]:





# In[56]:


from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets


# In[72]:


#DecionTree(ID3)

#model sazi
tree=DecisionTreeClassifier(criterion = "entropy",max_depth=112)
tree.fit(X_train,y_train)
#print(tree)
model=tree

#pishbini:
dtree=tree.predict(X)

#error
print("Training set accuracy: {:.3f}".format(tree.score(X_train, y_train)))
print("Test set accuracy: {:.3f}".format(tree.score(X_test, y_test)))
tree.score(X_test,y_test)


# In[58]:


y_pred = tree.predict(X_test)
#eror nesbat b dade vagheii:
percentageerror_tree=((y-dtree)/dtree)*100
np.mean(percentageerror_tree)


# In[59]:


from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))


# In[60]:


get_ipython().system(' pip install graphviz')


# In[61]:


a=X_train.columns
columns_name=[]
for i in a :
    columns_name.append(i)
columns_name

b=X_train.columns
class_name=[]
for i in b :
    class_name.append(i)
class_name


# In[66]:


#rasm geraf:
import graphviz
from sklearn import tree
dot_data = tree.export_graphviz(model,out_file="tree.dot", feature_names=columns_name,class_names=class_name,filled=True, rounded=True,special_characters=True)
graph = graphviz.Source(dot_data)


# In[67]:


# Gozaresh nahaii:
get_ipython().system(' pip install prettytable')


# In[74]:


#moghayese eror ravesh ha:
from prettytable import PrettyTable
table = PrettyTable(['knn','NB','decisiontree'])
#print(table)
table.add_row([ knn.score(X_test,y_test) , gnb.score(X_test,y_test) , tree.score(X_test,y_test)])
print(table)


# In[ ]:





# In[ ]:




