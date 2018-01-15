function [all_theta] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i
%   一共需要训练处出10个逻辑回归模型（即每个模型带有参数theta为401个，因为样本特征为400，x0 = 1默认），每个逻辑回归模型对应着识别其中一个数字
%   我们共有5000个样本，样本的预测结果值就是：y = (1,2,3,4,5,6,7,8,9,10), 其中10代表数字0
%   我们使用fmincg库函数，来求解使得代价函数最小值的模型参数theta

% Some useful variables
m = size(X, 1);  % 5000
n = size(X, 2);   % 400

% You need to return the following variables correctly 
all_theta = zeros(num_labels, n + 1); % 10 * 401

% Add ones to the X data matrix 
X = [ones(m, 1) X];  % 5000 * 401

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the following code to train num_labels
%               logistic regression classifiers with regularization
%               parameter lambda. 
%
% Hint: theta(:) will return a column vector.
%
% Hint: You can use y == c to obtain a vector of 1's and 0's that tell you
%       whether the ground truth is true/false for this class.
%
% Note: For this assignment, we recommend using fmincg to optimize the cost
%       function. It is okay to use a for-loop (for c = 1:num_labels) to
%       loop over the different classes.
%
%       fmincg works similarly to fminunc, but is more efficient when we
%       are dealing with large number of parameters.
%
% Example Code for fmincg:
%
%     % Set Initial theta
%     initial_theta = zeros(n + 1, 1);
%     
%     % Set options for fminunc
%     options = optimset('GradObj', 'on', 'MaxIter', 50);
% 
%     % Run fmincg to obtain the optimal theta
%     % This function will return theta and the cost 
%     [theta] = ...
%         fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)),  initial_theta, options);
%
initial_theta = zeros(n+1, 1);    % 401*1
options = optimset('GradObj', 'on', 'MaxIter', 50);
% 共训练10个逻辑回归模型，分别用来识别10个数字（逻辑回归做多分类思想，即用训练的10个模型来识别用例，每个样例会得到10个模型的输出结果，
% 我们选择得分最高那个分类器结果，最为该实例的结果）
for c = 1 : num_labels  
    [theta] = fmincg(@(t)(lrCostFunction( t, X, (y==c), lambda)), initial_theta, options);  % 每次迭代，返回一个401*1的theta向量
    all_theta(c, :) = theta';
end

% =========================================================================
end
