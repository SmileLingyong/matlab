%% Homework of Advanced software development technology and tools 
% Creation         :    17-Oct-2017
% Last Reversion   :    17-Oct-2017
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
% save('person_data1.mat');  % �����û��켣���ݣ����ڲ���ʱʹ��
% hold off;



%% ֱ��load���õ�16���߽��е���
clc;
clear;
close all;

figure(1);
load('person_data.mat');
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
%    if person(i).length <= n - 1      % ��һ���˵Ĳ�������ʱ����Ԥ���n-1��ҪС���������Ǿ���Ҫ������϶���ʽ�Ĳ������������ʽ�������
%        person(i).func = polyfit(person(i).x, person(i).y, person(i).length - 3);
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



%% �������߼�ľ���
% ��ʼ�����λ
for i = 1 : person_num
    person(i).kind = i;
    person(i).flag = 0;
end
        
% �������߼�ľ���
distance = cell(person_num );  % n ���߹��� (n*n) �Ծ��� (����AB �� BA ����������)
dist_idx = 1;     % ���ڷ��Ƽ�¼���ǵڼ�����룬ÿһ��person_num-1 �����߾���
% cluster = cell(person_num, 1);
% cluster_idx = 1;  % ���ڼ�¼�ܹ��ж��ٴ�
kind_num = person_num;  % ��¼�ܹ������
for i = 1 : person_num
    for j = 1 : person_num 
        if(j ~= i)
            distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % �õ� i �� j �ϵ��ŷʽ����
            distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % ȡ�ɵ�i��������ÿ���㣬����j�����������е����Сֵ, ÿһ��ȡ��Сֵ
            distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % ��������i������j�ľ�����Сֵ��ƽ��ֵ
            dist_idx = dist_idx + 1;    
        else
            person(i).distance_line_to_line_min{dist_idx} = 0;
            dist_idx = dist_idx + 1;
        end
     
    end

    [min_distance, min_line_idx] = min(cell2mat(person(i).distance_line_to_line_min));  % �ҵ����i��������С�Ĺ켣 �±� min_line_idx
    if person(i).distance_line_to_line_min{1, min_line_idx} > 0.5 
        person(i).kind = kind_num + 1;
        kind_num = kind_num + 1;
    else 
        if person(min_line_idx).flag == 1
            person(i).kind = person(min_line_idx).kind;
        else    
            person(min_line_idx).kind = person(i).kind;  
            person(min_line_idx).flag = 1;  % ˵���õ��Ѿ���ǹ�
        end
    end
%     dist_idx = 1;
end



% ��ڶ�С�������Լ��±�
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