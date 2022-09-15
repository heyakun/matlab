function [theta_in_by_tr_sym,theta_in_by_tc_sym,res_FR_r,tr,res_FR_c,tc] = auto_flow(state,cta_in2,t_r,t_c,theta_in_interval )
%AUTO_ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ����ֵǰ�����Ǳ�Ҫ�ģ��ǻָ��׶κ������׶εĦ�in �� t sym���ʽ
% theta_in_by_tr_sym,theta_in_by_tc_sym
% ���ĸ��ڶ���ѧ����ʱ�ǷǱ�Ҫ�ģ�����������ϸ�ȱ���t���ߵ�
%% �׶�0 
% ����config
% t_r = cofig.t_r;
% t_c = cofig.t_c;
% L = cofig.L;
% h = cofig.h;
n = length(state.A{1}{1});
frames = length(state.A);
%��in�ı仯���䣺���ڵ����׶εļ���
theta_b = theta_in_interval(1);
theta_e = theta_in_interval(2);



%% �׶�1 �ռ���p��ֵ��ִ�в�����ת�Ƿ�Χ(������ɺ���)
%�ռ�A��1,0���ı仯��ȫ������
%����1��O(1,0)��O(1,n)���е㵽0,0,0������(ʹ��y[0,1,0]��ΪY1)
%����2��O(1,0)��O(1,n)���е㵽A(1,0)������
%��ת�᣺��1,0,0��
%��⹫ʽ
%Y2=  Y1*cos��+(A��Y1)sin��+A(A?P)(1-cos��)

%��ȡO�е������1
O_1_0 = state.O{1}{1}{1};
O_1_n = state.O{1}{1}{n};
O_c = [0;0;O_1_0(3)];
%Y1 = -O_c/norm(O_c);
Y1 = [0;1;0];
%��ת��
Axis = [1;0;0]; 
%��ȡAϵ�еĵ������2:Y2_i
A_out = cell(1,frames);
Y2_i = cell(1,frames);
% res_p = zeros(frames,1);
for Ai=1:frames
    A_out{Ai} = state.A{Ai}{1}{1};
    Y2_i{Ai} = (A_out{Ai}-O_c)/norm(A_out{Ai}-O_c);
end
%% �׶ζ������p������Ϧ�p���ڦ�in�ı��ʽ��
Ai=1;
theta_p=zeros(frames,1);
for Ai=1:frames
    theta_p(Ai)= get2PlaneCorner(Y1,Y2_i{Ai},Axis);
end
[theta_p_func,theta_p_sym] =getFitFunc2(cta_in2,theta_p,1);
%% �׶�����ȷ��L��h,�ͦ�p�ķ�Χ��ȷ���߳��ķ�Χ
%����oblate�ͣ���in �ķ�Χ��[49 -> 9]����p��Χ[93.98 -> 48.58]
%Slen_o��ʵ�����[65.813 , 37.024]
% theta_b = 49;
% theta_e = 9;

theta_p_o_b =  theta_p_func(theta_b);
theta_p_o_e =  theta_p_func(theta_e);

% %����prolate�ͣ���in �ķ�Χ��[81->49],��p��Χ[93.98 -> 48.58]
%Slen_o��ʵ�����[65.813 , 37.024]
%  theta_p_o_b =  theta_p_func(81);
%  theta_p_o_e =  theta_p_func(9);
%S^2 = L^2+ h^2+2*L*h*cosd(��p)
L = 45;
h = 45;
S_o_b = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_b));
S_o_e = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_e));
Slen_o = [S_o_b,S_o_e];
%% �׶����� ��֪tr ,tc ���� kr, kc ���õ��߳�S��0~tr tr~ T����
% t_r = 2.4;
% t_c = 1.6;
% ����д�ں�����(ת��)
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';

[S_t_r,S_t_c] = calc_S_by_t(Slen_o,t_r,t_c);

%% �׶��ģ� ��֪�߳�S(t)������,�����p����->��in->FR
[theta_p_r] = solve_St_to_thetaP(S_t_r,L,h);
[theta_p_c] = solve_St_to_thetaP(S_t_c,L,h);

%�õ���p �����in
[theta_in_r] = solve_ThetaP_to_in(theta_p_r,theta_p_sym);
[theta_in_c] = solve_ThetaP_to_in(theta_p_c,theta_p_sym);
% ��in �� t �������һ�� �õ���in �� t sym���ʽ(��Ϊ����ֵ)
[ ~,theta_in_by_tr_sym] = getFitFunc2(tr,theta_in_r,2);
[ ~,theta_in_by_tc_sym] = getFitFunc2(tc,theta_in_c,2);

%�õ���in ����FR(����ѧ���㲻��Ҫ�õ�������FR�� t�仯���߲���Ҫ����)
FR = getFRatioArr(state);
[FR_by_thetaIn_func,func_finess_sym] =   getFitFunc2(cta_in2,FR,4);
[res_FR_r] = solve_ThetaIn_to_FR(theta_in_r,FR_by_thetaIn_func);
[res_FR_c] = solve_ThetaIn_to_FR(theta_in_c,FR_by_thetaIn_func);
end

