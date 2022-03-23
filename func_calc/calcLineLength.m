function [S] = calcLineLength(state)
%CALCLINELENGTH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
RiCell = getEachR(state);
R_end = RiCell{end};
H_max  = getMaxH(state);
h = 40;
len = length(R_end);
S = zeros(1,len);
    for i = 1:len
        S(i) =sqrt(R_end(i)^2+(H_max(i)-h)^2);
    end
end

