function [res_FR] = solve_ThetaIn_to_FR(theta_in_Arr,FR_by_thetaIn_func)
%SOLVE_THETAIN_TO_FR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
res_FR = zeros(length(theta_in_Arr),1);
for index = 1 : length(theta_in_Arr)
  res_FR(index) =  FR_by_thetaIn_func(theta_in_Arr(index));
end
end

