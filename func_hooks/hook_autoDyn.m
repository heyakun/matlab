function [outputArg1,outputArg2] = hook_autoDyn(inputArg1,inputArg2)
%HOOK_AUTODYN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
len = length(dyn_output);
res_vAver = zeros(len,1);
for index = 1: len
    res_vAver(index) = dyn_output.v_aver{index};
end


end

