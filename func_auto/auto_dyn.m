function [output] = auto_dyn(t_r,t_c,FR,state,cta_in2)
%AUTO_DYN 此处显示有关此函数的摘要
%   此处显示详细说明
% 运动学变量
% t_r 恢复阶段时间
% t_c 收缩阶段时间
% FR 细度比范围区间 例如：[0.39,1] 或 [1,2.6]

%% 前置数据
% frames=10;
% t = linspace(0,1,frames);     
% 水的密度
Ro_water = 0.001; %g/mm^3
% cta_in = 9/20*pi-0.4*pi*t;
% %cta_in2 用于将Cta_in弧度制转角度
% cta_in2 = rad2deg( cta_in');
%%
% [state,~] = createModel(m,n,a,p,frames);

% t_r = 2.4;
% t_c = 1.6;
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';
% cta_in  对 t 的 sym表达式
% [ cta_T_rec,cta_T_con ] = calc_S(state,cta_in2,t_r,t_c);
%% auto_flow还不完善 
% 就细度比拟合
FR_arr = getFRatioArr(state);
[~,func_finess_sym] = getFitFunc2(cta_in2,FR_arr,4);

% 例如 FR = [0.39 ,1]
% 解得in_arr = [50.6 , 8.3]
FR_up = max(FR); 
FR_down = min(FR);

f  =func_finess_sym;
in_up = fsolve(matlabFunction(f-FR_up),50);
in_down = fsolve(matlabFunction(f-FR_down),10);


% 水母为oblate型，细度比区间【】对应的θin的区间为
% oblate = [49 , 9];
% prolate =[70 , 49];
in_arr = [in_up,in_down];

% 后四个在动力学计算时是非必要的，是用来绘制细度比随t曲线的
[ cta_T_rec,cta_T_con,res_FR_r,tr,res_FR_c,tc ] = auto_flow(state,cta_in2,t_r,t_c,in_arr);
%% 
%T
[T1f,T2f] = getTf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
% 阻力的系数 D_before 
[Db1f,Db2f] = getDbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
% A_before 计算 A = α*ρwater*V*(?U/?t) A_before = α*ρwater*V
[Ab1f,Ab2f] = getAbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
%% 收集
Config.T1f = T1f;
Config.T2f = T2f;
Config.Db1f = Db1f;
Config.Db2f = Db2f;
Config.Ab1f = Ab1f;
Config.Ab2f = Ab2f;
Config.t_r = t_r;
Config.t_c = t_c;
%% ode45 求解
T = t_r + t_c;
% 时间跨度10个周期
tspan = [0.1 T*10];
y0 = [0 0];
%%
[res_t,res_y] = ode113(@(t,y) odefcn(t,y,Config), tspan, y0);
% plot(res_t,res_y)
% %画位移曲线
% plot(res_t,res_y(:,1))
% % 画速度曲线
% plot(res_t,res_y(:,2))
%% 计算平均速度
res =  [res_t,res_y];
res_filter = res(res(:,1)>=T*5,:);

v_averArr = res_filter(:,2)./res_filter(:,1);
v_aver = sum(v_averArr)/length(v_averArr);
% res_t(res_t(:,))
% res_y(:,1)
%% 计算D


%% 收集内容作为返回值
% 1.收集细度比变化曲线
output.res_FR_r = res_FR_r;
output.tr = tr;
output.res_FR_c = res_FR_c;
output.tc = tc;
% 2.收集位移速度曲线
output.res_t = res_t;
output.res_y = res_y;
% 3.收集后6个周期的平均速度
output.v_aver =v_aver;
% 4.收集T，D在一个周期里的变化
output.T1f = T1f;
output.T2f = T2f;
output.D1f = D1f;
output.D2f = D2f;

end

