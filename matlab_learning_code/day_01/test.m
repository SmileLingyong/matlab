% Creationg             :   05-Jun-2017   14:55
% Last reversion       :   05-Jun-2017   14:56
% Author                 :    Lingyong Smile {smilelingyong@163.com}
% File                     :    matlab
% 
% This is a demo of machine learning 
% ---------------------------------------------------------------------------------
%  Lingyong Smile @ 2017

%% Initialization
clc;
clear;
close all;

%% Load dataset and set default parameters
load fisheriris;    % fisheriris is a very small dataset provided by matlab, it contains 3 different types of flowers and each sample has a 4 dimensions feature stored in 'meas', and the label stored in 'species'
samples_types = 3;  % types of samples
samples_nums = 50;  % sample number of each type
trn_ratio = 0.6;    % number of training samples, you can adjust the trn_ratio to increase or decrease the number of training samples and see the change of accuracy
forest_num = 50;    % number of forest used in random forest algorithm, you can adjust this variable and see the influence to training time and accuracy
% forest_num = 1;
% forest_num = 300;
trn_samples_feat = [];   % training samples  <90x4 double>
tst_samples_feat = [];   % testing samples   <60x4 double>
trn_samples_label = [];  % training samples label;   <90x1 cell>
tst_samples_label = [];  % testing samples label;    <60x1 cell>

%% Split the dataset to 'Training samples' and 'Testing samples'
% It's a fundamental point in machine learning that every samples will appear in TEST case MUST NOT be used at TRAINING time
% Fisheriris dataset contains 2 variable:
% [meas]: this variable contains the features which is a 150 x 4 matrix,
% every row of the matrix is the feature of the sample
% [species]: this varaible contains the label of each sample, in this dataset
% there are 3 different types of flowers: {'setosa', 'versicolor', 'virginica'}
trn_num = ceil(samples_nums * trn_ratio);         % number of training samples  30
tst_num = samples_nums - trn_num;           % all the rest samples will be used at testing time  20
% at this part, we divide the dataset to training data and testing data respectively
for i = 1:samples_types                              %  Split the dataset to 'Training samples' and 'Testing samples'
    start_idx = (i - 1) * samples_nums + 1;    % 1
    end_idx_trn = start_idx + trn_num - 1;     % 30
    end_idx_tst = end_idx_trn + tst_num;      % 50
    trn_idx = [start_idx : end_idx_trn];           % [1 ~ 30]
    tst_idx = [end_idx_trn + 1 : end_idx_tst]; % [31 ~ 50]
    trn_samples_feat = [trn_samples_feat; meas(trn_idx, :);];   % <30x4 double>  trainng data set, add 30 row data of meas every loop
    tst_samples_feat = [tst_samples_feat; meas(tst_idx, :);];   % <20x4 double>  testing data set, add 20 row data of meas every loop 
    trn_samples_label = [trn_samples_label; species(trn_idx)]; % <30x1 cell>   training data label, etc.
    tst_samples_label = [tst_samples_label; species(tst_idx)]; % <20x1 cell>   testing data lable, etc.
end

%% Training
start = tic();
model = TreeBagger(forest_num, trn_samples_feat, trn_samples_label);
time_trn = toc(start);
fprintf('Training Finished: cost %.3f(s)\n', time_trn);

%%  inspeact the trees, by running the view()
% command.E.g for inspecting the first tree of the example:
% view(model.Trees{1});  % in this demo, the max Trees' index is 50

%% Testing
pred_labels = predict(model, tst_samples_feat);
accuracy = sum(strcmp(tst_samples_label, pred_labels)) / (tst_num * samples_types);
fprintf('Accuracy: %.2f\n', accuracy); 

%% Another testing function
newTestingData1 = [6.7000 3.9000 5.9000 2.5000];  % create a new testing data 
result1_label = predict(model, newTestingData1);      % return a cell
fprintf('The predict label is %s\n', result1_label{1});     % printf the predict result




