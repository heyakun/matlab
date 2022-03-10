function [storeFunc] = getAllFunc(state,duration_recovery,duration_constriction)
%导入数据 state
frames = 20;
% duration_recovery = 2;
% duration_constriction = 1;


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
%体积与时间t之间的函数关系 -恢复阶段
[Volume_recovery_func_sym,Volume_recovery_func] = getVolume_recovery_Func(duration_recovery,V_arr);
t_recovery =double(linspace(0,duration_recovery,20));

%体积与时间t之间的函数关系 -收缩阶段
t_constriction = linspace(duration_recovery,duration_constriction+duration_recovery,20);
[Volume_constriction_func_sym,Volume_constriction_func] = getVolume_constriction_Func(duration_constriction,V_arr,duration_recovery);

% %验证
% useVerify_func(Volume_recovery_func,t_recovery,Volume_constriction_func,t_constriction)
%% s_bell

%% S_bell孔口面积计算--曲线拟合
S_bell_points = zeros(1,frames);
r_bell_hole = zeros(1,frames);
for i=1:frames
    P_O6 = state.O6_s{i}{1};
    r_bell = norm([P_O6(1),P_O6(3)]);
    r_bell_hole(i) = norm([P_O6(1),P_O6(3)]);
    S_bell_points(i) = pi*r_bell^2;
end
% t = linspace(0,1,frames);
% useLine(t,S_bell_points)
%曲线拟合-孔口半径
% useLine(t,r_bell_hole)
% [r_bell_hole_sym,r_bell_hole_func] = getRbell_hole_recovery(duration_recovery,r_bell_hole);
% r_bell_hole_func_value = r_bell_hole_func(t_recovery);
% plot(t_recovery,r_bell_hole_func_value)

%曲线拟合-直接面积拟合
% hold on 
[s_bell_recovery_sym,s_bell_recovery_func] = getSbell_recovery(duration_recovery,S_bell_points);
[s_bell_constriction_sym,s_bell_constriction_func] = getSbell_constriction(duration_recovery,S_bell_points,duration_constriction);

%% 计算恢复阶段 和 收缩阶段的 推进力 T
Ro_water = 0.001;%单位 g/mm^3
dVdt_recovery = diff(Volume_recovery_func_sym);
dVdt_constriction = diff(Volume_constriction_func_sym);

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
% t = linspace(0,1,frames);
% useLine(t,r_bell_max_points)
% r_bell_max_recovery_func_value = r_bell_max_recovery_func(t_recovery);
% r_bell_max_constriction_func_value = r_bell_max_constriction_func(t_constriction);
% hold on 
% plot(t_recovery,r_bell_max_recovery_func_value);
% hold on 
% plot(t_constriction,r_bell_max_constriction_func_value);

D_coefficient_recovery_sym = 0.5*Ro_water*r_bell_max_recovery_func_sym;
D_coefficient_constriction_sym = 0.5*Ro_water*r_bell_max_constriction_func_sym;

D_coefficient_recovery_func = matlabFunction(D_coefficient_recovery_sym);
D_coefficient_constriction_func = matlabFunction(D_coefficient_constriction_sym);

%% 计算 A附加质量系数 A = α*ρwater*V*(?U/?t)
Ro_water = 0.001;
added_mass_coefficient_points = zeros(1,frames);
for i=1:frames
    P_O4 = state.O4_s{i}{1};
    added_mass_coefficient_points(i) = abs(P_O4(2)/norm([P_O4(1),P_O4(3)]))^(-1.4);
end
[added_mass_coefficient_recovery_sym,added_mass_coefficient_recovery_func] = getFuncByPoints(duration_recovery,added_mass_coefficient_points);
[added_mass_coefficient_constriction_sym,added_mass_coefficient_constriction_func] = getMirrorFuncByPoints(duration_recovery,added_mass_coefficient_points,duration_constriction);

A_coefficient_recovery_sym = added_mass_coefficient_recovery_sym*Ro_water*Volume_recovery_func_sym;
A_coefficient_constriction_sym = added_mass_coefficient_constriction_sym*Ro_water*Volume_constriction_func_sym;
A_coefficient_recovery_func = matlabFunction(A_coefficient_recovery_sym);
A_coefficient_constriction_func = matlabFunction(A_coefficient_constriction_sym);


%% 收集函数
% storeFunc.T_jet_recovery_func = T_jet_recovery_func;
% storeFunc.T_jet_constriction_func = T_jet_constriction_func;
% storeFunc.D_coefficient_recovery_func = D_coefficient_recovery_func;
% storeFunc.D_coefficient_constriction_func =D_coefficient_constriction_func;
% storeFunc.A_coefficient_recovery_func = A_coefficient_recovery_func;
% storeFunc.A_coefficient_constriction_func = A_coefficient_constriction_func;

% storeFunc.T_rec_func = 
% storeFunc.T_con_func = 
% storeFunc.D_co_rec_func = 
% storeFunc.D_co_con_func =
% storeFunc.A_co_rec_func = 
% storeFunc.A_co_con_func = 

storeFunc.T_rec_func = T_jet_recovery_func;
storeFunc.T_con_func = T_jet_constriction_func;
storeFunc.D_co_rec_func = D_coefficient_recovery_func;
storeFunc.D_co_con_func =D_coefficient_constriction_func;
storeFunc.A_co_rec_func = A_coefficient_recovery_func;
storeFunc.A_co_con_func = A_coefficient_constriction_func;

storeFunc.Vol_rec_func=Volume_recovery_func;
storeFunc.Vol_con_func=Volume_constriction_func;
end

