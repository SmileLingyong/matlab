function plotDecisionBoundary(theta, X, y)
%PLOTDECISIONBOUNDARY Plots the data points X and y into a new figure with
%the decision boundary defined by theta
%   PLOTDECISIONBOUNDARY(theta, X,y) plots the data points with + for the 
%   positive examples and o for the negative examples. X is assumed to be 
%   a either 
%   1) Mx3 matrix, where the first column is an all-ones column for the 
%      intercept.
%   2) MxN, N>3 matrix, where the first column is all-ones

% Plot Data
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    % 通过选取 横坐标最小和最大值 +- 2的两点，然后接着计算对应的纵坐标的值，就可以画出决策边界。（两点确定一条直线）
    % 这里的plot_x 代表选取两点的横坐标（Exam 1 sorce），也表示 X的第一个特征
    %           plot_y 代表选取两点的纵坐标（Exam 2 sorce），也表示 X的第二个特征    
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));
    % 直接令logistic回归（hx）的值为0.5, g(z) = 0.5，则可以得到e的指数为0，即X*theta == 0, 即：
    % theta(1)*1+theta(2)*plot_x+theta(3)*plot_y=0,解出plot_y即可。
    % 这里的plot_x 代表横坐标（Exam 1 sorce），也表示 X的第一个特征
    %           plot_y 代表纵坐标（Exam 2 sorce），也表示 X的第二个特征

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
    
    % Legend, specific for the exercise
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else   %%  如果X的特征超过2个的时候，即列数超过3时（因为第一列是自己补的 1）,
         %     就不能和上面一样通过画一条直搞定决策边界，则需要通过等高线的方式画出决策边界
         %     即画出非线性边界的代码
         %     这里要多看几遍，没看太懂
    % Here is the   
    u = linspace(-1, 1.5, 50);  % -1->1.5 区间50 等分取点  
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature( u(i), v(j) ) * theta;  % 其中mapFeature( u(i), v(j) ) 表示由u(i), v(j) 构成新的特征集X，然后用X* theta即为 z
        end
    end
    z = z'; % important to transpose z before calling contour

    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [0, 0], 'LineWidth', 2)  % 绘制一条函数值z在 0-0 直之间的等高线，即值为0 的等高线，因为为0时刚好概率为0.5，符合要求
    % 指的是在二维平面U-V中绘制曲面z的轮廓，z的值为0，轮廓线宽为2。注意此时的z对应的范围应该与U和V所表达的范围相同。
    % 因为contour函数是用来等高线，而本实验中只需画一条等高线，所以第4个参数里面的值都是一样的，这里为[0,0],0指的是函数值z在0和0之间的等高线(很明显，只能是一条)
    
end
hold off

end
