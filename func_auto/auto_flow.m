function [theta_in_by_tr_sym,theta_in_by_tc_sym,res_FR_r,tr,res_FR_c,tc] = auto_flow(state,cta_in2,t_r,t_c,theta_in_interval )
%AUTO_ 此处显示有关此函数的摘要
%   此处显示详细说明
% 返回值前两个是必要的，是恢复阶段和收缩阶段的θin 对 t sym表达式
% theta_in_by_tr_sym,theta_in_by_tc_sym
% 后四个在动力学计算时是非必要的，是用来绘制细度比随t曲线的
%% 阶段0 
% 解析config
% t_r = cofig.t_r;
% t_c = cofig.t_c;
% L = cofig.L;
% h = cofig.h;
n = length(state.A{1}{1});
frames = length(state.A);
%θin的变化区间：用于第三阶段的计算
theta_b = theta_in_interval(1);
theta_e = theta_in_interval(2);



%% 阶段1 收集θp的值：执行部件的转角范围(待抽离成函数)
%收集A（1,0）的变化的全部集合
%向量1：O(1,0)和O(1,n)的中点到0,0,0的向量(使用y[0,1,0]作为Y1)
%向量2：O(1,0)和O(1,n)的中点到A(1,0)的向量
%旋转轴：（1,0,0）
%求解公式
%Y2=  Y1*cosθ+(A×Y1)sinθ+A(A?P)(1-cosθ)

%获取O中点和向量1
O_1_0 = state.O{1}{1}{1};
O_1_n = state.O{1}{1}{n};
O_c = [0;0;O_1_0(3)];
%Y1 = -O_c/norm(O_c);
Y1 = [0;1;0];
%旋转轴
Axis = [1;0;0]; 
%获取A系列的点和向量2:Y2_i
A_out = cell(1,frames);
Y2_i = cell(1,frames);
% res_p = zeros(frames,1);
for Ai=1:frames
    A_out{Ai} = state.A{Ai}{1}{1};
    Y2_i{Ai} = (A_out{Ai}-O_c)/norm(A_out{Ai}-O_c);
end
%% 阶段二：求θp并且拟合θp关于θin的表达式，
Ai=1;
theta_p=zeros(frames,1);
for Ai=1:frames
    theta_p(Ai)= get2PlaneCorner(Y1,Y2_i{Ai},Axis);
end
[theta_p_func,theta_p_sym] =getFitFunc2(cta_in2,theta_p,1);
%% 阶段三：确定L和h,和θp的范围，确定线长的范围
%对于oblate型：θin 的范围是[49 -> 9]，θp范围[93.98 -> 48.58]
%Slen_o的实例结果[65.813 , 37.024]
% theta_b = 49;
% theta_e = 9;

theta_p_o_b =  theta_p_func(theta_b);
theta_p_o_e =  theta_p_func(theta_e);

% %对于prolate型：θin 的范围是[81->49],θp范围[93.98 -> 48.58]
%Slen_o的实例结果[65.813 , 37.024]
%  theta_p_o_b =  theta_p_func(81);
%  theta_p_o_e =  theta_p_func(9);
%S^2 = L^2+ h^2+2*L*h*cosd(θp)
L = 45;
h = 45;
S_o_b = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_b));
S_o_e = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_e));
Slen_o = [S_o_b,S_o_e];
%% 阶段三： 已知tr ,tc 计算 kr, kc ，拿到线长S在0~tr tr~ T序列
% t_r = 2.4;
% t_c = 1.6;
% 序列写在函数外(转移)
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';

[S_t_r,S_t_c] = calc_S_by_t(Slen_o,t_r,t_c);

%% 阶段四： 已知线长S(t)的序列,反解θp序列->θin->FR
[theta_p_r] = solve_St_to_thetaP(S_t_r,L,h);
[theta_p_c] = solve_St_to_thetaP(S_t_c,L,h);

%得到θp 反解θin
[theta_in_r] = solve_ThetaP_to_in(theta_p_r,theta_p_sym);
[theta_in_c] = solve_ThetaP_to_in(theta_p_c,theta_p_sym);
% θin 对 t 二次拟合一次 得到θin 对 t sym表达式(作为返回值)
[ ~,theta_in_by_tr_sym] = getFitFunc2(tr,theta_in_r,2);
[ ~,theta_in_by_tc_sym] = getFitFunc2(tc,theta_in_c,2);

%得到θin 反解FR(动力学计算不需要用到，绘制FR随 t变化曲线才需要计算)
FR = getFRatioArr(state);
[FR_by_thetaIn_func,func_finess_sym] =   getFitFunc2(cta_in2,FR,4);
[res_FR_r] = solve_ThetaIn_to_FR(theta_in_r,FR_by_thetaIn_func);
[res_FR_c] = solve_ThetaIn_to_FR(theta_in_c,FR_by_thetaIn_func);
end

