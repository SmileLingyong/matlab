function out = mapFeature(X1, X2)
% MAPFEATURE Feature mapping function to polynomial features
%
%   MAPFEATURE(X1, X2) maps the two input features
%   to quadratic features used in the regularization exercise.
%
%   Returns a new feature array with more features, comprising of 
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, etc..
%
%   Inputs X1, X2 must be the same size
%   return out 118*28 表示新构造出来的特征。共有118个实例，每个实例有28个特征，即有28列。

%  使用已有的特征的幂来当做新的特征，这里最高6次幂。
%  查看ex2.pdf中的那个图，就可以看懂表达的意思，下面的式子要多看几遍

    degree = 6;
    out = ones(size(X1(:,1)));
    % n = 0;  % which is uesd to testing
    for i = 1 : degree
        for j = 0 : i
%             n = n + 1;
            out(:, end+1) = (X1.^(i-j)).*(X2.^j);   % add each newly constructed polynomial to the next column  
    %         fprintf('%d___( X1.^[%d] ) .* ( X2.^[%d] )\n', n, i- j, j); 
        end
    end
    
end