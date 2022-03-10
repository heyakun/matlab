function [] = drawCorner(cta_in,CornerArr)

usePlot(cta_in,CornerArr,'-*');
xlim([0 pi/2]);
xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
xlabel('\theta_{in}')
ylabel('volume')
ax = gca;
ax.FontSize = 14;
end

