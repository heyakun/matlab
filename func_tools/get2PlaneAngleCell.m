function [res_corner,res_corner_C] = get2PlaneAngleCell(state)
%GET2PLANEANGLECELL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%�����㣨��һ�㣩
%        B{1}
%       /  |  \
%O{2}{1}   |  O{2}{2}
%      \   |   /
%        B{2}
%ż���㣨�ڶ��㣩
%        A{2}
%       /  |  \
%O{3}{e}   |  O{3}{1}
%      \   |   /
%        A{3}
frames = length(state.O);
row_count = length(state.O{1})-2;
for fra_num=1:frames
    for row = 1: row_count
    %��һ��row =1 
        if (mod(row,2)==1)
            B_up =  state.B{fra_num}{row}{1};
            B_down = state.B{fra_num}{row+1}{1};
            O_left = state.O{fra_num}{row+1}{1};
            O_right =  state.O{fra_num}{row+1}{2};
            v1 = getVectorLeft(O_left,B_up,B_down);
            v2 = getVectorRight(O_right,B_up,B_down);
            %A Ϊ ��ת�ᵥλ���� Axis
            A = (B_down-B_up)/norm(B_down-B_up);
            res_corner{row}(fra_num) = get2PlaneCorner(v2,v1,A);
            res_corner_C{row}(fra_num) =180- res_corner{row}(fra_num);
        else
            %�ڶ���
            A_up= state.A{fra_num}{row}{1};
            A_down= state.A{fra_num}{row+1}{1};
            O_left  = state.O{fra_num}{row+1}{end};
            O_right =  state.O{fra_num}{row+1}{1};
            v1 = getVectorLeft(O_left,A_up,A_down);
            v2 = getVectorRight(O_right,A_up,A_down);
            A = (A_down-A_up)/norm(A_down-A_up);
            res_corner{row}(fra_num)  = get2PlaneCorner(v2,v1,A);
            res_corner_C{row}(fra_num) =180- res_corner{row}(fra_num);
        end
    %������
    
    end
end


end

