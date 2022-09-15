function [S_t_r,S_t_c] = calc_S_by_t(S_len,t_r,t_c)
%CALC_S_BY_T �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ����һ������T ���߳�S_len��ʱ��t�仯��sym���ʽ
% ������0-trʱ�����н׶ε�S(0-tr)��ʱ������
% ������0-trʱ�����н׶ε�S(tr-T)��ʱ������

% ����ʾ�� S_len = [ , ],tr = 2.4s , tc = 1.6s
S0 = S_len(1);%�ϳ�
S1 = S_len(2);%�϶�

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
end

