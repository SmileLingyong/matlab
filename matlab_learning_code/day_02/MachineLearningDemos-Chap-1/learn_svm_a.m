% Creation      : 17-Mar-2017 13:52
% Last Revision : 17-Mar-2017 13:52
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% Learning how to use the svmTrain() function in MATLAB
% svmtrain() implements the 'support vector machine' algorithm, this demo
% shows how to use svmtrain() to training an easy classification machine
% learning model and predict new samples.
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

%% Initialization
clc;
clear;
close all;

%% Load dataset and set default parameters
libsvm_pa
rmpath();
load fisheriris;
samples_types = 2;  % types of samples, it is different from the number set in 'learn_randomForest', beacuse the svmtrain() function can only solve a binary classification problem
samples_nums = 50;  % sample number of each type
trn_ratio = 0.6;    % number of training samples
trn_samples_feat = [];   % training samples
tst_samples_feat = [];   % testing samples
trn_samples_label = [];  % training samples label;
tst_samples_label = [];  % testing samples label;
% 
%% Split the dataset to 'Training samples' and 'Testing samples'
% It's a fundamental point in machine learning that every samples will appear in TEST case MUST NOT be used at TRAINING time
% Fisheriris dataset contains 2 variable:
% [meas]: this variable contains the features which is a 150 x 4 matrix,
% every row of the matrix is the feature of the sample
% [species]: this varaible contains the label of each sample, in this dataset
% there are 3 different types of flowers: {'setosa', 'versicolor', 'virginica'}
trn_num = ceil(samples_nums * trn_ratio);         % number of training samples
tst_num = samples_nums - trn_num;           % all the rest samples will be used at testing time
% at this part, we divide the dataset to training data and testing data
% respectively
for i = 1:samples_types
    start_idx = (i - 1) * samples_nums + 1;
    end_idx_trn = start_idx + trn_num - 1;
    end_idx_tst = end_idx_trn + tst_num;
    trn_idx = [start_idx : end_idx_trn];
    tst_idx = [end_idx_trn + 1 : end_idx_tst];
    trn_samples_feat = [trn_samples_feat; meas(trn_idx, :);]; 
    tst_samples_feat = [tst_samples_feat; meas(tst_idx, :);];
    trn_samples_label = [trn_samples_label; species(trn_idx)];
    tst_samples_label = [tst_samples_label; species(tst_idx)];
end

%% Training
start = tic();
model = svmtrain(trn_samples_feat, trn_samples_label);
time_trn = toc(start);
fprintf('Training Finished: cost %.3f(s)\n', time_trn);

%% Testing
pred_labels = svmclassify(model, tst_samples_feat);
accuracy = sum(strcmp(tst_samples_label, pred_labels)) / (tst_num * samples_types);
fprintf('Accuracy: %.2f\n', accuracy); 

%% Visualization the support vector
xdata = meas(51:end,3:4); % because the display option set in svmtrain can only plot 2-Dimension data, we select 2 dimension from the raw data, you can also try other dimensions
% xdata = meas(51:end,2:3);
% xdata = meas(51:end,1:2);
group = species(51:end);
svmStruct = svmtrain(xdata,group,'ShowPlot',true);
