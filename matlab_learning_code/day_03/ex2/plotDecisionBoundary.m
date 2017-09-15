function plotDecisionBoundary(theta, X, y)
%PLOTDECISIONBOUNDARY Plots the data points X and y into a new figure with
%the decision boundary defined by theta
%   PLOTDECISIONBOUNDARY(theta, X,y) plots the data points with + for the 
%   positive examples and o for the negative examples. X is assumed to be 
%   a either 
%   1) Mx3 matrix, where the first column is an all-ones column for the 
%      intercept.
%   2) MxN, N>3 matrix, where the first column is all-ones

% Plot Data
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % Only need 2 points to define a line, so choose two endpoints
    % ͨ��ѡȡ ��������С�����ֵ +- 2�����㣬Ȼ����ż����Ӧ���������ֵ���Ϳ��Ի������߽߱硣������ȷ��һ��ֱ�ߣ�
    % �����plot_x ����ѡȡ����ĺ����꣨Exam 1 sorce����Ҳ��ʾ X�ĵ�һ������
    %           plot_y ����ѡȡ����������꣨Exam 2 sorce����Ҳ��ʾ X�ĵڶ�������    
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % Calculate the decision boundary line
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));
    % ֱ����logistic�ع飨hx����ֵΪ0.5, g(z) = 0.5������Եõ�e��ָ��Ϊ0����X*theta == 0, ����
    % theta(1)*1+theta(2)*plot_x+theta(3)*plot_y=0,���plot_y���ɡ�
    % �����plot_x ��������꣨Exam 1 sorce����Ҳ��ʾ X�ĵ�һ������
    %           plot_y ���������꣨Exam 2 sorce����Ҳ��ʾ X�ĵڶ�������

    % Plot, and adjust axes for better viewing
    plot(plot_x, plot_y)
    
    % Legend, specific for the exercise
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else   %%  ���X����������2����ʱ�򣬼���������3ʱ����Ϊ��һ�����Լ����� 1��,
         %     �Ͳ��ܺ�����һ��ͨ����һ��ֱ�㶨���߽߱磬����Ҫͨ���ȸ��ߵķ�ʽ�������߽߱�
         %     �����������Ա߽�Ĵ���
         %     ����Ҫ�࿴���飬û��̫��
    % Here is the   
    u = linspace(-1, 1.5, 50);  % -1->1.5 ����50 �ȷ�ȡ��  
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % Evaluate z = theta*x over the grid
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature( u(i), v(j) ) * theta;  % ����mapFeature( u(i), v(j) ) ��ʾ��u(i), v(j) �����µ�������X��Ȼ����X* theta��Ϊ z
        end
    end
    z = z'; % important to transpose z before calling contour

    % Plot z = 0
    % Notice you need to specify the range [0, 0]
    contour(u, v, z, [0, 0], 'LineWidth', 2)  % ����һ������ֵz�� 0-0 ֱ֮��ĵȸ��ߣ���ֵΪ0 �ĵȸ��ߣ���ΪΪ0ʱ�պø���Ϊ0.5������Ҫ��
    % ָ�����ڶ�άƽ��U-V�л�������z��������z��ֵΪ0�������߿�Ϊ2��ע���ʱ��z��Ӧ�ķ�ΧӦ����U��V�����ķ�Χ��ͬ��
    % ��Ϊcontour�����������ȸ��ߣ�����ʵ����ֻ�軭һ���ȸ��ߣ����Ե�4�����������ֵ����һ���ģ�����Ϊ[0,0],0ָ���Ǻ���ֵz��0��0֮��ĵȸ���(�����ԣ�ֻ����һ��)
    
end
hold off

end
