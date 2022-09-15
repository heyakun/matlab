function [res_p] = solve_St_to_thetaP(St_arr,L,h)
%SOLVE_ST_TO_THETAP �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
syms theta_p
eq_right = sqrt(L^2+ h^2-2*L*h*cosd(theta_p));
res_p = zeros(length(St_arr),1);
for index = 1:length(St_arr)
    f= matlabFunction(St_arr(index)-eq_right);
    res_p(index) = fsolve(f,45);
end

end

