function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
n = length(theta);
theta_new = theta;

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
   %% First method of using loop
    for j = 1 : n    
        theta_new(j) = theta(j) - (alpha / m) * sum( (X*theta - y).* X(:, j) );
    end
    theta = theta_new;
    
    %% Second method of using vector implementation, which is equal to the first
%     theta = theta - ( alpha / m ) * X' * (X * theta - y);   % you have read these more time, which is not easy to understand.
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
