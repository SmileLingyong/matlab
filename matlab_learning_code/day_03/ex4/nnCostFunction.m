function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
% nn_params ：10285*1 = 25*401 + 10*26
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
            % reshape( nn_params(1:25*401),   25,   401);  % 将nn_params的前1：(25*401)元素向量，重构为 25x401的矩阵

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
            % reshape(   nn_params((1+25*401) : end)  ,   10,    25+1 )  %
            % 将nn_params的 25*401+1 ：end的元素向量，重构为10x(25+1)的矩阵

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));  % 25x401
Theta2_grad = zeros(size(Theta2));  % 10x26

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
X = [ones(m, 1), X]; % 5000x401
% Part 1：Cost Function.
% ---------------------------------------------------------------------------------------------------------
a1 = X;     % 5000x401
z2 = a1 * Theta1';       % 5000x25
a2 = sigmoid(z2);        % 5000x25
a2 = [ones(m, 1)  a2];  % 5000x26
z3 = a2 * Theta2';        % 5000x10
hx = sigmoid(z3);         % 5000x10

% 这部分自己要好好理解一下（自己调试一个个元素看一下，能够理解意思）
yk = zeros(m, num_labels);  % yk：5000x10
for i = 1 : m
    yk(i, y(i)) = 1;   % 如yk(1, 10) = 1表示，在yk中，第一行中第10个元素为1，其余的元素为0。
                            % 表示第一个实例真实值为10。补零是为了可以和 hx做矩阵乘法。
                            %     yk(3201, 6) = 1，即yx中第3201行中第6个元素为为1，其余的元素为0，表示第3201个实例的真实值是6
end

J = (1 / m) * sum( sum( (-yk) .* log(hx)   -   (1 - yk) .* log(1 - hx) ) );
reg = (lambda / (2 * m) ) * (   sum(sum(Theta1(:, 2:end) .^ 2 )) + sum(sum(Theta2(:, 2:end) .^2 ))    );

% Implement Regularization
J = J + reg;
% ---------------------------------------------------------------------------------------------------------





% Part2 : Backpropagation algorithm
%  ------------------------------------------------------------------------------------------------------------------------
%  这里根据作业PDF看公式理解一下即可，注意每个变量里面的内容，然后就可以比较清晰.
% %  方法一：使用循环--------------------------------
% for row = 1 : m
%     a1 = X(row, :)';  % 401x1
%     z2 = Theta1 * a1;   % 25x1
%     a2 = sigmoid(z2);   % 25x1
%     a2 = [1; a2];            % 26x1
%     z3 = Theta2 * a2;   % 10x1
%     a3 = sigmoid(z3);    % 10x1
%     
%     delta3_temp = a3 - yk';  % 10x5000
%     delta3 = delta3_temp(:, row); % 10x1
%     
%     delta2_temp = Theta2' * delta3;
%     delta2 = delta2_temp(2 : end) .* sigmoidGradient(z2); 
%     
%     Theta1_grad = Theta1_grad + delta2 * a1';
%     Theta2_grad = Theta2_grad + delta3 * a2';
%     
% end
% 
% Theta1_grad = Theta1_grad ./ m;
% Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end)  + (lambda/m) * Theta1(:, 2:end);
% 
% Theta2_grad = Theta2_grad ./ m;
% Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + + (lambda/m) * Theta2(:, 2:end);


% 方法二：使用矩阵的方式--------------------
delta3 = hx - yk;
temp = delta3 * Theta2;
delta2 = temp(:, 2:end) .* sigmoidGradient(z2);

Delta1 = delta2' * a1;
Delta2 = delta3' * a2;

Theta1_grad = Delta1 / m + lambda * [zeros(hidden_layer_size, 1)   Theta1(:, 2:end)] / m;
Theta2_grad = Delta2 / m + lambda * [zeros(num_labels, 1)  Theta2(:, 2:end)] / m;


% =========================================================================
% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
