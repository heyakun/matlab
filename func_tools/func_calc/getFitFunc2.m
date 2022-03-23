function [func,func_sym] = getFitFunc2(x_arr,y_arr,power_num)
Coe_arr= polyfit(x_arr,y_arr,power_num);
func_sym = vpa(poly2sym(Coe_arr),5);
func = matlabFunction(func_sym);
end

