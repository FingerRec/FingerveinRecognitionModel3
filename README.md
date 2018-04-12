# Fingervein Recognition Model3
---
This project implement in matlab and python,which be finshed in 2017.5.Be sure you have a GPU first,preprocess and cnn model in cpu is slow.

### 01_Genetic_Preprocess
This part use Genetic algorithm to finish remapping.
Roi detect and clip should be done first.(important).
You can use your own database to generate preprocess img.
Tip:Genetic algorithm is expensive and your can use GPU to do the job or cut down the number of iterations
### 02-Feature_Extraction
Sparse auto encoding is doing in this part.
### 03_Convolution&Pooling
A simple CNN model is used in this part.After this part,get the feature map(Traub Features). You can use it in 04 or a new tensorflow model.
### 04_Classification&Test
Use OneVsAll classofocaion method.
 
##Matlab
IDE:Matlab 2016a
The minFunc lib is need for this project, it can be found in Stanford course.
### Run
Please add this project into PATH and run Main.m;

### use your own dataset
In model 01_Genetic_Preprocess;  Change the path in Main_1.m & Main_2.m and Main_LoadData,m;
##Tensorflow
**python2.7 + tensorflow1.1**
### Model
Python is simple,and tensorflow is very convenience.After model 03,you can use different model in tf to improve it.A simple example will be include in my antoher warehouse.

The dataset is very large.If you want to use my train features or dataset.
**Please contact me awinyimgprocess at gmail.com.**