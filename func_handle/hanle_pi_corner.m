function [res_cell] = hanle_pi_corner(corner_cell)
%HANLE_PI_CORNER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
count = length(corner_cell);
res_cell = cell(1,count);
    for len = 1:count
        res_cell{len} = 180- corner_cell{len};     
    end
end

