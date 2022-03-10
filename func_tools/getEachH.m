function [P_O_H] = getEachH(state)
%GETEACHH 此处显示有关此函数的摘要
%   此处显示详细说明
%DRAW_EACH_H 此处显示有关此函数的摘要
%此处显示详细说明
a= 20;
P_Oset=cell(1,length(state.O{1}));
frames = length(state.O);

%点O的y值作为H
P_O_H = zeros(frames,1);

%当前位置为最下层的O点
cur_pos = length(state.O{1})-1;
    for num = 1:frames
        P_Oset{cur_pos}{num} = state.O{num}{cur_pos}{1};
        P_O_H(num) =-(vpa(P_Oset{cur_pos}{num}(2),5))/a;
    end
end

