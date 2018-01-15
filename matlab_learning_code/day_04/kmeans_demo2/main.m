clc;  
clear;  
  
% ��һ������  
% ��ֵ  
mu1 = [-2 -2];  
% Э����  
S1 = [0.5 0; 0 0.5];  
% ������˹�ֲ�����  
data1 = mvnrnd(mu1, S1, 100);  
  
% �ڶ�������  
mu2 = [2 -2];  
S2 = [0.5 0; 0 0.5];  
data2 = mvnrnd(mu2, S2, 100);  
  
% ����������  
mu3 = [-2 2];  
S3 = [0.5 0; 0 0.5];  
data3 = mvnrnd(mu3, S3, 100);  
  
% ����������  
mu4 = [2 2];  
S4 = [0.5 0; 0 0.5];  
data4 = mvnrnd(mu4, S4, 100);  
  
  
% ��ʾ����  
figure();  
hold on;  
plot(data1(:,1), data1(:,2), '+');  
plot(data2(:,1), data2(:,2), 'r+');  
plot(data3(:,1), data3(:,2), 'g+');  
plot(data4(:,1), data4(:,2), 'b+');  
grid on;  
  
  
data = [data1; data2; data3; data4];  
% ���ݾ���  
[idx, ctr] = k_means(data, 4, 1000);  
[m, n] = size(idx);  
  
% ��ʾ�����Ľ��  
figure();  
hold on;  
for i=1:m  
    if idx(i, 3) == 1  
        plot(idx(i, 1), idx(i, 2), 'r.', 'MarkerSize', 12);   
    elseif idx(i, 3) == 2  
        plot(idx(i, 1), idx(i, 2), 'b.', 'MarkerSize', 12);  
    elseif idx(i, 3) == 3  
        plot(idx(i, 1), idx(i, 2), 'g.', 'MarkerSize', 12);  
    else  
        plot(idx(i, 1), idx(i, 2), 'y.', 'MarkerSize', 12);  
    end  
end  
grid on;  
  
% ����������ĵ㣬kx��ʾ�ǽ����  
plot(ctr(:,1), ctr(:,2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);  