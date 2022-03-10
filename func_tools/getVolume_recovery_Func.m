function [Volume_recovery_func_sym,Volume_recovery_func] = getVolume_recovery_Func(duration,V_arr)
t_recovery = linspace(0,duration,20);
Volume_recovery_fitArr = polyfit(t_recovery,V_arr,5);
%p5 体积与时间t之间的函数关系 -恢复阶段
Volume_recovery_func_sym = vpa(poly2sym(Volume_recovery_fitArr),5);
Volume_recovery_func = matlabFunction(Volume_recovery_func_sym);

% d_Volume_recovery_func_dt = diff(Volume_recovery_func_sym);
% syms x
% %获取极值点
% X0 = solve([d_Volume_recovery_func_dt == 0,x>0,x<duration], x);
% 
% %重写 函数(进行伸缩变换)
% Volume_recovery_func_sym = Volume_recovery_func(X0/duration*x);
% Volume_recovery_func = matlabFunction(Volume_recovery_func_sym);
end

