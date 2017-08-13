% Creation      : 17-Mar-2017 15:02
% Last Revision : 17-Mar-2017 15:02
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% The 'learn_svm_a.m' script employed a support vector machine solved a
% very simple binary classification problem, due to the limit of the
% svmtrain() function, the svm model could only solve a binary
% classification problem, in this script, there is a simple way to solve a
% multiple classes classification problem by employing the svmtrain()
% function.
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

%% Initialization
clc;
clear;
close all;

%% Load dataset and set default parameters
load fisheriris;
samples_types = 3;  % types of samples
samples_nums = 50;  % sample number of each type
trn_ratio = 0.6;    % number of training samples
trn_samples_feat = [];   % training samples
tst_samples_feat = [];   % testing samples
trn_samples_label = [];  % training samples label;
tst_samples_label = [];  % testing samples label;

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

% Divide the training samples to 3 batches and then transfer the
% multiple classification problem to several binary classification problem
trn_setosa_label = trn_samples_label;
trn_versicolor_label = trn_samples_label;
trn_virginica_lavel = trn_samples_label;

trn_setosa_label(~cellfun(@(x) strcmp(x, 'setosa'), trn_setosa_label)) = {'others'};
trn_versicolor_label(~cellfun(@(x) strcmp(x, 'versicolor'), trn_versicolor_label)) = {'others'};
trn_virginica_lavel(~cellfun(@(x) strcmp(x, 'virginica'), trn_virginica_lavel)) = {'others'};
%% Training
start = tic();
model_setosa = svmtrain(trn_samples_feat, trn_setosa_label);
model_versicolor = svmtrain(trn_samples_feat, trn_versicolor_label);
model_virginica = svmtrain(trn_samples_feat, trn_virginica_lavel);
time_trn = toc(start);
fprintf('Training Finished: cost %.3f(s)\n', time_trn);

%% Testing
pred_setosa = svmclassify(model_setosa, tst_samples_feat);
pred_versicolor = svmclassify(model_versicolor, tst_samples_feat);
pred_virginica = svmclassify(model_virginica, tst_samples_feat);

setosa_idx = cellfun(@(x) strcmp(x, 'setosa'), pred_setosa);
versicolor_idx = cellfun(@(x) strcmp(x, 'versicolor'), pred_versicolor);
virginica_idx = cellfun(@(x) strcmp(x, 'virginica'), pred_virginica);

pred_labels = cell(tst_num * samples_types, 1);
pred_labels(:) = {'others'};

pred_labels(setosa_idx, :) = {'setosa'};
pred_labels(versicolor_idx, :) = {'versicolor'};
pred_labels(virginica_idx, :) = {'virginica'};

accuracy = sum(strcmp(tst_samples_label, pred_labels)) / (tst_num * samples_types);
fprintf('Accuracy: %.2f\n', accuracy); 