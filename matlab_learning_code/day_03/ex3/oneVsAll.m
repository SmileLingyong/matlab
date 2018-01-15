function [all_theta] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i
%   һ����Ҫѵ������10���߼��ع�ģ�ͣ���ÿ��ģ�ʹ��в���thetaΪ401������Ϊ��������Ϊ400��x0 = 1Ĭ�ϣ���ÿ���߼��ع�ģ�Ͷ�Ӧ��ʶ������һ������
%   ���ǹ���5000��������������Ԥ����ֵ���ǣ�y = (1,2,3,4,5,6,7,8,9,10), ����10��������0
%   ����ʹ��fmincg�⺯���������ʹ�ô��ۺ�����Сֵ��ģ�Ͳ���theta

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
% ��ѵ��10���߼��ع�ģ�ͣ��ֱ�����ʶ��10�����֣��߼��ع��������˼�룬����ѵ����10��ģ����ʶ��������ÿ��������õ�10��ģ�͵���������
% ����ѡ��÷�����Ǹ��������������Ϊ��ʵ���Ľ����
for c = 1 : num_labels  
    [theta] = fmincg(@(t)(lrCostFunction( t, X, (y==c), lambda)), initial_theta, options);  % ÿ�ε���������һ��401*1��theta����
    all_theta(c, :) = theta';
end

% =========================================================================
end
