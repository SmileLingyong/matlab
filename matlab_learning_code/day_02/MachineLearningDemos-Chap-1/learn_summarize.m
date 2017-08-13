% Creation      : 18-Mar-2017 21:55
% Last Revision : 18-Mar-2017 21:55
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% -------------------------------------------------------------------------
% |     PLEASE LEARN 'learn_randomForest.m' AND 'learn_svm.m' FIRSTLY !   |
% -------------------------------------------------------------------------
%
% 'Random Forest' and 'Support Vector Machine' algorithm has been
% introduced in 'learn_randomForest' and 'learn_svm', and maybe you are
% familiar with these two classifiers (regressors). In this script, several
% other classifers will be introduced and compared to the previous ones.
%
% A list of classifiers supported by MATLAB (use doc to see details, eg.
% doc svmtrain):
% 1. [Support Vector Machine]:
% * Train: SVMStruct = svmtrain(Training,Group)
% * Test : Group = svmclassify(SVMStruct,Sample)
% 2. [Random Forest]:
% * Train: B = TreeBagger(NumTrees,X,Y)
% * Test : label = predict(tree,X)
% 3. [Multinomial Logistic Regression]:
% * Train: B = mnrfit(X,Y)
% * Test : pihat = mnrval(B,X)
% 4. [Naive Bayes]
% * Train: Factor = NaiveBayes.fit(train_data, train_label);
% * Test : Scores = posterior(Factor, test_data);
% 5. [K - Nearest Neighbor]
% * Train: mdl = fitcknn(X,y)
% * Test : label = predict(mdl,X)
% 6. [Discriminant Analysis]
% * Train: obj = fitcdiscr(x,y)
% * Test : label = predict(obj,X)
% 7. [Boosting]
% * Train: Ensemble = fitensemble(X,Y,Method,NLearn,Learners)
% * Test : label = predict(Ensemble,X)
%
% It's not necessary to be familiar with all of these
% classifiers(regressors), 
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

%% Initialization
clc;
clear;
close all;

%% Load dataset and set default parameters
libsvm_path = '/home/xinke/mytools/libsvm-3.22/matlab';
if ~isempty(regexp(path, libsvm_path))
    rmpath(libsvm_path); % remove the libsvm path from search path if it have been added
end
load fisheriris;    % fisheriris is a very small dataset provided by matlab, it contains 3 different types of flowers and each sample has a 4 dimensions feature stored in 'meas', and the label stored in 'species'
samples_types = 2;  % types of samples
samples_nums = 50;  % sample number of each type
trn_ratio = 0.6;    % number of training samples, you can adjust the trn_ratio to increase or decrease the number of training samples and see the change of accuracy
forest_num = 50;    % number of forest used in random forest algorithm, you can adjust this variable and see the influence to training time and accuracy
% forest_num = 1;
% forest_num = 300;
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
% Because some classifiers(regressors) don't support string label, we have
% to transfer the string to number firstly.
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
SVM = svmtrain(trn_samples_feat, trn_samples_label);
RandomTree = TreeBagger(50, trn_samples_feat, trn_samples_label);
% LogisticRegression = mnrfit(trn_samples_feat, trn_samples_label)
NaiveBayes = NaiveBayes.fit(trn_samples_feat, trn_samples_label);
KNN = fitcknn(trn_samples_feat, trn_samples_label);
DiscriminantAnalysis = fitcdiscr(trn_samples_feat, trn_samples_label);
Boosting = fitensemble(trn_samples_feat, trn_samples_label, 'LogitBoost', 10, 'Tree'); % Boosting is an ensemble learning method, the fitensemble function support several learning methods like 'AdaBoost', 'LogitBoost' and etc. use doc fitensemble to see more details 
%% Testing
pred_svm = svmclassify(SVM, tst_samples_feat);
pred_rf = predict(RandomTree, tst_samples_feat);
[score, pred_nb]  = posterior(NaiveBayes, tst_samples_feat); % the score is the probability of each class like [0.99, 0.01]
pred_knn = predict(KNN, tst_samples_feat);
pred_da = predict(DiscriminantAnalysis, tst_samples_feat);
pred_boost = predict(Boosting, tst_samples_feat);

%% Accuracy
% This demo use a very simple dataset, all the classifer get a good score
acc_svm = sum(strcmp(pred_svm, tst_samples_label)) / (tst_num * samples_types);
acc_rf = sum(strcmp(pred_rf, tst_samples_label)) / (tst_num * samples_types);
acc_nb = sum(strcmp(pred_nb, tst_samples_label)) / (tst_num * samples_types);
acc_knn = sum(strcmp(pred_knn, tst_samples_label)) / (tst_num * samples_types);
acc_da = sum(strcmp(pred_da, tst_samples_label)) / (tst_num * samples_types);
acc_boost = sum(strcmp(pred_boost, tst_samples_label)) / (tst_num * samples_types);

fprintf('Accuracy:\n');
fprintf('SVM: %.2f\n', acc_svm);
fprintf('Random Forest: %.2f\n', acc_rf);
fprintf('Naive Bayes: %.2f\n', acc_nb);
fprintf('KNN: %.2f\n', acc_knn);
fprintf('Discriminant Analysis: %.2f\n', acc_da);
fprintf('Boosting: %.2f\n', acc_da);
