function [h, display_array] = displayData(X, example_width)
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the 
%   displayed array if requested.
%   X = 100 * 400 = 100 * 20(example_width) * 20(example_height) 
%   which means 100 digists of 20 * 20 pix

% Set example_width automatically if not passed in
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2))); % round() function is round to nearest decimal or integer
end

% Gray Image
% colormap(gray);
colormap(gray);

% Compute rows, cols : 100 x 400
[m n] = size(X);
example_height = (n / example_width);  % 20

% Compute number of items to display
display_rows = floor(sqrt(m));      % round toward negative infinity % 10
display_cols = ceil(m / display_rows);  % round toward positive infinity % 10

% Between images padding
pad = 1;

% Setup blank display 
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));

% Copy each example into a patch on the display array
curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% Copy the patch
		
		% Get the max value of the patch
        % reshape each X rol 1 * 400 to 20 * 20, and add pad set to display_array.
        % 表示的意思就是，将X 的每一行（一个手写数字）,转化为
        % 20*20像素，即可以将每一行放到画板中20*20像素的正方形框中，并为每一个正方框间加上一个pad = 1 像素来表示间隔
        % 自己手动稍微列一下下面的数字既可以明白
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Display Image. 
% imagesc(C) function : Displays the data in array C as an image that uses the
% full range of colors in the colormap. Each element of C specifies the
% color for 1 pixel of the image.
% imagesc(___,clims) function :  指定映射到颜色图的第一个和最后一个元素的数据值。
% 将 clims 指定为 [cmin cmax] 形式的二元素矢量，其中小于或等于 cmin 的值映射到颜色图中的第一种颜色，大于或等于 cmax 的值映射到颜色图中的最后一种颜色。
h = imagesc(display_array, [-1 1]);

% Do not show axis
axis image off

drawnow;

end
