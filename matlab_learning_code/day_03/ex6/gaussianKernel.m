function sim = gaussianKernel(x1, x2, sigma)
%RBFKERNEL returns a radial basis function kernel between x1 and x2
%   sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
%   and returns the value in sim

% Ensure that x1 and x2 are column vectors
x1 = x1(:); x2 = x2(:);  % ��������ת��Ϊ������

% You need to return the following variables correctly.
sim = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the similarity between x1
%               and x2 computed using a Gaussian kernel with bandwidth
%               sigma
%
%
% �����������ֱ�Ӹ���Gaussian kernel��ʽ�Ϳ���д��.
sim = exp(- pdist2(x1', x2' ) .^ 2  /  (2 * (sigma ^ 2)));  % ����pdist2������x1 �� x2 ֮���ŷ�Ͼ���. �����Բο��ٷ��ĵ� �� �ο����ͣ�http://www.cnblogs.com/molakejin/p/5867255.html��

% % ����ֱ��ʹ�� sum����ŷ�Ͼ��룺
% sim = exp(- sum(x1, x2) .^ 2  /  (2 * (sigma ^ 2)));  
% =============================================================
    
end
