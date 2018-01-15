%% Homework of Advanced software development technology and tools 
% Creation         :    17-Oct-2017
% Last Reversion   :    21-Oct-2017
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

% 设置阈值
MAX_DISTENCE = 0.08;

%% 手动绘制每个用户的轨迹点并记录下来，然后画出运动轨迹（用直线依次连接每一点）
figure(1);
person_num = input('输入需要绘制轨迹人数：');
legend_list = cell(person_num, 1);          % 创建一个cell数组,用于存放每条轨迹的用户名
for i = 1 : person_num
    [person(i).x, person(i).y] = ginput;    % 记录每个用户的轨迹坐标
    person(i).length = length(person(i).x);
    person(i).kind = i;  % 初始记录用户的种类
    person(i).flag = 0;  % 初始记录用户的种类
    plot(person(i).x, person(i).y);         
    axis([0, 1, 0, 1]);
    legend_list{i} = num2str(i); % 记录每条轨迹的用户名     
    text(person(i).x(2), person(i).y(2), num2str(i));   % 为每条轨迹线标注，便于直接在线上区分
    text(0.82, 0.09, ['阈值为:',num2str(MAX_DISTENCE)]);
    hold on;
end
legend(legend_list);  % 添加图例      
title('The original trajectory of the user on the playground');
save('person_data3.mat');  % 保存用户轨迹数据，用于测试时使用
hold off;


%% 求得距离矩阵,并进行相应的数据处理
distance = cell(1, person_num);  % 初始化距离cell数组，用于存放第i条曲线到 所有 曲线距离
dist_idx = 1;

% 求曲线间的最近距离关系
for i = 1 : person_num
    % 求曲线i到所有曲线距离
    for j = 1 : person_num
        distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % 求条曲线i上每一点，到曲线j上每一点距离
        distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % 求曲线i上每个点，到第j条曲线上所有点的最小值, 每一行取最小值
        person(i).distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / length(person(i).x); % 计算曲线i到曲线j的距离最小值的平均值
        dist_idx = dist_idx + 1;             
    end   
    dist_idx = 1;
end

% 得到最近距离矩阵A
for i = 1 : person_num
    A(i, :) = person(i).distance_line_to_line_min;
end
A = cell2mat(A);   % 将cell型转化为矩阵类型

% 对距离数组进行分类
m = size(A, 1);
for i = 1 : m
    [min_dist, min_dist_idx] = findSecondMin(A(i, :));
    if(A(i, min_dist_idx) < MAX_DISTENCE)     
        if person(i).flag == 0
            person(i).kind = min_dist_idx;
            person(min_dist_idx).flag = 1;           
        end 
    end
%     fprintf("第 %d 条曲线属于 %d 类\n",i, person(i).kind);
end


%% 得到类别数组，并进行分类 (unique())
kind_array = zeros(person_num, 1);
for i = 1 : person_num
    kind_array(i) = person(i).kind;
end
[cluster, ia, kind_idx] = unique(kind_array);
% 其中 cluster 分的类别种类， kind_idx 当前属于第几类


%% 打印输出类别信息
fprintf("总共有 %d 类:\n", length(cluster));
for i = 1 : person_num
    fprintf("第 %d 条曲线属于 第 %d 类\n",i, kind_idx(i));
end


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