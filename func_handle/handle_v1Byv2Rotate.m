function [res_P] = handle_v1Byv2Rotate(P,A,cta)
%V1BYV2ROTATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% �ٶ�����P�Ƶ�λ����A��ת�ǶȦȣ��õ��µ�����P'����
% P'=P * cos�� + (A��P)sin�� +A(A��P)(1 - cos��)
% ����AΪ��λ��������ת�ǶȦ�Ϊ��ʱ�뷽����ת�ĽǶȡ�
% �ٶ�����P������Ϊ��px��py��pz��������A������Ϊ��ax��by��cz��
% �ң�
%  AXP = [ay * pz- az * py, ax * pz- az * px , ax * py- ay * px];
%  A��P = ax * px + ay * py + az * pz
res_P = P*cos(cta)+cross(A,P)*sin(cta)+A*(dot(A,P)*(1-cos(cta)));



end

