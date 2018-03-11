% Creation           :   23-Nov-2017  13:30
% Last Reversion     :   23-Nov-2017  13:30
% Author             :   Lingyong Smile {smilelingyong@163.com}
% File type          :   matlab
%
% This is a function of batch rename files.
% ------------------------------------------------------------
% Lingyong Smile  @ 2017
% Reference: http://blog.csdn.net/u010099080/article/details/49915743

%% Init
clc;
clear;
close all;

%% main function.

root_path = 'D:\1study\�о���\1_�γ�\�ߵȹ�����ѧ\������\���ϴ�ѧ_��ֵ����_������\';
addpath(genpath(root_path));
catalogue_path = [root_path, '�γ�Ŀ¼.txt'];
file_path = [root_path, 'videos\'];
file_number = length(dir(file_path)) - 2;  % ��ȥ . �� .. ����Ŀ¼


% ���ж�ȡĿ¼����ÿ���ļ�����
% catalogue_content = []; % ���������ļ���
fid = fopen(catalogue_path);
for i = 1 : file_number
%     catalogue_content{i, 1} = fgets(fid); % ���ж�ȡ
    command = ['rename' 32 [file_path, int2str(i), '.flv'] 32 strcat(fgets(fid), '.flv')];
    status = dos(command);
end
