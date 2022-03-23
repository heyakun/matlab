function [Ab1f,Ab2f] = getAbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water)
%GETABF 此处显示有关此函数的摘要
%   此处显示详细说明
[Vi,~,~] = getEachV_2(state);
[Vi_f] =getFitFunc2(cta_in2',Vi,2);
Vi_T_rec = Vi_f(cta_T_rec);
Vi_T_con = Vi_f(cta_T_con);

R_Os = getEachR(state);
R_max = R_Os{4};
R_max_f= getFitFunc2(cta_in2',R_max,2);

H_mid = getH_IndexOf(state,4);
H_mid_f = getFitFunc2(cta_in2',H_mid,2);
Alpha_rec = (H_mid_f(cta_T_rec)/R_max_f(cta_T_rec))^(-1.4);
Alpha_con = (H_mid_f(cta_T_con)/R_max_f(cta_T_con))^(-1.4);

A_before_rec = Alpha_rec * Ro_water * Vi_T_rec;
A_before_con = Alpha_con * Ro_water * Vi_T_con;

Ab1f = matlabFunction(A_before_rec);
Ab2f = matlabFunction(A_before_con);
end

