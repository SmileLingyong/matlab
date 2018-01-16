%% Homework of Advanced software development technology and tools 
% Creation         :    17-Oct-2017
% Last Reversion   :    21-Oct-2017
% Author           :    Lingyong Smile {smilelingyong@163.com}
% File Type        :    Matlab
% -------------------------------------------------------------------------
% Lingyong Smile @ 2017
% 
% ��ҵҪ��
%     ���û��켣���з��࣬��ͬ������Ĺ켣��Ϊһ��
% ������������ڲٳ�������ɢ�������û�����ٳ����뿪�ٳ���¼����ÿ�����µ����꣨x,y��
% ������������n��������������ȫ�����갴���¼���������������˶��켣��(x1,y1) (x2,y2),��(xn,yn)
% Ҫ���ȫ��M���˵Ĺ켣���࣬��ͬ������Ĺ켣��Ϊһ�ࡣ
% ע�⣺ÿ���˵Ĳ������ܲ�һ��������Ҳ���ܲ�һ����������뿪�ٳ��ĵص㶼������ġ�
% ���룺M���˹켣������켣�������ֵ��XXX����������
% ��������ɸ�����(ÿ�������·����
% �㷨�������㷨������/�����㷨������


%% Init
clc;
clear;
close all;

% ������ֵ
MAX_DISTENCE = 0.08;

%% �ֶ�����ÿ���û��Ĺ켣�㲢��¼������Ȼ�󻭳��˶��켣����ֱ����������ÿһ�㣩
figure(1);
person_num = input('������Ҫ���ƹ켣������');
legend_list = cell(person_num, 1);          % ����һ��cell����,���ڴ��ÿ���켣���û���
for i = 1 : person_num
    [person(i).x, person(i).y] = ginput;    % ��¼ÿ���û��Ĺ켣����
    person(i).length = length(person(i).x);
    person(i).kind = i;  % ��ʼ��¼�û�������
    person(i).flag = 0;  % ��ʼ��¼�û�������
    plot(person(i).x, person(i).y);         
    axis([0, 1, 0, 1]);
    legend_list{i} = num2str(i); % ��¼ÿ���켣���û���     
    text(person(i).x(2), person(i).y(2), num2str(i));   % Ϊÿ���켣�߱�ע������ֱ������������
    text(0.82, 0.09, ['��ֵΪ:',num2str(MAX_DISTENCE)]);
    hold on;
end
legend(legend_list);  % ���ͼ��      
title('The original trajectory of the user on the playground');
save('person_data3.mat');  % �����û��켣���ݣ����ڲ���ʱʹ��
hold off;


%% ��þ������,��������Ӧ�����ݴ���
distance = cell(1, person_num);  % ��ʼ������cell���飬���ڴ�ŵ�i�����ߵ� ���� ���߾���
dist_idx = 1;

% �����߼����������ϵ
for i = 1 : person_num
    % ������i���������߾���
    for j = 1 : person_num
        distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % ��������i��ÿһ�㣬������j��ÿһ�����
        distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % ������i��ÿ���㣬����j�����������е����Сֵ, ÿһ��ȡ��Сֵ
        person(i).distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / length(person(i).x); % ��������i������j�ľ�����Сֵ��ƽ��ֵ
        dist_idx = dist_idx + 1;             
    end   
    dist_idx = 1;
end

% �õ�����������A
for i = 1 : person_num
    A(i, :) = person(i).distance_line_to_line_min;
end
A = cell2mat(A);   % ��cell��ת��Ϊ��������

% �Ծ���������з���
m = size(A, 1);
for i = 1 : m
    [min_dist, min_dist_idx] = findSecondMin(A(i, :));
    if(A(i, min_dist_idx) < MAX_DISTENCE)     
        if person(i).flag == 0
            person(i).kind = min_dist_idx;
            person(min_dist_idx).flag = 1;           
        end 
    end
%     fprintf("�� %d ���������� %d ��\n",i, person(i).kind);
end


%% �õ�������飬�����з��� (unique())
kind_array = zeros(person_num, 1);
for i = 1 : person_num
    kind_array(i) = person(i).kind;
end
[cluster, ia, kind_idx] = unique(kind_array);
% ���� cluster �ֵ�������࣬ kind_idx ��ǰ���ڵڼ���


%% ��ӡ��������Ϣ
fprintf("�ܹ��� %d ��:\n", length(cluster));
for i = 1 : person_num
    fprintf("�� %d ���������� �� %d ��\n",i, kind_idx(i));
end


%% �������ܣ� ��һά����A�еڶ�С��Ԫ���Լ��±�
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