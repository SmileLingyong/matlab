function sim = gaussianKernel(x1, x2, sigma)
%RBFKERNEL returns a radial basis function kernel between x1 and x2
%   sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
%   and returns the value in sim

% Ensure that x1 and x2 are column vectors
x1 = x1(:); x2 = x2(:);  % 将行向量转化为列向量

% You need to return the following variables correctly.
sim = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the similarity between x1
%               and x2 computed using a Gaussian kernel with bandwidth
%               sigma
%
%
% 这个函数可以直接根据Gaussian kernel公式就可以写出.
sim = exp(- pdist2(x1', x2' ) .^ 2  /  (2 * (sigma ^ 2)));  % 其中pdist2用于求x1 和 x2 之间的欧氏距离. （可以参考官方文档 或 参考博客：http://www.cnblogs.com/molakejin/p/5867255.html）

% % 或者直接使用 sum计算欧氏距离：
% sim = exp(- sum(x1, x2) .^ 2  /  (2 * (sigma ^ 2)));  
% =============================================================
    
end
