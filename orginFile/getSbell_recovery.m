function [s_bell_sym,s_bell_func] = getSbell_recovery(duration,S_bell_points)
t_recovery = linspace(0,duration,20);
s_bell_arr = polyfit(t_recovery,S_bell_points,3);
s_bell_sym = vpa(poly2sym(s_bell_arr),5);
s_bell_func = matlabFunction(s_bell_sym);
end

