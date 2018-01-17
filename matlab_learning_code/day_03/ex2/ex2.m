%% Machine Learning Online Class - Exercise 2: Logistic Regression
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the logistic
%  regression exercise. You will need to complete the following functions 
%  in this exericse:
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% Load Data
%  The first two columns contains the exam scores and the third column
%  contains the label.

data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

%% ==================== Part 1: Plotting ====================
%  We start the exercise by first plotting the data to understand the 
%  the problem we are working with.

fprintf(['Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']);

plotData(X, y);

% Put some labels 
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, you will implement the cost and gradient
%  for logistic regression. You neeed to complete the code in 
%  costFunction.m

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X);

% Add intercept term to x and X_test
X = [ones(m, 1) X];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

% Compute and display initial cost and gradient
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n -0.1000\n -12.0092\n -11.2628\n');

% Compute and display cost and gradient with non-zero theta
test_theta = [-24; 0.2; 0.2];
[cost, grad] = costFunction(test_theta, X, y);

fprintf('\nCost at test theta: %f\n', cost);
fprintf('Expected cost (approx): 0.218\n');
fprintf('Gradient at test theta: \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n 0.043\n 2.566\n 2.647\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= Part 3: Optimizing using fminunc  =============
%  In this exercise, you will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
% f = @(t)(...t...) 创建了一个函数句柄。
% f为函数名称，t为输入变量，后面为执行语句。
% 可以参考博客：http://blog.csdn.net/luckydongbin/article/details/1497391 （有具体的fminunc如何使用）
[theta, cost] = ...
	fminunc( @(t)(costFunction(t, X, y)), initial_theta, options );  %% not clearly of this function.
% 通过使用拟牛顿法，设置相应的option参数，自动求解代价函数costFunction，使得代价函数最小时的theta值，以及最小的代价cost
% fminunc通过给定初始值 initial_theta，传入第一个匿名函数中@(t)(costFunction(t, X, y))，即传入t中。然后，使用options参数中指定的优化参数（打开梯度下降，最大迭代次数为400）,找到使代价函数costFucntion中J最小时的theta，然后返回此时求得的theta
% 其中 的initial_theta 传入了fminunc中的第一个参数 @(t)(costFunction(t, X, y))  的
% t中，workspace工作空间中存在的X，y会被自动输入到costFunction(t, X,y)中去，这样才能调用costFunction(t, X, y)函数。
% 这样写的目的，是比较方便调用函数，我们只需要传入初始的 initial_theta于匿名函数中，其他的参数X, y，匿名函数会自行出入进来。(自己是这样理解的)

% 其中，@(t)(costFunction(t, X, y)) 定义了一个匿名函数，其输入参数为t。这一句相当于 fun = @(t)(costFunction(t, X, y))，以后使用的时候直接通过
% fun(28)这种形式就可以调用该匿名函数，其就相当于调用了costFunction(28, X, y)，这里的X，y是已经存在workspace中的变量，会被costFunction函数自动调用传入计算。

% 补充函数句柄@ 以及 fminunc()函数功能理解. （自己的印象笔记）
% 参考官方文档：https://cn.mathworks.com/help/optim/ug/fminunc.html?s_tid=srchtitle


% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('Expected cost (approx): 0.203\n');
fprintf('theta: \n');
fprintf(' %f \n', theta);
fprintf('Expected theta (approx):\n');
fprintf(' -25.161\n 0.206\n 0.201\n');

% Plot Boundary
plotDecisionBoundary(theta, X, y);

% Put some labels 
hold on;
% Labels and Legend
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% Specified in plot order
% legend('Admitted', 'Not admitted')  % This is needless
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== Part 4: Predict and Accuracies ==============
%  After learning the parameters, you'll like to use it to predict the outcomes
%  on unseen data. In this part, you will use the logistic regression model
%  to predict the probability that a student with score 45 on exam 1 and 
%  score 85 on exam 2 will be admitted.
%
%  Furthermore, you will compute the training and test set accuracies of 
%  our model.
%
%  Your task is to complete the code in predict.m

%  Predict probability for a student with score 45 on exam 1 
%  and score 85 on exam 2 

prob = sigmoid([1 45 85] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n'], prob);
fprintf('Expected value: 0.775 +/- 0.002\n\n');

% Compute accuracy on our training set
% 通过使用 优化的梯度下降 计算出的 tehta，来计算训练集的预测值p
% 然后与实际值对比，计算出我们预测的精度。
p = predict(theta, X);
fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (approx): 89.0\n');
fprintf('\n');


