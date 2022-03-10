function [] = drawUnfoldRatio(ratio_Arr,x_lim,x_label)
plot(x_lim,ratio_Arr,'-s','LineWidth',1.2)
grid on 
xlim([min(x_lim) max(x_lim)])
xticks(x_lim)
xlabel(x_label)
ylabel('\delta')
ax = gca;
ax.FontSize = 14;
end

