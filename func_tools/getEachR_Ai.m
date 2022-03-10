function [P_Aset_radius_C,P_Aset_radius] = getEachR_Ai(state)
%GETEACHR_AI 此处显示有关此函数的摘要
%   此处显示详细说明
%  P_Oset： O点集 P_Oset{cur_pos:当前层数}{num：当前帧数}
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
    %细度比选取的是O点集中的第5个，即O4点变化
end
end

