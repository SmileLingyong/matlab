% Creation          :   01-Jun-2017  15:24
% Last Reversion :   01-Jun-2017  15:24
% Author             :   Lingyong Smile {smilelingyong@163.com}
% File type          :   matlab
%
% This is a TreeBagger demo learning, contains classification and regression
% ------------------------------------------------------------
% Lingyong Smile  @ 2017
% Link: https://cn.mathworks.com/help/stats/treebagger.html

%%  classification demo
% Since TreeBagger uses randomness we will get different results each time we run this.
% This makes sure we get the same results every time we run the code.
rng default  % control random number generation

% Here we create some training data.
% The rows&lt; represent the samples or individuals.
% The first two columns represent the individual's features.
% The last column represents the class label (what we want to predict)
trainData = [ ...
    [6,  300,  1];
    [3,  300,  0];
    [8,  300,  1];
    [11, 2000, 0];
    [3,  100,  0];
    [6,  1000, 0];
    ];

features = trainData(:,(1:2))
classLabels = trainData(:,3)

% How many trees do you want in the forest? 
nTrees = 20;

% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');

% Given a new individual WITH the features and WITHOUT the class label,
% what should the class label be?
newData1 = [7, 300];

% Use the trained Decision Forest.
predChar1 = B.predict(newData1);

% Predictions is a char though. We want it to be a number.
predictedClass = str2double(predChar1)
% predictedClass =
%      1

% So we predict that for our new piece of data, we will have a class label of 1 

% Okay let's try another piece of data.
newData2 = [7, 1500];

predChar2 = B.predict(newData2);
predictedClass2 = str2double(predChar2)
% predictedClass2 =
%      0
% It predicts that the new class label is a 0.

% inspeact the trees, by running the view()
% command.E.g for inspecting the first tree of the example:
view(B.Trees{1});

%%  regression demo
figure();
x=[1:1:30];  
y=x.^2;  
B= TreeBagger(100,x',y','Method','regression');  
x2=[1:0.5:40];  
y2=x2.^2;  
y3=zeros(size(x2));  
for i=1:size(x2,2)  
    y3(i)=B.predict(x2(i));  
end  
plot(x2,y2,'.r');  
hold on;  
plot(x2,y3,'.b');  
title('Random Forest for Regression');