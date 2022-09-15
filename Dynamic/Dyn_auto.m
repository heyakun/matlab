%% �ļ�˵��
% ������ 5��ʵ����
% ���벻ͬ���˶�ѧ������t_r,t_c,T,FR,�����Ըú������б��� auto_dyn
%% ǰ������
global a p n m frames
m = 5;
n = 16;
a = 20;
p = 15;
frames = 10;
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 ���ڽ�Cta_in������ת�Ƕ�
cta_in2 = rad2deg(cta_in');

%% ���۲⣩ģ�� �� ģ��ϸ�ȱȷ�Χ 
[state,~] = createModel(m,n,a,p,frames);
FR_arr = getFRatioArr(state);
% [FR_by_thetaIn_func,func_finess_sym] = getFitFunc2(cta_in2,FR_arr,4);
% 
% f  =func_finess_sym;
% FR_up = fsolve(matlabFunction(f-1),50);
% FR_down = fsolve(matlabFunction(f-0.39),10);
% 
% FR = [FR_up,FR_down];
%% ʵ�鳣��
% ˮ���ܶ�
Ro_water = 0.001; %g/mm^3


%% ʵ����1 tr/tc�ı�ֵ�仯
%�˶�ѧ�������� t_r t_c FR�ķ�Χ
%1,���ò�ͬ��t_r����%
%��������t_r = 2.4 t_c = 1.6 ��z����T = 4s
% ʵ���� t_r ,t_c �仯������ T����
FR = [0.39,1];
T =4;
t_r_list = (1:0.1:3)';
t_c_list = (3:-0.1:1)';
tc_By_tr = t_c_list./t_r_list;

% �����ԣ�һ�μ���
%  auto_dyn(2.4,1.6,FR,state,cta_in2);
%
t_len = length(t_r_list);
dyn_output = cell(t_len,1);
for index = 1:t_len
    dyn_output{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

save dyn_output
%% ʵ����2 tc���� tr�仯 ��������Ҳ�仯
t_r_list = (1:0.1:3)';
t_c = 1.6;

FR = [0.39,1];
dyn_output2 = cell(t_len,1);
for index = 1:t_len
    dyn_output2{index} = auto_dyn(t_r_list(index),t_c,FR,state,cta_in2);
end
%% ʵ����3 tr���� tc�仯�������ڱ仯
t_r = 2.4;
t_c_list = (3:-0.1:1)';
FR = [0.39,1];
dyn_output3 = cell(t_len,1);
for index = 1:t_len
    dyn_output3{index} = auto_dyn(t_r,t_c_list(index),FR,state,cta_in2);
end

%% ʵ����4 tr/tc�������䣬T���ڱ仯
t_r_list = (2.4*0.8:0.24:4.8)';
t_c_list = (1.6*0.8:0.16:3.2)';
FR = [0.39,1];
t_len = length(t_r_list);
dyn_output4 = cell(t_len,1);
for index = 1:t_len
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% ʵ����5.1 : tr,tc�����䣬FR�仯��oblate�ͷ�Χ�ڣ�
t_r = 2.4;
t_c = 1.6;

FR_up = 0.40:0.05:1;
len = length(FR_up);
dyn_output5 = cell(t_len,1);
for index = 1:len
    FR = [0.39,FR_up(index)];
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% ʵ����5.2 ��tr,tc���䣬FR�仯(problate�ͷ�Χ��)
t_r = 2.4;
t_c = 1.6;

FR_up = 1.2:0.1:2.5;
len = length(FR_up);
dyn_output5 = cell(t_len,1);
for index = 1:len
    FR = [1,FR_up(index)];
    dyn_output4{index} = auto_dyn(t_r_list(index),t_c_list(index),FR,state,cta_in2);
end

%% ʵ����5.3 : tr,tc���䣬FR���


