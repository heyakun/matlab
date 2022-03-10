function [finenessRatio] = drawFineness(state,cta_in,num_O,symbol)
%输入state 全部数据
%cta_in 是输入角数组
%num_O 指定O点集中的第几个作为末端点，例如num_O = 5 ,即 为O4点集,num_O = 1, O0点
P_Oset=cell(1,length(state.O{1}));
frames = length(state.O);
finenessRatio = zeros(1,frames);
for num = 1:frames
    for cur_pos = 1:length(state.O{1})
        P_Oset{cur_pos} = state.O{num}{cur_pos}{1};
    end
    %细度比选取的是O点集中的第5个，即O4点变化
finenessRatio(num) = abs(P_Oset{num_O}(2)/norm([P_Oset{num_O}(1),P_Oset{num_O}(3)]))/2;
end
% t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
% cta_in = 0.4*pi-0.35*pi*t;
% useLine(double(cta_in),finenessRatio)
usePlot(double(cta_in),finenessRatio,symbol)
xlim([0 pi/2]);
xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
xlabel('\theta_{in}')
ylabel('fineness')
ax = gca;
ax.FontSize = 14;
hold on 
end

