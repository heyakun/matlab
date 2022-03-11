function [Hi,P_O_H,P_O_H_C] = getEachH(state)
%GETEACHH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%DRAW_EACH_H �˴���ʾ�йش˺�����ժҪ
%�˴���ʾ��ϸ˵��
a= 20;
P_Oset=cell(1,length(state.O{1})-1);
frames = length(state.O);

%��O��yֵ��ΪH
P_O_H = zeros(frames,1);
P_O_H_C = zeros(frames,1);

m = length(state.O{1})-2;
Hi = cell(1,m);

%����һλ O ��
O_end = length(state.O{1})-1;
    for num = 1:frames
        for mm = 1: O_end
            P_Oset{mm}{num} = state.O{num}{mm}{1};
            if(mm>1)
                Hi{mm-1}(num)=vpa(P_Oset{mm-1}{num}(2)-P_Oset{mm}{num}(2),5);
            end
        end
        P_O_H(num) = -(vpa(P_Oset{O_end}{num}(2),5));
        P_O_H_C(num) = P_O_H(num)/a;
    end
    
end
%         P_Oset{cur_pos}{num} = state.O{num}{cur_pos}{1};
%         P_O_H(num) =-(vpa(P_Oset{cur_pos}{num}(2),5))/a;
