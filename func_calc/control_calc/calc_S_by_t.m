function [S_t_r,S_t_c] = calc_S_by_t(S_len,t_r,t_c)
%CALC_S_BY_T 此处显示有关此函数的摘要
%   此处显示详细说明
% 计算一个周期T 的线长S_len随时间t变化的sym表达式
% 进而求0-tr时间序列阶段的S(0-tr)的时间序列
% 进而求0-tr时间序列阶段的S(tr-T)的时间序列

% 参数示例 S_len = [ , ],tr = 2.4s , tc = 1.6s
S0 = S_len(1);%较长
S1 = S_len(2);%较短

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
end

