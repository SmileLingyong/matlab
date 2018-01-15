% Creation      : 08-Jul-2017 20:30 Saturday
% Last Revision : 08-Jul-2017 20:30 Saturday
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%

%% Init
clc;
clear;
close all;

%% Init SSD
ssd_path = '/home/xinke/work/Net_structure/caffe-ssd/matlab';
save_path = './model/';
solver_path = './net/lenet_solver.prototxt';
log_path = './log/';
GPU_ID = 0;

addpath(ssd_path, './utils');
caffe.reset_all();
caffe.set_mode_gpu();
caffe.set_device(GPU_ID);
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle'));

params = set_params();

%% Loading data
if checkMNIST()
    fprintf('MNIST dataset has been downloaded already!\n');
else
    fprintf('Downloading MNIST dataset! Please wait a moment!\n');
    downloadMNIST();
end

%% Load data
[trn_data, trn_labels, tst_data, tst_labels] =  LoadMNIST();

%% Create log
if ~exist(log_path, 'dir')
    mkdir(log_path);
end
timestamp = datestr(datevec(now()), 'yyyymmdd_HHMMSS');
log_file = fullfile(log_path, ['train_', timestamp, '.txt']);
diary(log_file);

%% Init net
caffe_solver = caffe.Solver(solver_path);
iter = 0;
num_samples = numel(trn_labels);
batch_idx = randperm(num_samples);

%% Start training
loss_record = [];
while iter < params.max_iter
    % get batch
    start_idx = mod((params.batch_sz * iter) + 1, num_samples);
    end_idx = mod((iter + 1) * params.batch_sz, num_samples);
    if end_idx == 0
        end_idx = num_samples;
    end 
    if end_idx < start_idx
        crt_batch_idx = [batch_idx(start_idx : end), batch_idx(1: end_idx)];
    else
        crt_batch_idx = batch_idx(start_idx : end_idx);
    end
    
    
    net_input_data = [];
    net_input_label = [];
    for idx = 1:params.batch_sz
        % minus image mean value and transfer the channels are standard
        % image pre-precess methods, 104, 117, 123 these three numbers are
        % the most common mean value which were calculated via ILSVRC
        im = trn_data(:, :, crt_batch_idx(idx));
        label = trn_labels(crt_batch_idx(idx));
        img(:, :, 1) = im - params.mean_value(1); % 104
        img(:, :, 2) = im - params.mean_value(2); % 117
        img(:, :, 3) = im - params.mean_value(3); % 123
        img = img(:, :, [3, 2, 1]); % to adapt the [B, G, R] channels
        net_input_data{idx} = img; %#ok<SAGROW>
        net_input_label(idx, :) = label; %#ok<SAGROW>
    end
    net_input_data = single(cat(4,net_input_data{:})); % cat to a 4-D tensor
    net_input_data = permute(net_input_data, [2, 1, 3, 4]); % to adapt [H W]
    
    
    % set input data    
    caffe_solver.net.blobs('data').set_data(net_input_data);
    
    % forward
    caffe_solver.net.forward_prefilled();
    output = caffe_solver.net.blobs('ip2').get_data();
    
    % backward
%     loss = caffe_solver.net.blobs('loss').get_data();
    loss_struct = softmax_loss_forward(output, net_input_label, 10);
    loss_struct = softmax_loss_backward(loss_struct);
    caffe_solver.net.blobs('ip2').set_diff(loss_struct.pred_diff);
    a = loss_struct.pred_diff;
    caffe_solver.net.backward_prefilled();
    loss = loss_struct.loss;
    
    % update
    rate_now = params.base_lr * params.gamma^(floor(iter / params.step_size));
    caffe_solver.update(single(rate_now));
    
    iter = iter + 1;
    fprintf('iter %6d/%6d: loss: %.2f\n', iter, params.max_iter, loss);
    
     % visualization loss
    if ~mod(iter, params.show_iter)
        loss_record(end + 1) = loss;
    end
    
    if ~mod(iter, params.show_iter)
        X = 1 : numel(loss_record);
        line(X, loss_record);
        pause(0.1);
    end
    
end

% save
if ~exist(save_path, 'dir')
    mkdir(save_path);
end
caffe_solver.net.save([save_path, 'final_model.caffemodel']);
diary off;




