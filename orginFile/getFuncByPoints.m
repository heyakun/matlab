function [func_sym,func] = getFuncByPoints(duration,points)
t_duration = linspace(0,duration,20);
coefficient_arr = polyfit(t_duration,points,3);
func_sym = vpa(poly2sym(coefficient_arr),5);
func = matlabFunction(func_sym);
end

