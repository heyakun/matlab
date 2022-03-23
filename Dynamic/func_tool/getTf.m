function [T1f,T2f] = getTf(state,cta_in2,cta_T_rec,cta_T_con,Ro_water)
%GETTF �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ����1 ��� -- ����ĵ�
[Vi,~,~] = getEachV_2(state);
[Vi_f] =getFitFunc2(cta_in2',Vi,2);
Vi_T_rec = Vi_f(cta_T_rec);
Vi_T_con = Vi_f(cta_T_con);
dVidt_rec = diff(Vi_T_rec);
dVidt_con = diff(Vi_T_con);

% ���¶˰뾶
R_Os = getEachR(state);
R_end = R_Os{end};
R_end_func = getFitFunc2(cta_in2',R_end,2);

R_end_T_rec_f = R_end_func(cta_T_rec);
R_end_T_con_f = R_end_func(cta_T_con);

%���¶����
S_end_rec_f = pi*R_end_T_rec_f^2;
S_end_con_f = pi*R_end_T_con_f^2;

% �ƽ�������
T1 = Ro_water/S_end_rec_f*dVidt_rec^2;
T2 = Ro_water/S_end_con_f*dVidt_con^2;

T1f= matlabFunction(T1);
T2f= matlabFunction(T2);
end

