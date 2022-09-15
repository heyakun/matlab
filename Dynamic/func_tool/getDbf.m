function [Db1f,Db2f] = getDbf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water)
%GETDBF �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% D = 0.5*c_bell*��water*s_bell_max*u*U
% D_before = 0.5*c_bell*��water*s_bell_max
c_bell = 1;%�����ȵ���1����odefcn���������
% ���뾶��
R_Os = getEachR(state);
R_max = R_Os{4};
R_max_f= getFitFunc2(cta_in2',R_max,2);

R_max_T_rec = R_max_f(cta_T_rec);
R_max_T_con = R_max_f(cta_T_con);

%���뾶�����
S_max_rec = pi*R_max_T_rec^2;
S_max_con = pi*R_max_T_con^2;

D_before_rec = 0.5*c_bell*Ro_water*S_max_rec;
D_before_con = 0.5*c_bell*Ro_water*S_max_con;
Db1f = matlabFunction(D_before_rec);
Db2f = matlabFunction(D_before_con);
end

