function [P_O_H] = getEachH(state)
%GETEACHH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%DRAW_EACH_H �˴���ʾ�йش˺�����ժҪ
%�˴���ʾ��ϸ˵��
a= 20;
P_Oset=cell(1,length(state.O{1}));
frames = length(state.O);

%��O��yֵ��ΪH
P_O_H = zeros(frames,1);

%��ǰλ��Ϊ���²��O��
cur_pos = length(state.O{1})-1;
    for num = 1:frames
        P_Oset{cur_pos}{num} = state.O{num}{cur_pos}{1};
        P_O_H(num) =-(vpa(P_Oset{cur_pos}{num}(2),5))/a;
    end
end

