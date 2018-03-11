function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly 
% This function is to Feature Normalization.(特征缩放，注意参看特征缩放公式)
X_norm = X;    % 存放归一化的 X
mu = zeros(1, size(X, 2));    % 每列的均值
sigma = zeros(1, size(X, 2));    % 每列的标准差

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%               求出每列的均值和标准差，之后可以对每行进行缩放
%               
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%               注意：X矩阵中，每一列是一个特征，每一行代表一个例子。
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       
m = size(X, 1);  % 行数目，即有多少个实例
mu = mean(X);  % 计算每一维特征（每一列）的均值
sigma = std(X); % 计算X每一列的标准差
for i = 1 : m
    X_norm(i, :) = ( X(i, :) - mu ) ./ sigma; % 然后将每一个实例减去均值，再除以标准差
end
% ============================================================

end
