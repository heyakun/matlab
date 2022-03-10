function [r_bell_hole_sym,r_bell_hole_func] = getRbell_hole_recovery(duration,S_bell_points)
t_recovery = linspace(0,duration,20);
s_bell_arr = polyfit(t_recovery,S_bell_points,3);
r_bell_hole_sym = vpa(poly2sym(s_bell_arr),5);
r_bell_hole_func = matlabFunction(r_bell_hole_sym);
end

