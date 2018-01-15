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
% figure(1);
% person_num = input('������Ҫ���ƹ켣������');
% legend_list = cell(person_num, 1);          % ����һ��cell����,���ڴ��ÿ���켣���û���
% for i = 1 : person_num
%     [person(i).x, person(i).y] = ginput;    % ��¼ÿ���û��Ĺ켣����
%     person(i).length = length(person(i).x);
%     person(i).kind = i;  % ��ʼ��¼�û�������
%     person(i).flag = 0;  % ��ʼ��¼�û�������
%     plot(person(i).x, person(i).y);         
%     axis([0, 1, 0, 1]);
%     legend_list{i} = num2str(i); % ��¼ÿ���켣���û���    
% %     legend_list{i} = ['person', num2str(i)];% ��¼ÿ���켣���û���    
%     text(person(i).x(2), person(i).y(2), num2str(i));   % Ϊÿ���켣�߱�ע������ֱ������������
%     hold on;
% end
% legend(legend_list);  % ���ͼ��      
% title('The original trajectory of the user on the playground');
% save('person_data3.mat');  % �����û��켣���ݣ����ڲ���ʱʹ��
% hold off;


%% ֱ��load���õ�16���߽��е���
figure(1);
load('person_data1.mat');
for i = 1 : person_num
    plot(person(i).x, person(i).y);         
    axis([0, 1, 0, 1]);
    legend_list{i} = num2str(i); % ��¼ÿ���켣���û��� 
    text(person(i).x(2), person(i).y(2), num2str(i));   % Ϊÿ���켣�߱�ע������ֱ������������
    hold on;
end
legend(legend_list);  % ���ͼ��      
title('The original trajectory of the user on the playground');
% save('person_data.mat');  % �����û��켣���ݣ����ڲ���ʱʹ��
hold off;


%% ���ÿ���û��Ĺ켣���ߺ���������ʽ������
% figure(2);
% n = 8;  % n specifies the polynomial power of the left-most coefficient in p.
%          % n ָ����p������ߵ�ϵ���Ķ���ʽ����
%          % �� n = 3ʱ�� ͨ������poly()�����Ϻ����������������Ľṹ�� ��y = ��9.8108x2��20.1293x��0.0317
% z = cell(person_num, 1);   % ���ڴ�����Ǻ����ѡȡ�����������Ϻ���ֵ
% for i = 1 : person_num
%    if length(person(i).x) <= n - 1      % ��һ���˵Ĳ�������ʱ����Ԥ���n-1��ҪС���������Ǿ���Ҫ������϶���ʽ�Ĳ������������ʽ�������
%        person(i).func = polyfit(person(i).x, person(i).y, length(person(i)) - 3);
%    else
%        person(i).func = polyfit(person(i).x, person(i).y, n);  % ���������ߺ���
%    end
%    xi = linspace(person(i).x(1), person(i).x( length(person(i).x)), 100); % �����ߵĺ����귽��ѡȡ100����
%    z{i} = polyval(person(i).func, xi);  % �����ʽ��ֵ
%    plot(person(i).x, person(i).y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 3); % �滭���û��켣��ÿһ����
%    hold on;
%    plot(xi, z{i}, ':', 'LineWidth', 2);  % ��ϻ滭���Ķ���ʽ��������
%    axis([0, 1, 0, 1]);
% end
% xlabel('x');
% ylabel('y = f(x)');
% title('Second Order Curve Fitting'); 


%% ��þ�����󲢽��з���
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
    fprintf("�� %d ���������� %d ��\n",i, person(i).kind);
end

        
            
    

        




