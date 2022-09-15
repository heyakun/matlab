function [outputArg1,outputArg2] = hook_autoDyn(inputArg1,inputArg2)
%HOOK_AUTODYN 此处显示有关此函数的摘要
%   此处显示详细说明
len = length(dyn_output);
res_vAver = zeros(len,1);
for index = 1: len
    res_vAver(index) = dyn_output.v_aver{index};
end


end

