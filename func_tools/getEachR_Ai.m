function [P_Aset_radius_C,P_Aset_radius] = getEachR_Ai(state)
%GETEACHR_AI �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%  P_Oset�� O�㼯 P_Oset{cur_pos:��ǰ����}{num����ǰ֡��}
a= 20;
A_count = length(state.A{1});
col_num = length(state.A{1}{1});

P_Aset=cell(1,A_count);
P_Aset_radius = cell(1,A_count);
P_Aset_radius_C = cell(1,A_count);
frames = length(state.A);
for cur_pos = 1:length(state.A{1})  
    for num = 1:frames
        P_Aset{cur_pos}{num} = state.A{num}{cur_pos}{1};
        
        P_Aset_radius{cur_pos}(num) =vpa(P_Aset{cur_pos}{num}(3),5);
        P_Aset_radius_C{cur_pos}(num) = P_Aset_radius{cur_pos}(num)/a;
    end
    %ϸ�ȱ�ѡȡ����O�㼯�еĵ�5������O4��仯
end
end

