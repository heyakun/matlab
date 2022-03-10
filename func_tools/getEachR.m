function [P_Oset_radius,P_Oset_radius_C] = getEachR(state)
%GETEACHR 此处显示有关此函数的摘要
%   此处显示详细说明
a= 20;
O_count = length(state.O{1});
col_num = length(state.O{1}{1});

P_Oset=cell(1,O_count);
P_Oset_radius = cell(1,O_count);
P_Oset_radius_C = cell(1,O_count);
frames = length(state.O);
for cur_pos = 1:length(state.O{1})  
    for num = 1:frames
        if (mod(cur_pos,2)==1)
           P_Oset{cur_pos}{num}= hanle_Point_Ry(state.O{num}{cur_pos}{1},col_num);
        else
           P_Oset{cur_pos}{num} = state.O{num}{cur_pos}{1};
        end
        P_Oset_radius{cur_pos}(num) =vpa(P_Oset{cur_pos}{num}(3),5);
        P_Oset_radius_C{cur_pos}(num) = P_Oset_radius{cur_pos}(num)/a;
    end
end
end

