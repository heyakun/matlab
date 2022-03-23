function [S_rByt_sym,S_cByt_sym] = calc_S(state,cta_in2,t_r,t_c)
%CALC_S 此处显示有关此函数的摘要
%   此处显示详细说明
% 在一个周期内 S 分成两段 扩张阶段 和  收缩阶段
% T = 4s  tr = 2.4s  tc = 1.6s
% [0 , tr] [ tr ,  T]
%y = k*t +b
%p_S 得到S的长度变化 
%S0初始长度 p_S(0)    S1结束长度p_S(end)
%% 求S 扩张阶段和收缩阶段的函数和 时间序列

p_S = calcLineLength(state);
S0 = p_S(1);
S1 = p_S(end);
k_r = (S1-S0)/t_r;
k_c = (S0-S1)/t_c;
syms tt
S_tr_sym = S0+k_r*tt;
S_tc_sym= k_c*(tt-t_r)+S1;

%时间序列-扩张阶段
tr = (0:0.1:t_r)';
S_t_r = S0+k_r*tr;
%时间序列-收缩阶段
tc = (t_r:0.1:t_r+t_c)';
S_t_c = k_c*(tc-t_r)+S1;

%% 求出 H r 的关于 theta_in的拟合函数
maxH = getMaxH(state);
ROi = getEachR(state);

[~,func_maxH_sym] = getFitFunc2(cta_in2,maxH,2);
[~,func_ROi_6_sym] = getFitFunc2(cta_in2',ROi{6},2);



%% 解方程 -- S 在时间序列下 求解 theta_in 的值: 扩张阶段
eq_right = sqrt((func_maxH_sym-20)^2+func_ROi_6_sym^2);
res_r = zeros(length(tr),1);
for index = 1:length(tr)
    
    f= matlabFunction(S_t_r(index)-eq_right);
    res_r(index) = fsolve(f,45);
end
%% 解方程 -- S 在时间序列下 求解 theta_in 的值: 收缩阶段

res_c = zeros(length(tc),1);
for index_c = 1:length(tc)
    
    f= matlabFunction(S_t_c(index_c)-eq_right);
    res_c(index_c) = fsolve(f,45);
end
%% 拟合theta_in  对 t 的函数
[ ~,S_rByt_sym] = getFitFunc2(tr,res_r,1);
[ ~,S_cByt_sym] = getFitFunc2(tc,res_c,1);
end

