function [finenessRatio] = drawFineness(state,cta_in,num_O,symbol)
%����state ȫ������
%cta_in �����������
%num_O ָ��O�㼯�еĵڼ�����Ϊĩ�˵㣬����num_O = 5 ,�� ΪO4�㼯,num_O = 1, O0��
P_Oset=cell(1,length(state.O{1}));
frames = length(state.O);
finenessRatio = zeros(1,frames);
for num = 1:frames
    for cur_pos = 1:length(state.O{1})
        P_Oset{cur_pos} = state.O{num}{cur_pos}{1};
    end
    %ϸ�ȱ�ѡȡ����O�㼯�еĵ�5������O4��仯
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

