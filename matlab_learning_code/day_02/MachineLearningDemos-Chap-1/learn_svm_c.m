% Creation      : 17-Mar-2017 15:29
% Last Revision : 17-Mar-2017 15:29
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% The 'learn_svm_a.m' script employed a support vector machine solved a
% very simple binary classification problem and the 'learn_svm_b.m'
% provided a simple way to solve multi-classes classification problem using
% svmtrain() function. Though there are some tricks to solve multi-classes
% classification problems by using the function embedded in MATLAB, limits
% are still exist.
% In this script, a frequently used SVM package developed by prof. Chih-Jen
% Lin will be introduced to you.
% To run this demo, you have to download the LIBSVM package firstly, the
% url is given: [http://www.csie.ntu.edu.tw/~cjlin/libsvm/libsvm-3.22.zip]
% you can also find some help documentations and introductions on this
% website: http://www.csie.ntu.edu.tw/~cjlin/libsvm/
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

%% How to use the libsvm package
% 1. Extract the zip file and go to the 'matlab' sub-directory
% 2. Run the make.m script to compile the c code to mex file
% 3. Change the folder here and run the demo
% Warning: It is worth to notice that if you add the path of libsvm package to your
% MATLAB search path, the original svmtrain() function provided by MATLAB
% will be cover, if you want to use the original one that you have to
% remove the path firstly or restart the MATLAB

%% Initialization
clc;
clear;
close all;

%% Compile libsvm
% Why do we have to compile the package?
% Because the source code is C code, the MATLAB can not run these code
% directly. However, the MATLAB support mixture coding technology, it
% provide a mex() function to compile the source code to excutable file for
% itself (.mexw in windows and .mexa in linux)
libsvm_path = 'C:\Program Files\MATLAB\R2017b\toolbox\libsvm-3.22\'; % you have to modify the path to your own package path, here is my package path under Ubuntu 14.04, if you are using windows, it would be like 'd:/mytools/libsvm-3.22'
% If you have already compiled the source code, you can comment the
% following code
demo_path = cd;
cd([libsvm_path, 'matlab']);
make();
cd(demo_path);
clc;

%% Load example data provided by libsvm
addpath([libsvm_path, 'matlab']);
[heart_scale_label, heart_scale_inst] = libsvmread([libsvm_path, 'heart_scale']); % These is a small dataset provided by libsvm, it is a biinary classification problem about heart scale
% there are two variables in this dataset:
% heart_scale_label: the labels of the data
% heart_scale_inst: the features of the data

%% Set some default parameters
samples_nums = numel(heart_scale_label);
trn_ratio = 0.6; % number of training samples

%% Split the dataset to training data and testing data
trn_nums = ceil(trn_ratio * samples_nums);
shuffle_idx = randperm(samples_nums); % shuffle the data
trn_idx = shuffle_idx(1 : trn_nums);
tst_idx = shuffle_idx(trn_nums + 1 : end);

trn_feature = heart_scale_inst(trn_idx, :);
tst_feature = heart_scale_inst(tst_idx, :);
trn_labels = heart_scale_label(trn_idx);
tst_labels = heart_scale_label(tst_idx);

%% Training
model = svmtrain(trn_labels, trn_feature, '-t 0');

%% Testing
% It is worth to notice that the libsvm enforce to input test labels at
% testing time and it will calculate the accuracy automatically, if you
% don't know the real labels at testing time when you are solving some
% real-world problem, you still have to declare a virtual label.
[predict_label, accuracy, ~] = svmpredict(tst_labels, tst_feature, model);

% if you don't know the label at test time:
tst_labels_virtual = zeros(size(tst_feature, 1), 1);
[predict_label_, ~, ~] = svmpredict(tst_labels_virtual, tst_feature, model);

% predict_label_ is as same as predict_label
diff = sum(predict_label - predict_label_)







