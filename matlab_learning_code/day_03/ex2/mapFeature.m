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
%   return out 118*28 ��ʾ�¹������������������118��ʵ����ÿ��ʵ����28������������28�С�

%  ʹ�����е����������������µ��������������6���ݡ�
%  �鿴ex2.pdf�е��Ǹ�ͼ���Ϳ��Կ���������˼�������ʽ��Ҫ�࿴����

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