% addpath(genpath('func_tool'))
% addpath(genpath('func_auto'))
%% ǰ������
frames=10;
t = linspace(0,1,frames);     
% ˮ���ܶ�
Ro_water = 0.001; %g/mm^3
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 ���ڽ�Cta_in������ת�Ƕ�
cta_in2 = rad2deg( cta_in');

%��ֽģ��
[state,~] = createModel(m,n,a,p,frames);
%ʵ��ģ��
% [realModelState,realModelCorner] = createModel(5,16,40,30,10);
% state = realModelState;
%%
t_r = 2.4;
t_c = 1.6;
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';
% cta_in  �� t �� sym���ʽ
% [ cta_T_rec,cta_T_con ] = calc_S(state,cta_in2,t_r,t_c);
%% auto_flow�������� 
% ˮĸΪoblate�ͣ�ϸ�ȱ����䡾����Ӧ�Ħ�in������Ϊ
oblate = [49 , 9];
prolate =[70 , 49];
% ���ĸ��ڶ���ѧ����ʱ�ǷǱ�Ҫ�ģ�����������ϸ�ȱ���t���ߵ�
[ cta_T_rec,cta_T_con,res_FR_r,tr,res_FR_c,tc ] = auto_flow(state,cta_in2,t_r,t_c,oblate);
%% ��һ�� ϸ�ȱ�

%% ��t y���⣬��������
%{
�м�����1�� �����ʱ��t�ĵ���
        �м����: 
1> �õ�V�Ķ�theta�����ݵ�
2> �õ�V��theta����Ϻ���
3> ��theta��t�ĺ��� ���� �õ� V��t�ĺ���
4> diff(V) 
5> ͬ�� 

�м�����2 ���¶˵����
1> ���°뾶����RO5  getEachR()   �õ����ݵ�
2> ���theta 
3> ��theta��t�ĺ��� ���� �õ� R��t�ĺ���
4> S_b_rec = pi*RO4^2
5> 

���� 1 �ƽ���T
T =  Ro_water/s_bell_recovery_sym*(dVdt_recovery)^2;



�м�ֵ �����뾶������� �� �߶�
1> ���뾶����RO4    getEachR() �õ����ݵ� 
2> ���뾶���ĸ߶�   getH_Indexof(4) �õ����ݵ�
2> ���theta 
3> ��theta��t�ĺ��� ���� �õ� RO4   H ��t�ĺ���
4> S_maxR = pi*RO4^2

����2 ����D��ϵ��
D = 0.5*c_bell*��water*s_bell_max*u*U
D_before = 0.5*c_bell*��water*s_bell_max

if u<0
    c_bell = 0.42;
 else
    c_bell = 1.17;
end

����3  A = ��*��water*V*(?U/?t)

�� = (h_���뾶��/r_maxR)^(-1.4)

A_before = ��*��water*V



%}
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
tspan = [0.1 4*10];
y0 = [0 0];
%%
[res_t,res_y] = ode113(@(t,y) odefcn(t,y,Config), tspan, y0);

% ��һ������λ��
% plot(res_t,res_y(:,1))
% �ڶ��������ٶ�
% plot(res_t,res_y(:,2))
% �����ϲ�
plot(res_t,res_y)

%% ��Ҫ��ͼ����
% 1.�ٶȣ�λ�� --- ʱ��t
% 2.�ƽ���T,����D ----ʱ��t
[D_list,T_list,] = calc_D(res_t,res_y,Config);
