function p = predictOneVsAll(all_theta, X)
%PREDICT Predict the label for a trained one-vs-all classifier. The labels 
%are in the range 1..K, where K = size(all_theta, 1). 
%  p = PREDICTONEVSALL(all_theta, X) will return a vector of predictions
%  for each example in the matrix X. Note that X contains the examples in
%  rows. all_theta is a matrix where the i-th row is a trained logistic
%  regression theta vector for the i-th class. You should set p to a vector
%  of values from 1..K (e.g., p = [1; 3; 1; 2] predicts classes 1, 3, 1, 2
%  for 4 examples) 
% 思路：
% 求出了每个模型的参数向量θ，就可以用 训练好的模型来识别数字了。
% 对于一个给定的数字输入(400个 feature variables) input instance，每个模型的假设函数hθ(i)(x) 输出一个值(i = 1,2,...10)。
% 取这10个值中最大值那个值，作为最终的识别结果。
% 比如g(hθ(8)(x))==0.96 比其它所有的 g(hθ(i)(x)) (i = 1,2,...10,但 i 不等于8) 都大，则识别的结果为 数字 8

m = size(X, 1);  % 5000
num_labels = size(all_theta, 1); % all_theta 10*401 ,   num_labels:10

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);  % 5000*1

% Add ones to the X data matrix
X = [ones(m, 1) X];  % 5000*401

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned logistic regression parameters (one-vs-all).
%               You should set p to a vector of predictions (from 1 to
%               num_labels).
%
% Hint: This code can be done all vectorized using the max function.
%       In particular, the max function can also return the index of the 
%       max element, for more information see 'help max'. If your examples 
%       are in rows, then, you can use max(A, [], 2) to obtain the max 
%       for each row.
%       

scores = X * all_theta'; % 5000*10，得到每个实例的分类分数，10个模型，即每个实例都会有10个分类分数。
[~, p] = max(scores, [], 2); % 5000*1，取这10个分类分数最高的分类器，最为分类结果。 p 记录矩阵每行的最大值的索引，即p代表哪个分类器。

% =========================================================================

end
