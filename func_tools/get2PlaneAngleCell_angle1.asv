function [res_corner,res_corner_C] = get2PlaneAngleCell_angle1(state)
%GET2PLANEANGLECELL 此处显示有关此函数的摘要
%   此处显示详细说明
%奇数层（第一层）
%B{1}{e}--A{1}{1}--B{1}{1}
%      \   |      /          <----折痕角1
%         O{2}{1}
%      /   |      \
%B{2}{e}  A{2}{1} B{2}{1}
%偶数层（第二层）
%A{2}{1}--B{2}{1}--A{2}{2}
%      \   |      /           <----折痕角1
%         O{3}{1}
%      /   |      \
%A{3}{1}--B{3}{1}--A{3}{2}
frames = length(state.O);
row_count = length(state.O{1})-2;
for fra_num=1:frames
    for row = 1: row_count+1
    %第一层row =1 
        if (mod(row,2)==1)
            A_up =  state.A{fra_num}{row}{1};
            O_down = state.O{fra_num}{row+1}{1};
            B_left = state.B{fra_num}{row}{end};
            B_right =  state.B{fra_num}{row}{1};
            v1 = getVectorLeft(B_left,A_up,O_down);
            v2 = getVectorRight(B_right,A_up,O_down);
            %A 为 旋转轴单位向量 Axis
            A = (O_down-A_up)/norm(O_down-A_up);
            res_corner{row}(fra_num) = get2PlaneCorner(v2,v1,A);
            res_corner_C{row}(fra_num) =180- res_corner{row}(fra_num);
        else
            %第二层
            B_up= state.B{fra_num}{row}{1};
            O_down= state.O{fra_num}{row+1}{1};
            A_left  = state.A{fra_num}{row}{1};
            A_right =  state.A{fra_num}{row}{2};
            v1 = getVectorLeft(A_left,B_up,O_down);
            v2 = getVectorRight(A_right,B_up,O_down);
            %A 为 旋转轴单位向量 Axis
            A = (O_down-B_up)/norm(O_down-B_up);
            res_corner{row}(fra_num)  = get2PlaneCorner(v2,v1,A);
            res_corner_C{row}(fra_num) =180- res_corner{row}(fra_num);
        end
    %第三层
    end
end


end

