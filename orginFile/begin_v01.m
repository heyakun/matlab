%起始点
p = 12;
a = 20;
Cta = 0.8*pi / 2;
%求O0 (与p直接相关)
O0M = R('y', pi / 8) * T('z', p);
O0 = O0M(1:3, 4);
%求F1(与输入直接相关)
F1M = O0M * R('x', Cta) * T('y', a);
F1 = F1M(1:3, 4);


%求A1
syms angle_1
A1M = F1M * R('y', angle_1) * T('x', -a);
A1 = A1M(1:3, 4);

eq1 = A1(1) == 0;
eqns = [eq1, ];
vars = angle_1;
so_angle_1 = solve(eqns, vars);

Cta2 = min(so_angle_1(1), so_angle_1(2));
A1M = (F1M * R('y', Cta2) * T('x', -a));
A1 = A1M(1:3, 4);
%求O1
syms Bta
O1M = A1M*R('x',Bta)*T('y',-a);
O1 = O1M(1:3,4);
eq2 = O1(1) == 0;
eqns = [eq2, ];
vars = Bta;
so_Bta = solve(eqns, vars);
if length(so_Bta) == 2
   for i=1:2
       if(real(vpa(so_Bta(i)))<0)
           h_Bta = so_Bta(i);
       end
   end
else
    h_Bta = so_Bta;
end
O1M = A1M*R('x',h_Bta)*T('y',-a);
O1 = O1M(1:3,4);


%阵列点
O0_s = axiosY_array(O0M,8);
F1_s = axiosY_array(F1M,8);
A1_s = axiosY_array(A1M,8);
O1_s =axiosY_array(O1M,8);

%过渡角求解
ange_OFE = t_angle(A1_s{1},A1_s{2},a);
E1M = F1M*R('x',ange_OFE)*T('z',2*a);
E1 = E1M(1:3,4);
E1_s = axiosY_array(E1M,8);

%求D1
%前提准备
g_O1M = joinM(O1);
bta56 = solve_bta(E1_s{1},E1_s{8},a);

syms Rfa_2 
D1M = g_O1M*R('x',Rfa_2)*T('y',a);
eq_baseM = D1M*R('y',-(pi/2-bta56))*T('x',a);
eq_base = eq_baseM(1:3,4);

eq3 = eq_base(2) == E1(2);
eqns = [eq3, ];
vars = Rfa_2;
so_Rfa = solve(eqns, vars);
if length(so_Rfa) == 2
   for i=1:2
       if(real(vpa(so_Rfa(i)))>0)
           h_Rfa = so_Rfa(i);
       end
   end
else
    h_Rfa = so_Rfa;
end
D1M = A1M*R('y',-Cta2)*R('x',h_Rfa)*T('y',a);
D1 = D1M(1:3,4);
D1_s = axiosY_array(D1M,8);

clf
for i=1:7
    p2p_connect(O0_s{i},O0_s{i+1})
end
p2p_connect(O0_s{1},F1_s{1})
mydraw(O1_s{1},A1_s{1},F1_s{8},E1_s{8},D1_s{1},E1_s{1},F1_s{1})
axis_x = quiver3(0, 0, 0, 8, 0, 0, 'linewidth', 2, 'color', 'red');
axis_y = quiver3(0, 0, 0, 0, 8, 0, 'linewidth', 2, 'color', 'green');
axis_z = quiver3(0, 0, 0, 0, 0, 7, 'linewidth', 2, 'color', 'blue');
set(gca, 'YAxisLocation', 'origin');
grid on
axis equal
axis([-100 100 -100 100 -100 100])
view([0,1,0])





