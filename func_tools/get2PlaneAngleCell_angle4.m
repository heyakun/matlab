function [res_corner,res_corner_C] = get2PlaneAngleCell_angle4(state)
%GET2PLANEANGLECELL 此处显示有关此函数的摘要
%   此处显示详细说明
% 第0层
%奇数层（第一层）
%B{1}{e}--A{1}{1}--B{1}{1}
%      \   |      /          
%         O{2}{1}
%      /   |      \        <----折痕角4
%B{2}{e}  A{2}{1} B{2}{1}
%偶数层（第二层）
%A{2}{1}--B{2}{1}--A{2}{2}
%      \   |      /           
%         O{3}{1}
%      /   |      \       <----折痕角4
%A{3}{1}--B{3}{1}--A{3}{2}
frames = length(state.O);
row_count = length(state.O{1})-2;
for fra_num=1:frames
    
    for row = 0: row_count
    %第一层row =1 
        if (mod(row,2)==1)
            O_up =  state.O{fra_num}{row+1}{1};
            A_down = state.A{fra_num}{row+1}{1};
            B_left = state.B{fra_num}{row+1}{end};
            B_right =  state.B{fra_num}{row+1}{1};
            v1 = getVectorLeft(B_left,O_up,A_down);
            v2 = getVectorRight(B_right,O_up,A_down);
            %A 为 旋转轴单位向量 Axis
            A = (A_down-O_up)/norm(A_down-O_up);
            res_corner{row+1}(fra_num) = get2PlaneCorner(v2,v1,A);
            res_corner_C{row+1}(fra_num) =180- res_corner{row+1}(fra_num);
        else
            %从第0层开始的 -----第二层
            O_up= state.O{fra_num}{row+1}{1};
            B_down= state.B{fra_num}{row+1}{1};
            A_left  = state.A{fra_num}{row+1}{1};
            A_right =  state.A{fra_num}{row+1}{2};
            v1 = getVectorLeft(A_left,O_up,B_down);
            v2 = getVectorRight(A_right,O_up,B_down);
            %A 为 旋转轴单位向量 Axis
            A = (B_down-O_up)/norm(B_down-O_up);
            res_corner{row+1}(fra_num)  = get2PlaneCorner(v2,v1,A);
            res_corner_C{row+1}(fra_num) =180- res_corner{row+1}(fra_num);
        end
    %第三层
    end
end


end

