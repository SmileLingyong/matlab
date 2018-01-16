%% 函数功能： 找一维数组A中第二小的元素以及下标
function [min, idx] = findSecondMin(A)
    B = A;
    n = length(A);
    for i = 1 : n - 1
        for j = i + 1 : n
            if A(i) > A(j)
                temp = A(j);
                A(j) = A(i);
                A(i) = temp;
            end
        end
    end
    
    min = A(2);
    idx = find(B == min);
end