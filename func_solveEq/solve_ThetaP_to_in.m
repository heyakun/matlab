function [res_p] = solve_ThetaP_to_in(theta_p_Arr,eq_right)
%SOLVE_THETAP_TO_IN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
res_p = zeros(length(theta_p_Arr),1);
for index = 1:length(theta_p_Arr)
    f= matlabFunction(theta_p_Arr(index)-eq_right);
    res_p(index) = fsolve(f,45);
end

end

