function [so_bta] = solve_bta(point_1,point_2,a)
d = norm(point_1 - point_2);
syms bta
eq1 = cos(2*bta) == 1-d^2/2/a^2;
eqns = [eq1, bta<pi/2,bta>0];
vars = bta;
so_bta = solve(eqns, vars);

end

