function [find] = objectFunc(mm,nn,Vi_ratio,m4_1max,m4_1min,i)
%OBJECTFUNC 此处显示有关此函数的摘要
% 此处显示详细说明
% find = 0.2*mm*nn - Vi_ratio*(m4_1max-m4_1min);
find =  - Vi_ratio*(m4_1max-m4_1min);

end

