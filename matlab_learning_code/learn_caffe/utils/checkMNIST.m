% Creation      : 20-Mar-2017 19:53
% Last Revision : 20-Mar-2017 19:53
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%
% This function used to check if the MNIST dataset has been downloaded
% -------------------------------------------------------------------------
% Xinyu Wang @ 2017

function status = checkMNIST()
    status = 1;
    dataset_path = './mnist/';
    file_name = {'train-images-idx3-ubyte', 'train-labels-idx1-ubyte' ...
             't10k-images-idx3-ubyte', 't10k-labels-idx1-ubyte'};     % 4 files of mnist dataset which contains {trn_data, trn_label, tst_data, tst_label}
    for i = 1:numel(file_name)
        if ~exist([dataset_path, file_name{i}], 'file')
            status = 0;
        end
    end
end