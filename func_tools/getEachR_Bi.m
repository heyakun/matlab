function [P_Bset_radius_C,P_Bset_radius] = getEachR_Bi(state)
%GETEACHR_BI 此处显示有关此函数的摘要
%   此处显示详细说明
a= 20;
B_count = length(state.B{1});
col_num = length(state.B{1}{1});

P_Bset=cell(1,B_count);
P_Bset_radius = cell(1,B_count);
P_Bset_radius_C = cell(1,B_count);
frames = length(state.B);
for cur_pos = 1:length(state.B{1})  
    for num = 1:frames

        P_Bset{cur_pos}{num}= hanle_Point_Ry(state.B{num}{cur_pos}{1},col_num);

        P_Bset_radius{cur_pos}(num) =vpa(P_Bset{cur_pos}{num}(3),5);
        P_Bset_radius_C{cur_pos}(num) = P_Bset_radius{cur_pos}(num)/a;
    end
    %细度比选取的是O点集中的第5个，即O4点变化
end
end

