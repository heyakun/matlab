%% 文件说明
% 设置了 5个实验组
% 代入不同的运动学参数（t_r,t_c,T,FR,），对该函数进行遍历 auto_dyn
%% 前置数据
global a p n m frames
m = 5;
n = 16;
a = 20;
p = 15;
frames = 10;
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 用于将Cta_in弧度制转角度
cta_in2 = rad2deg(cta_in');

%% （观测）模型 和 模型细度比范围 
[state,~] = createModel(m,n,a,p,frames);
FR_arr = getFRatioArr(state);
% [FR_by_thetaIn_func,func_finess_sym] = getFitFunc2(cta_in2,FR_arr,4);
% 
% f  =func_finess_sym;
% FR_up = fsolve(matlabFunction(f-1),50);
% FR_down = fsolve(matlabFunction(f-0.39),10);
% 
% FR = [FR_up,FR_down];
%% 实验常量
% 水的密度
Ro_water = 0.001; %g/mm^3


%% 实验组1 tr/tc的比值变化
%运动学参数包括 t_r t_c FR的范围
%1,配置不同的t_r序列%
%对照组是t_r = 2.4 t_c = 1.6 ，z周期T = 4s
% 实验组 t_r ,t_c 变化，周期 T不变
FR = [0.39,1];
T =4;
t_r_list = (1:0.1:3)';
t_c_list = (3:-0.1:1)';
tc_By_tr = t_c_list./t_r_list;

% （测试）一次计算
%  auto_dyn(2.4,1.6,FR,state,cta_in2);
%
t_len = length(t_r_list);
dyn_output = cell(t_len,1);
for index = 1:t_len
    dyn_output{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

save dyn_output
%% 实验组2 tc不变 tr变化 ，总周期也变化
t_r_list = (1:0.1:3)';
t_c = 1.6;

FR = [0.39,1];
dyn_output2 = cell(t_len,1);
for index = 1:t_len
    dyn_output2{index} = auto_dyn(t_r_list(index),t_c,FR,state,cta_in2);
end
%% 实验组3 tr不变 tc变化，总周期变化
t_r = 2.4;
t_c_list = (3:-0.1:1)';
FR = [0.39,1];
dyn_output3 = cell(t_len,1);
for index = 1:t_len
    dyn_output3{index} = auto_dyn(t_r,t_c_list(index),FR,state,cta_in2);
end

%% 实验组4 tr/tc比例不变，T周期变化
t_r_list = (2.4*0.8:0.24:4.8)';
t_c_list = (1.6*0.8:0.16:3.2)';
FR = [0.39,1];
t_len = length(t_r_list);
dyn_output4 = cell(t_len,1);
for index = 1:t_len
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% 实验组5.1 : tr,tc都不变，FR变化（oblate型范围内）
t_r = 2.4;
t_c = 1.6;

FR_up = 0.40:0.05:1;
len = length(FR_up);
dyn_output5 = cell(t_len,1);
for index = 1:len
    FR = [0.39,FR_up(index)];
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% 实验组5.2 ：tr,tc不变，FR变化(problate型范围内)
t_r = 2.4;
t_c = 1.6;

FR_up = 1.2:0.1:2.5;
len = length(FR_up);
dyn_output5 = cell(t_len,1);
for index = 1:len
    FR = [1,FR_up(index)];
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% 实验组5.3 : tr,tc不变，FR横跨


