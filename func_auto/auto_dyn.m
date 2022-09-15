function [output] = auto_dyn(t_r,t_c,FR,state,cta_in2)
%AUTO_DYN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% �˶�ѧ����
% t_r �ָ��׶�ʱ��
% t_c �����׶�ʱ��
% FR ϸ�ȱȷ�Χ���� ���磺[0.39,1] �� [1,2.6]

%% ǰ������
% frames=10;
% t = linspace(0,1,frames);     
% ˮ���ܶ�
Ro_water = 0.001; %g/mm^3
% cta_in = 9/20*pi-0.4*pi*t;
% %cta_in2 ���ڽ�Cta_in������ת�Ƕ�
% cta_in2 = rad2deg( cta_in');
%%
% [state,~] = createModel(m,n,a,p,frames);

% t_r = 2.4;
% t_c = 1.6;
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';
% cta_in  �� t �� sym���ʽ
% [ cta_T_rec,cta_T_con ] = calc_S(state,cta_in2,t_r,t_c);
%% auto_flow�������� 
% ��ϸ�ȱ����
FR_arr = getFRatioArr(state);
[~,func_finess_sym] = getFitFunc2(cta_in2,FR_arr,4);

% ���� FR = [0.39 ,1]
% ���in_arr = [50.6 , 8.3]
FR_up = max(FR); 
FR_down = min(FR);

f  =func_finess_sym;
in_up = fsolve(matlabFunction(f-FR_up),50);
in_down = fsolve(matlabFunction(f-FR_down),10);


% ˮĸΪoblate�ͣ�ϸ�ȱ����䡾����Ӧ�Ħ�in������Ϊ
% oblate = [49 , 9];
% prolate =[70 , 49];
in_arr = [in_up,in_down];

% ���ĸ��ڶ���ѧ����ʱ�ǷǱ�Ҫ�ģ�����������ϸ�ȱ���t���ߵ�
[ cta_T_rec,cta_T_con,res_FR_r,tr,res_FR_c,tc ] = auto_flow(state,cta_in2,t_r,t_c,in_arr);
%% 
%T
[T1f,T2f] = getTf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
% ������ϵ�� D_before 
[Db1f,Db2f] = getDbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
% A_before ���� A = ��*��water*V*(?U/?t) A_before = ��*��water*V
[Ab1f,Ab2f] = getAbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water);
%% �ռ�
Config.T1f = T1f;
Config.T2f = T2f;
Config.Db1f = Db1f;
Config.Db2f = Db2f;
Config.Ab1f = Ab1f;
Config.Ab2f = Ab2f;
Config.t_r = t_r;
Config.t_c = t_c;
%% ode45 ���
T = t_r + t_c;
% ʱ����10������
tspan = [0.1 T*10];
y0 = [0 0];
%%
[res_t,res_y] = ode113(@(t,y) odefcn(t,y,Config), tspan, y0);
% plot(res_t,res_y)
% %��λ������
% plot(res_t,res_y(:,1))
% % ���ٶ�����
% plot(res_t,res_y(:,2))
%% ����ƽ���ٶ�
res =  [res_t,res_y];
res_filter = res(res(:,1)>=T*5,:);

v_averArr = res_filter(:,2)./res_filter(:,1);
v_aver = sum(v_averArr)/length(v_averArr);
% res_t(res_t(:,))
% res_y(:,1)
%% ����D


%% �ռ�������Ϊ����ֵ
% 1.�ռ�ϸ�ȱȱ仯����
output.res_FR_r = res_FR_r;
output.tr = tr;
output.res_FR_c = res_FR_c;
output.tc = tc;
% 2.�ռ�λ���ٶ�����
output.res_t = res_t;
output.res_y = res_y;
% 3.�ռ���6�����ڵ�ƽ���ٶ�
output.v_aver =v_aver;
% 4.�ռ�T��D��һ��������ı仯
output.T1f = T1f;
output.T2f = T2f;
output.D1f = D1f;
output.D2f = D2f;

end

