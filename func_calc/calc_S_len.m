function [out] = calc_S_len(L,h,theta_p_Arr)
%CALC_S_LEN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    theta_p_b = theta_p_Arr(0);
    theta_p_e = theta_p_Arr(1);
    S_o_b = sqrt(L^2+ h^2+2*L*h*cosd(theta_p_b));
    S_o_e = sqrt(L^2+ h^2+2*L*h*cosd(theta_p_e));
    out = [S_o_b,S_o_e];
end

