function [outputArg1,outputArg2] = drawSmax(state,cta_in,pos)
%DRAWSHOLE 此处显示有关此函数的摘要
frames = length(state.O);
S_bell = zeros(1,frames);
r_bell = zeros(1,frames);
for i=1:frames
    P_max = state.O{i}{pos}{1};
    r_bell(i) = norm([P_max(1),P_max(3)]);
    S_bell(i) = pi*r_bell(i)^2;
end
% t = linspace(0,1,frames);
% useLine(cta_in,S_bell)
usePlot(cta_in,S_bell);
xlim([0 pi/2]);
xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
xlabel('\theta_{in}')
ylabel('volume')
ax = gca;
ax.FontSize = 14;
end

