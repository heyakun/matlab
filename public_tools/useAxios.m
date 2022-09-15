function [] = useAxios(vector)
    hold on
%     临时不画
%     axis_x = quiver3(0, 0, 0, 30, 0, 0, 'linewidth', 2, 'color', 'red');
%     axis_y = quiver3(0, 0, 0, 0, 30, 0, 'linewidth', 2, 'color', 'green');
%     axis_z = quiver3(0, 0, 0, 0, 0, 30, 'linewidth', 2, 'color', 'blue');
    set(gca, 'YAxisLocation', 'origin');
%     grid on
    axis equal
%   显示范围 [x_min x_max y_min y_max z_min z_max]

    axis([-200 200 -250 250 -200 0])%显示剖面图
%     axis([-200 200 -250 250 -200 200])%显示完整视图
    view(vector)
end

