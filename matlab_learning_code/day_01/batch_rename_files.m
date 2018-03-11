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

root_path = 'D:\1study\研究生\1_课程\高等工程数学\公开课\中南大学_数值分析_韩旭里\';
addpath(genpath(root_path));
catalogue_path = [root_path, '课程目录.txt'];
file_path = [root_path, 'videos\'];
file_number = length(dir(file_path)) - 2;  % 减去 . 和 .. 两个目录


% 按行读取目录（即每个文件名）
% catalogue_content = []; % 保存所有文件名
fid = fopen(catalogue_path);
for i = 1 : file_number
%     catalogue_content{i, 1} = fgets(fid); % 按行读取
    command = ['rename' 32 [file_path, int2str(i), '.flv'] 32 strcat(fgets(fid), '.flv')];
    status = dos(command);
end
