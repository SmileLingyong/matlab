function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly 
% This function is to Feature Normalization.(�������ţ�ע��ο��������Ź�ʽ)
X_norm = X;    % ��Ź�һ���� X
mu = zeros(1, size(X, 2));    % ÿ�еľ�ֵ
sigma = zeros(1, size(X, 2));    % ÿ�еı�׼��

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%               ���ÿ�еľ�ֵ�ͱ�׼�֮����Զ�ÿ�н�������
%               
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%               ע�⣺X�����У�ÿһ����һ��������ÿһ�д���һ�����ӡ�
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       
m = size(X, 1);  % ����Ŀ�����ж��ٸ�ʵ��
mu = mean(X);  % ����ÿһά������ÿһ�У��ľ�ֵ
sigma = std(X); % ����Xÿһ�еı�׼��
for i = 1 : m
    X_norm(i, :) = ( X(i, :) - mu ) ./ sigma; % Ȼ��ÿһ��ʵ����ȥ��ֵ���ٳ��Ա�׼��
end
% ============================================================

end
