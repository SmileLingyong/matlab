function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%


%% First method (using pdist2() function)
% m = size(X, 1);    % the number of X
% for i = 1 : m
%     distance = pdist2(centroids, X(i, :));   % calculate the distance of each X(i, :) and centroids
%     [min_distance, idx(i)] = min(distance);  % return the closest centroids minist distance and index (返回该点离最近聚类中心的距离，以及该聚类中心的索引)
% end
% save('data.mat');

%% Second method （using looping to calculating） 
distance = zeros(3, 1);
m = size(X, 1);     % the number of X
for i = 1 : m
   for j = 1 : K
       distance(j) = sqrt(sum(((X(i, :) - centroids(j, :)) .^2 )));  % (欧几里得距离公式)
   end
   [min_distance, idx(i)] = min(distance);   
end
% =============================================================

end

