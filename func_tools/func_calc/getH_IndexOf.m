function [H_index] = getH_IndexOf(state,index)
%GETH_INDEXOF 此处显示有关此函数的摘要
%   此处显示详细说明
 [Hi_cell,] = getEachH(state);
 H_index= 0;
 for i = 1: index
    H_index =  H_index+Hi_cell{i};
 end
end

