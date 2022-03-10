function [P_Oset_radius_C,P_Oset_radius] = draw_each_r(state,cta_in,symbol)
%DRAW_EACH_R 此处显示有关此函数的摘要
%   此处显示详细说明
%  P_Oset： O点集 P_Oset{cur_pos:当前层数}{num：当前帧数}
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
    %细度比选取的是O点集中的第5个，即O4点变化
end

%绘制每层半径变化
usePlot(double(cta_in),P_Oset_radius_C{1},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{2},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{3},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{4},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{5},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{6},symbol)
hold on 
usePlot(double(cta_in),P_Oset_radius_C{7},symbol)
xlim([0 pi/2]);
xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
xlabel('\theta_{in}')
ylabel('R_{i}/a')
ax = gca;
ax.FontSize = 14;

end

