%����ʽ��Ϻ���polyfitʾ��
% http://blog.sciencenet.cn/blog-41996-503057.html
x=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
y=[-0.4471 0.978 3.28 6.16 7.08 7.34 7.66 9.56 9.48 9.30 11.2];
n=2;%polynomial order
p=polyfit(x, y, n);
%polyfit �������һ������ʽϵ������������
%�����y = ��9.8108x2��20.1293x��0.0317��Ϊ�˽�������Ͻ������ݵ�Ƚϣ������ǰѶ��߶����ͼ��
xi=linspace(0, 1, 100);%x-axis data for plotting
z=polyval(p, xi);%polyval �����ʽֵ
plot(x, y, ' o ' , x, y, xi, z, ' : ' )
xlabel('x')
ylabel('y=f(x)')
title('Second Order Curve Fitting')

