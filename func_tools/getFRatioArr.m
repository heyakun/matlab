function [F_vpa] = getFRatioArr(state)
%GETFRATIOARR 此处显示有关此函数的摘要
%   此处显示详细说明
RiCell = getEachR(state);
R_end = RiCell{end};
H_max  = getMaxH(state);
F = H_max./R_end/2;
F_vpa = vpa(F,5);
end

