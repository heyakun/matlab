function [func,func_sym] = getFitFunc(time,points)
time_start = time(1);
time_end = time(2);
t=linspace(time_start,time_end,20);

coe_arr= polyfit(t,points,5);
func_sym = vpa(poly2sym(coe_arr),5);
func = matlabFunction(func_sym);
end

