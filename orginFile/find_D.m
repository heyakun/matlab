function [so_Rfa] = find_D(DM,Rfa,point_1,point_2,a)
    D = DM(1:3,4);
    eq1 = norm(D-point_1)==a;
    eq2 = norm(D-point_2)==a;
    eqns = [eq1,];
    var = Rfa;
    so_Rfa = solve(eqns, var);
    
end

