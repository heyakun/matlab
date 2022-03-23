function [S_rByt_sym,S_cByt_sym] = calc_S(state,cta_in2,t_r,t_c)
%CALC_S �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ��һ�������� S �ֳ����� ���Ž׶� ��  �����׶�
% T = 4s  tr = 2.4s  tc = 1.6s
% [0 , tr] [ tr ,  T]
%y = k*t +b
%p_S �õ�S�ĳ��ȱ仯 
%S0��ʼ���� p_S(0)    S1��������p_S(end)
%% ��S ���Ž׶κ������׶εĺ����� ʱ������

p_S = calcLineLength(state);
S0 = p_S(1);
S1 = p_S(end);
k_r = (S1-S0)/t_r;
k_c = (S0-S1)/t_c;
syms tt
S_tr_sym = S0+k_r*tt;
S_tc_sym= k_c*(tt-t_r)+S1;

%ʱ������-���Ž׶�
tr = (0:0.1:t_r)';
S_t_r = S0+k_r*tr;
%ʱ������-�����׶�
tc = (t_r:0.1:t_r+t_c)';
S_t_c = k_c*(tc-t_r)+S1;

%% ��� H r �Ĺ��� theta_in����Ϻ���
maxH = getMaxH(state);
ROi = getEachR(state);

[~,func_maxH_sym] = getFitFunc2(cta_in2,maxH,2);
[~,func_ROi_6_sym] = getFitFunc2(cta_in2',ROi{6},2);



%% �ⷽ�� -- S ��ʱ�������� ��� theta_in ��ֵ: ���Ž׶�
eq_right = sqrt((func_maxH_sym-20)^2+func_ROi_6_sym^2);
res_r = zeros(length(tr),1);
for index = 1:length(tr)
    
    f= matlabFunction(S_t_r(index)-eq_right);
    res_r(index) = fsolve(f,45);
end
%% �ⷽ�� -- S ��ʱ�������� ��� theta_in ��ֵ: �����׶�

res_c = zeros(length(tc),1);
for index_c = 1:length(tc)
    
    f= matlabFunction(S_t_c(index_c)-eq_right);
    res_c(index_c) = fsolve(f,45);
end
%% ���theta_in  �� t �ĺ���
[ ~,S_rByt_sym] = getFitFunc2(tr,res_r,1);
[ ~,S_cByt_sym] = getFitFunc2(tc,res_c,1);
end

