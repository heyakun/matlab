function [res_cata_vpa] = get2PlaneCorner(v1,v2,A)
%GET2PLANEANGLE �˴���ʾ�йش˺�����ժҪ
% �˴���ʾ��ϸ˵��
%���� v1 v2 �ֱ���������ķ�����
%���� A �� ��ת��
%����handle_v1Byv2Rotate �õ�����һ�����̣�temp_v����������
%�������������v2�����
syms cta

temp_v = handle_v1Byv2Rotate(v1,A,cta);
f =matlabFunction(temp_v-v2);
options = optimoptions('fsolve','Algorithm','levenberg-marquardt');
res_cta = fsolve(f,1.57,options);
res_cata_vpa = vpa(rad2deg(res_cta),5);
end

