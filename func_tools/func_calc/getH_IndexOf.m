function [H_index] = getH_IndexOf(state,index)
%GETH_INDEXOF �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
 [Hi_cell,] = getEachH(state);
 H_index= 0;
 for i = 1: index
    H_index =  H_index+Hi_cell{i};
 end
end

