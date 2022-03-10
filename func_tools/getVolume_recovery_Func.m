function [Volume_recovery_func_sym,Volume_recovery_func] = getVolume_recovery_Func(duration,V_arr)
t_recovery = linspace(0,duration,20);
Volume_recovery_fitArr = polyfit(t_recovery,V_arr,5);
%p5 �����ʱ��t֮��ĺ�����ϵ -�ָ��׶�
Volume_recovery_func_sym = vpa(poly2sym(Volume_recovery_fitArr),5);
Volume_recovery_func = matlabFunction(Volume_recovery_func_sym);

% d_Volume_recovery_func_dt = diff(Volume_recovery_func_sym);
% syms x
% %��ȡ��ֵ��
% X0 = solve([d_Volume_recovery_func_dt == 0,x>0,x<duration], x);
% 
% %��д ����(���������任)
% Volume_recovery_func_sym = Volume_recovery_func(X0/duration*x);
% Volume_recovery_func = matlabFunction(Volume_recovery_func_sym);
end

