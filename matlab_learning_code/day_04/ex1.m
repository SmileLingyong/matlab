%% Homework of Advanced software development technology and tools 
% Creation         :    17-Oct-2017
% Last Reversion   :    17-Oct-2017
% Author           :    Lingyong Smile {smilelingyong@163.com}
% File Type        :    Matlab
% -------------------------------------------------------------------------
% Lingyong Smile @ 2017
% 
% 作业要求：
%     对用户轨迹进行分类，相同或相近的轨迹归为一类
% 背景：多个人在操场上随意散步。从用户进入操场到离开操场记录下他每步踩下的坐标（x,y）
% 假设他共走了n步，把他经过的全部坐标按序记录下来，就是他的运动轨迹：(x1,y1) (x2,y2),…(xn,yn)
% 要求把全部M个人的轨迹分类，相同或相近的轨迹归为一类。
% 注意：每个人的步数可能不一样，步距也可能步一样，进入和离开操场的地点都是随意的。
% 输入：M个人轨迹；相近轨迹距离最大值；XXX参数，……
% 输出：若干个分类(每类包含的路径）
% 算法：常规算法，分类/聚类算法，……


%% Init
clc;
clear;
close all;

%% 手动绘制每个用户的轨迹点并记录下来，然后画出运动轨迹（用直线依次连接每一点）
% figure(1);
% person_num = input('输入需要绘制轨迹人数：');
% legend_list = cell(person_num, 1);          % 创建一个cell数组,用于存放每条轨迹的用户名
% for i = 1 : person_num
%     [person(i).x, person(i).y] = ginput;    % 记录每个用户的轨迹坐标
%     person(i).length = length(person(i).x);
%     person(i).kind = i;  % 初始记录用户的种类
%     person(i).flag = 0;  % 初始记录用户的种类
%     plot(person(i).x, person(i).y);         
%     axis([0, 1, 0, 1]);
%     legend_list{i} = num2str(i); % 记录每条轨迹的用户名    
% %     legend_list{i} = ['person', num2str(i)];% 记录每条轨迹的用户名    
%     text(person(i).x(2), person(i).y(2), num2str(i));   % 为每条轨迹线标注，便于直接在线上区分
%     hold on;
% end
% legend(legend_list);  % 添加图例      
% title('The original trajectory of the user on the playground');
% save('person_data1.mat');  % 保存用户轨迹数据，用于测试时使用
% hold off;



%% 直接load画好的16条线进行调试
clc;
clear;
close all;

figure(1);
load('person_data.mat');
for i = 1 : person_num
    plot(person(i).x, person(i).y);         
    axis([0, 1, 0, 1]);
    legend_list{i} = num2str(i); % 记录每条轨迹的用户名 
    text(person(i).x(2), person(i).y(2), num2str(i));   % 为每条轨迹线标注，便于直接在线上区分
    hold on;
end
legend(legend_list);  % 添加图例      
title('The original trajectory of the user on the playground');
% save('person_data.mat');  % 保存用户轨迹数据，用于测试时使用
hold off;



%% 拟合每个用户的轨迹曲线函数（多项式函数）
% figure(2);
% n = 8;  % n specifies the polynomial power of the left-most coefficient in p.
%          % n 指定了p中最左边的系数的多项式的幂
%          % 如 n = 3时， 通过函数poly()求得拟合函数（类似于这样的结构） ：y = －9.8108x2＋20.1293x－0.0317
% z = cell(person_num, 1);   % 用于存放我们后面的选取的样本点的拟合函数值
% for i = 1 : person_num
%    if person(i).length <= n - 1      % 当一个人的步数很少时，比预设的n-1还要小，这样我们就需要减少拟合多项式的参数，来求多项式拟合曲线
%        person(i).func = polyfit(person(i).x, person(i).y, person(i).length - 3);
%    else
%        person(i).func = polyfit(person(i).x, person(i).y, n);  % 求得拟合曲线函数
%    end
%    xi = linspace(person(i).x(1), person(i).x( length(person(i).x)), 100); % 在曲线的横坐标方向选取100个点
%    z{i} = polyval(person(i).func, xi);  % 求多项式的值
%    plot(person(i).x, person(i).y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 3); % 绘画出用户轨迹的每一步点
%    hold on;
%    plot(xi, z{i}, ':', 'LineWidth', 2);  % 拟合绘画出的多项式函数曲线
%    axis([0, 1, 0, 1]);
% end
% xlabel('x');
% ylabel('y = f(x)');
% title('Second Order Curve Fitting'); 



%% 计算曲线间的距离
% 初始化标记位
for i = 1 : person_num
    person(i).kind = i;
    person(i).flag = 0;
end
        
% 计算曲线间的距离
distance = cell(person_num );  % n 条线共有 (n*n) 对距离 (这里AB 和 BA 都算做两组)
dist_idx = 1;     % 用于反推记录的是第几组距离，每一组person_num-1 个曲线距离
% cluster = cell(person_num, 1);
% cluster_idx = 1;  % 用于记录总共有多少簇
kind_num = person_num;  % 记录总共的类别
for i = 1 : person_num
    for j = 1 : person_num 
        if(j ~= i)
            distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % 得到 i 到 j 上点的欧式距离
            distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % 取由第i条曲线上每个点，到第j条曲线上所有点的最小值, 每一行取最小值
            distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % 计算曲线i到曲线j的距离最小值的平均值
            dist_idx = dist_idx + 1;    
        else
            person(i).distance_line_to_line_min{dist_idx} = 0;
            dist_idx = dist_idx + 1;
        end
     
    end

    [min_distance, min_line_idx] = min(cell2mat(person(i).distance_line_to_line_min));  % 找到与第i条距离最小的轨迹 下标 min_line_idx
    if person(i).distance_line_to_line_min{1, min_line_idx} > 0.5 
        person(i).kind = kind_num + 1;
        kind_num = kind_num + 1;
    else 
        if person(min_line_idx).flag == 1
            person(i).kind = person(min_line_idx).kind;
        else    
            person(min_line_idx).kind = person(i).kind;  
            person(min_line_idx).flag = 1;  % 说明该点已经标记过
        end
    end
%     dist_idx = 1;
end



% 求第二小的数，以及下标
function [min, idx] = findSecondMin(A)
    B = A;
    n = size(A);
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