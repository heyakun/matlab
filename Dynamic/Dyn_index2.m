% addpath(genpath('func_tool'))
% addpath(genpath('func_auto'))
%% 前置数据
frames=10;
t = linspace(0,1,frames);     
% 水的密度
Ro_water = 0.001; %g/mm^3
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 用于将Cta_in弧度制转角度
cta_in2 = rad2deg( cta_in');

%折纸模型
[state,~] = createModel(m,n,a,p,frames);
%实物模型
% [realModelState,realModelCorner] = createModel(5,16,40,30,10);
% state = realModelState;
%%
t_r = 2.4;
t_c = 1.6;
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';
% cta_in  对 t 的 sym表达式
% [ cta_T_rec,cta_T_con ] = calc_S(state,cta_in2,t_r,t_c);
%% auto_flow还不完善 
% 水母为oblate型，细度比区间【】对应的θin的区间为
oblate = [49 , 9];
prolate =[70 , 49];
% 后四个在动力学计算时是非必要的，是用来绘制细度比随t曲线的
[ cta_T_rec,cta_T_con,res_FR_r,tr,res_FR_c,tc ] = auto_flow(state,cta_in2,t_r,t_c,oblate);
%% 算一下 细度比

%% 除t y以外，其他参数
%{
中间数据1： 体积对时间t的导数
        中间过程: 
1> 得到V的对theta的数据点
2> 得到V对theta的拟合函数
3> 将theta对t的函数 带入 得到 V对t的函数
4> diff(V) 
5> 同理 

中间数据2 最下端的面积
1> 最下半径处是RO5  getEachR()   得到数据点
2> 拟合theta 
3> 将theta对t的函数 带入 得到 R对t的函数
4> S_b_rec = pi*RO4^2
5> 

参数 1 推进力T
T =  Ro_water/s_bell_recovery_sym*(dVdt_recovery)^2;



中间值 ：最大半径处的面积 和 高度
1> 最大半径处是RO4    getEachR() 得到数据点 
2> 最大半径处的高度   getH_Indexof(4) 得到数据点
2> 拟合theta 
3> 将theta对t的函数 带入 得到 RO4   H 对t的函数
4> S_maxR = pi*RO4^2

参数2 阻力D的系数
D = 0.5*c_bell*ρwater*s_bell_max*u*U
D_before = 0.5*c_bell*ρwater*s_bell_max

if u<0
    c_bell = 0.42;
 else
    c_bell = 1.17;
end

参数3  A = α*ρwater*V*(?U/?t)

α = (h_最大半径处/r_maxR)^(-1.4)

A_before = α*ρwater*V



%}
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
tspan = [0.1 4*10];
y0 = [0 0];
%%
[res_t,res_y] = ode113(@(t,y) odefcn(t,y,Config), tspan, y0);

% 第一条线是位移
% plot(res_t,res_y(:,1))
% 第二条线是速度
% plot(res_t,res_y(:,2))
% 两条合并
plot(res_t,res_y)

%% 需要出图的是
% 1.速度，位移 --- 时间t
% 2.推进力T,阻力D ----时间t
[D_list,T_list,] = calc_D(res_t,res_y,Config);
