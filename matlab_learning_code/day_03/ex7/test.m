%����ʽ��Ϻ���polyfitʾ��
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
y=[-0.4471 0.978 3.28 6.16 7.08 7.34 7.66 9.56 9.48 9.30 11.2];
n=7;%polynomial order
p=polyfit(x, y, n);
%polyfit �������һ������ʽϵ������������
%�����y = ��9.8108x2��20.1293x��0.0317��Ϊ�˽�������Ͻ������ݵ�Ƚϣ������ǰѶ��߶����ͼ��
xi=linspace(0, 1, 100);%x-axis data for plotting
z=polyval(p, xi);%polyval �����ʽֵ
plot(x, y, ' o ' , x, y, xi, z, ' : ' )
xlabel('x')
ylabel('y=f(x)')
title('Second Order Curve Fitting')


%% �������߼�ľ���
distance = cell(person_num * (person_num - 1) / 2);  % n ���߹��� (n*(n-1))/2 �Ծ��� (����AB �� BA ����������)
dist_idx = 1;     % ���ڷ��Ƽ�¼���ǵڼ�����룬ÿһ��person_num-1 �����߾���
% cluster = cell(person_num, 1);
% cluster_idx = 1;  % ���ڼ�¼�ܹ��ж��ٴ�
kind_num = person_num;  % ��¼�ܹ������
for i = 1 : person_num - 1
    for j = i + 1 : person_num 
        distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % �õ� i �� j �ϵ��ŷʽ����
        distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % ȡ�ɵ�i��������ÿ���㣬����j�����������е����Сֵ, ÿһ��ȡ��Сֵ
        distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % ��������i������j�ľ�����Сֵ��ƽ��ֵ
        dist_idx = dist_idx + 1;    

        if(j ~= i)
            distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % �õ� i �� j �ϵ��ŷʽ����
            distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % ȡ�ɵ�i��������ÿ���㣬����j�����������е����Сֵ, ÿһ��ȡ��Сֵ
            distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % ��������i������j�ľ�����Сֵ��ƽ��ֵ
            dist_idx = dist_idx + 1;
        end
    end
    person(i).min_dis = min(distance_line_to_line_min)
    
    
    
    
    
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
    dist_idx = 1;
