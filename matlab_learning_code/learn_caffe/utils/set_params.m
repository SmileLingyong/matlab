% Creation      : 08-Jul-2017 21:08 Saturday
% Last Revision : 08-Jul-2017 21:08 Saturday
% Author        : Xinyu Wang {xinke_wang.ss@qq.com}
% File Type     : matlab
%

function params = set_params()
    params.batch_sz = 64;
    params.nte_input_sz = [28, 28, 1];
    params.max_iter = 5000;
    params.mean_value = [104, 117, 123]; % mean valuse
    params.base_lr = 0.000001; % base learning rate
    params.gamma = 0.1; % update current base learning rat
    params.step_size = 100000; % update current base learning rate
    params.show_iter = 200;
    params.test_iter = 10;
    
end