function [F_vpa] = getFRatioArr(state)
%GETFRATIOARR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
RiCell = getEachR(state);
R_end = RiCell{end};
H_max  = getMaxH(state);
F = H_max./R_end/2;
F_vpa = vpa(F,5);
end

