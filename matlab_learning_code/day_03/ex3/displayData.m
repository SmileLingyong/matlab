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
        % ��ʾ����˼���ǣ���X ��ÿһ�У�һ����д���֣�,ת��Ϊ
        % 20*20���أ������Խ�ÿһ�зŵ�������20*20���ص������ο��У���Ϊÿһ������������һ��pad = 1 ��������ʾ���
        % �Լ��ֶ���΢��һ����������ּȿ�������
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
% imagesc(___,clims) function :  ָ��ӳ�䵽��ɫͼ�ĵ�һ�������һ��Ԫ�ص�����ֵ��
% �� clims ָ��Ϊ [cmin cmax] ��ʽ�Ķ�Ԫ��ʸ��������С�ڻ���� cmin ��ֵӳ�䵽��ɫͼ�еĵ�һ����ɫ�����ڻ���� cmax ��ֵӳ�䵽��ɫͼ�е����һ����ɫ��
h = imagesc(display_array, [-1 1]);

% Do not show axis
axis image off

drawnow;

end
