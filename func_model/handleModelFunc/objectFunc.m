function [find] = objectFunc(mm,nn,Vi_ratio,m4_1max,m4_1min,i)
%OBJECTFUNC �˴���ʾ�йش˺�����ժҪ
% �˴���ʾ��ϸ˵��
% find = 0.2*mm*nn - Vi_ratio*(m4_1max-m4_1min);
find =  - Vi_ratio*(m4_1max-m4_1min);

end

