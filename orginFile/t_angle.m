function [Gama] = t_angle(point_1,point_2,a)
    d = norm(point_1 - point_2);
    h = sqrt(a^2-(d/2)^2);
    
    syms angle_2
    eq4 = a * sin(angle_2) + h * cos(angle_2) - a == 0;
    eqns2 = eq4;
    so_angle_2 = solve(eqns2, angle_2);
    
    if length(so_angle_2) == 2
        Gama = vpa(real(min(so_angle_2(2), so_angle_2(1))));
    else
        Gama = so_angle_2;
    end
end

