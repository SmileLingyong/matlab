%多项式拟合函数polyfit示例
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
y=[-0.4471 0.978 3.28 6.16 7.08 7.34 7.66 9.56 9.48 9.30 11.2];
n=7;%polynomial order
p=polyfit(x, y, n);
%polyfit 的输出是一个多项式系数的行向量。
%其解是y = －9.8108x2＋20.1293x－0.0317。为了将曲线拟合解与数据点比较，让我们把二者都绘成图。
xi=linspace(0, 1, 100);%x-axis data for plotting
z=polyval(p, xi);%polyval 求多项式值
plot(x, y, ' o ' , x, y, xi, z, ' : ' )
xlabel('x')
ylabel('y=f(x)')
title('Second Order Curve Fitting')


%% 计算曲线间的距离
distance = cell(person_num * (person_num - 1) / 2);  % n 条线共有 (n*(n-1))/2 对距离 (这里AB 和 BA 都算做两组)
dist_idx = 1;     % 用于反推记录的是第几组距离，每一组person_num-1 个曲线距离
% cluster = cell(person_num, 1);
% cluster_idx = 1;  % 用于记录总共有多少簇
kind_num = person_num;  % 记录总共的类别
for i = 1 : person_num - 1
    for j = i + 1 : person_num 
        distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % 得到 i 到 j 上点的欧式距离
        distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % 取由第i条曲线上每个点，到第j条曲线上所有点的最小值, 每一行取最小值
        distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % 计算曲线i到曲线j的距离最小值的平均值
        dist_idx = dist_idx + 1;    

        if(j ~= i)
            distance{dist_idx} = pdist2([person(i).x, person(i).y], [person(j).x, person(j).y]);  % 得到 i 到 j 上点的欧式距离
            distance_point_to_line_min{dist_idx} = min(distance{dist_idx}, [], 2);   % 取由第i条曲线上每个点，到第j条曲线上所有点的最小值, 每一行取最小值
            distance_line_to_line_min{dist_idx} = sum(distance_point_to_line_min{dist_idx}) / person(i).length; % 计算曲线i到曲线j的距离最小值的平均值
            dist_idx = dist_idx + 1;
        end
    end
    person(i).min_dis = min(distance_line_to_line_min)
    
    
    
    
    
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
    dist_idx = 1;
