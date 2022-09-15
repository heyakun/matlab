function [Db1f,Db2f] = getDbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water)
%GETDBF 此处显示有关此函数的摘要
%   此处显示详细说明
% D = 0.5*c_bell*ρwater*s_bell_max*u*U
% D_before = 0.5*c_bell*ρwater*s_bell_max
c_bell = 1;%这里先等于1，在odefcn里决定等于
% 最大半径处
R_Os = getEachR(state);
R_max = R_Os{4};
R_max_f= getFitFunc2(cta_in2',R_max,2);

R_max_T_rec = R_max_f(cta_T_rec);
R_max_T_con = R_max_f(cta_T_con);

%最大半径处面积
S_max_rec = pi*R_max_T_rec^2;
S_max_con = pi*R_max_T_con^2;

D_before_rec = 0.5*c_bell*Ro_water*S_max_rec;
D_before_con = 0.5*c_bell*Ro_water*S_max_con;
Db1f = matlabFunction(D_before_rec);
Db2f = matlabFunction(D_before_con);
end

