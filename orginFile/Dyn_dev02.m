%导入数据 state
%Dyn_01 计算Volume Sbell_hole sbell_max  计算T Dco Aco 画图 验证
%去除 验证画图部分只保留函数

V_arr = zeros(1,frames);
for i=1:frames
    P_O0 = state.O0_s{i}{1};
    P_O1 = state.O1_s{i}{1};
    P_O2 = state.O2_s{i}{1};
    P_O3 = state.O3_s{i}{1};
    P_O4 = state.O4_s{i}{1};
    P_O5 = state.O5_s{i}{1};
    P_O6 = state.O6_s{i}{1};
    
    x= double([norm([P_O0(1),P_O0(3)]),norm([P_O1(1),P_O1(3)]),norm([P_O2(1),P_O2(3)]),norm([P_O3(1),P_O3(3)]),norm([P_O4(1),P_O4(3)]),norm([P_O5(1),P_O5(3)]),norm([P_O6(1),P_O6(3)])]);
    y= double([P_O0(2),P_O1(2),P_O2(2),P_O3(2),P_O4(2),P_O5(2),P_O6(2)]);
    
    V = 0;
    for j=1:6
        v = 1/3*pi*abs(y(j)-y(j+1))*(x(j)^2+x(j+1)^2+x(j)*x(j+1));
        V = V+v;
    end
    V_arr(i)=V;
end

duration_recovery = 1;
[Volume_recovery_func_sym,Volume_recovery_func] = getVolume_recovery_Func(duration_recovery,V_arr);
t_recovery =double(linspace(0,duration_recovery,20));


%体积与时间t之间的函数关系 -收缩阶段
duration_constriction = 0.5;
t_constriction = linspace(duration_recovery,duration_constriction+duration_recovery,20);
[Volume_constriction_func_sym,Volume_constriction_func] = getVolume_constriction_Func(duration_constriction,V_arr,duration_recovery);

%% S_bell孔口面积计算--曲线拟合
S_bell_points = zeros(1,frames);
r_bell_hole = zeros(1,frames);
for i=1:frames
    P_O6 = state.O6_s{i}{1};
    r_bell = norm([P_O6(1),P_O6(3)]);
    r_bell_hole(i) = norm([P_O6(1),P_O6(3)]);
    S_bell_points(i) = pi*r_bell^2;
end
[r_bell_hole_sym,r_bell_hole_func] = getRbell_hole_recovery(duration_recovery,r_bell_hole);
%曲线拟合-直接面积拟合
[s_bell_recovery_sym,s_bell_recovery_func] = getSbell_recovery(duration_recovery,S_bell_points);
[s_bell_constriction_sym,s_bell_constriction_func] = getSbell_constriction(duration_recovery,S_bell_points,duration_constriction);
%% 计算恢复阶段 和 收缩阶段的 推进力 T
Ro_water = 0.001;
dVdt_recovery = diff(Volume_recovery_func_sym);
dVdt_constriction = diff(Volume_constrition_func_sym);

T_jet_recovery = Ro_water/s_bell_recovery_sym*(dVdt_recovery)^2;
T_jet_constriction= Ro_water/s_bell_constriction_sym*(dVdt_constriction)^2;

T_jet_recovery_func = matlabFunction(T_jet_recovery);
T_jet_constriction_func = matlabFunction(T_jet_constriction);
%% 求阻力的系数 D = 0.5*c_bell*ρwater*s_bell_max*u*U
%简便计算(与瞬时速度有关)
Ro_water = 0.001;
% if u<0
%     c_bell = 0.42;
% else
%     c_bell = 1.17;
% end
r_bell_max_points = zeros(1,frames);
for i=1:frames
    P_O4 = state.O4_s{i}{1};
    r_bell_max_points(i) = norm([P_O4(1),P_O4(3)]);
end
[r_bell_max_recovery_func_sym,r_bell_max_recovery_func] = getFuncByPoints(duration_recovery,r_bell_max_points);
[r_bell_max_constriction_func_sym,r_bell_max_constriction_func] = getMirrorFuncByPoints(duration_recovery,r_bell_max_points,duration_constriction);

D_coefficient_recovery_sym = 0.5*Ro_water*r_bell_max_recovery_func_sym;
D_coefficient_constriction_sym = 0.5*Ro_water*r_bell_max_constriction_func_sym;

D_coefficient_recovery_func = matlabFunction(D_coefficient_recovery_sym);
D_coefficient_constriction_func = matlabFunction(D_coefficient_constriction_sym);
%% 计算 A附加质量系数 A = α*ρwater*V*(?U/?t)
Ro_water = 0.001;
added_mass_coefficient_points = zeros(1,frames);
for i=1:frames
    P_O4 = state.O4_s{i}{1};
    r_bell = norm([P_O4(1),P_O4(3)]);
    added_mass_coefficient_points(i) = abs(P_O4(2)/norm([P_O4(1),P_O4(3)]))^(-1.4);
end
t = linspace(0,1,frames);
% useLine(t,added_mass_coefficient)
[added_mass_coefficient_recovery_sym,added_mass_coefficient_recovery_func] = getFuncByPoints(duration_recovery,added_mass_coefficient_points);
[added_mass_coefficient_constriction_sym,added_mass_coefficient_constriction_func] = getMirrorFuncByPoints(duration_recovery,added_mass_coefficient_points,duration_constriction);

A_coefficient_recovery_sym = added_mass_coefficient_recovery_sym*Ro_water*Volume_recovery_func_sym;
A_coefficient_constriction_sym = added_mass_coefficient_constriction_sym*Ro_water*Volume_constriction_func_sym;
A_coefficient_recovery_func = matlabFunction(A_coefficient_recovery_sym);
A_coefficient_constriction_func = matlabFunction(A_coefficient_constriction_sym);
%% ode45算法
T1f = T_jet_recovery_func;
T2f = T_jet_constriction_func;
Dc1f = D_coefficient_recovery_func;
Dc2f = D_coefficient_constriction_func;
Ac1f = A_coefficient_recovery_func;
Ac2f = A_coefficient_constriction_func;
dur_rec = duration_recovery;
dur_con = duration_constriction;
[ode_t,ode_x] = ode45(@(t,x) Dyn_odefunc_01(t,x,T1f,T2f,Dc1f,Dc2f,Ac1f,Ac2f,dur_rec,dur_con),[0.001 1.1],[0 0]);

plot(ode_t,ode_x);
xlabel("Time t")

