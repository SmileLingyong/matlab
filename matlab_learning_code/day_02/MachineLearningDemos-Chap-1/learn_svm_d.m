% Creation      : 18-Mar-2017 20:49
% Last Revision : 18-Mar-2017 20:49
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% The 'learn_svm_c.m' script shows how to use the LIBSVM package, in
% this script, some advanced options of svm will be introduced. And
% different from the prior demos, this demo solves a regression problem but
% not a classification problem, you should understand the differences
% between these two problem firstly.
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

%% Initialization
clc;
clear;
close all;

%% Add libsvm to search path
libsvm_path = '/home/xinke/mytools/libsvm-3.22/';
addpath([libsvm_path, 'matlab']);

%% Setting curve function
% In this script, we will use the svm to fit a curve
x = [0:0.005:1];
y = (-log(sin((exp(x) / 2) .* x.^2)) .* sin(x)) .* tan(x); % you can also design a curve function by yourself and test the demo

%% Split the data to training samples and testing samples
idx = [1:numel(x)];
trn_idx = idx(1:2:end);
tst_idx = idx(2:2:end);
% notice that the vector should be colum but not row
trn_data = x(trn_idx)';
tst_data = x(tst_idx)';
trn_label = y(trn_idx)';
tst_label = y(tst_idx)';

%% Training several different settings svm
% You should notice that the string behind the 'trn_data', it is the
% advanced options of the svm which could control the kernel function,
% svmtype(classification or regression) and some other useful parameters,
% it's not necesseray to understand all the theory behind each parameters
% for a beginner, but you should know what will happen if you change
% them.
% -------------------------------------------------------------------------
% libsvm_options:
% -s svm_type : set type of SVM (default 0)
% 	0 -- C-SVC		(multi-class classification)
% 	1 -- nu-SVC		(multi-class classification)
% 	2 -- one-class SVM
% 	3 -- epsilon-SVR	(regression)
% 	4 -- nu-SVR		(regression)
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
% 	4 -- precomputed kernel (kernel values in training_instance_matrix)
% -------------------------------------------------------------------------
% input 'svmtrain' in command window to see more parameters can be set in
% livsvm

model_1 = svmtrain(trn_label, trn_data, '-s 3');
model_2 = svmtrain(trn_label, trn_data, '-s 4');
model_3 = svmtrain(trn_label, trn_data, '-s 3 -t 0');
model_4 = svmtrain(trn_label, trn_data, '-s 3 -t 1');
model_5 = svmtrain(trn_label, trn_data, '-s 4 -t 0');
model_6 = svmtrain(trn_label, trn_data, '-s 3 -t 1');

%% Testing
[pred_1, ~, ~] = svmpredict(tst_label, tst_data, model_1);
[pred_2, ~, ~] = svmpredict(tst_label, tst_data, model_2);
[pred_3, ~, ~] = svmpredict(tst_label, tst_data, model_3);
[pred_4, ~, ~] = svmpredict(tst_label, tst_data, model_4);
[pred_5, ~, ~] = svmpredict(tst_label, tst_data, model_5);
[pred_6, ~, ~] = svmpredict(tst_label, tst_data, model_6);

%% Visualization
% It's very clearly that different options will influence the results
% significantly. When solving real-world problems, it's important to try
% different options at training time and it would be very helpful if you 
% know the theory behind each parameters at that time.
figure(1); hold on;
title('Groundtruth and Predictions');
plot(tst_label);
plot(pred_1);
plot(pred_2);
plot(pred_3);
plot(pred_4);
plot(pred_5);
plot(pred_6);
legend('Ground-Truth', 'pred_1', 'pred_2', 'pred_3', 'pred_4', 'pred_5', 'pred_6', 'Location', 'northwest');
hold off;

