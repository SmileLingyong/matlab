function [ conf_loss_struct ] = softmax_loss_forward( conf_pred_data, conf_gt_data, num_classes )

    %  softmax
    max_val             = max( conf_pred_data, [], 1 );
    conf_pred_data      = conf_pred_data - repmat(max_val, num_classes, 1);
    
    exp_conf_pred_data      = exp(conf_pred_data);
    sum_exp_conf_pred_data  = sum(exp_conf_pred_data, 1);
    conf_pred_data          = exp_conf_pred_data ./ repmat(sum_exp_conf_pred_data, num_classes, 1);
    
    conf_loss_struct.pred   = conf_pred_data;
    conf_loss_struct.label  = conf_gt_data;
    
    loss                    = zeros(size(conf_pred_data, 2), 1);
    for ii = 0 : num_classes-1
        idx                 = find(conf_gt_data == ii);
        loss(idx)           = -log( max(conf_pred_data(ii+1, idx), realmin) );
    end
    
    conf_loss_struct.loss   = sum(loss(:));
end