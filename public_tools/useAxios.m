function [] = useAxios(vector)
    hold on
%     ¡Ÿ ±≤ªª≠
%     axis_x = quiver3(0, 0, 0, 30, 0, 0, 'linewidth', 2, 'color', 'red');
%     axis_y = quiver3(0, 0, 0, 0, 30, 0, 'linewidth', 2, 'color', 'green');
%     axis_z = quiver3(0, 0, 0, 0, 0, 30, 'linewidth', 2, 'color', 'blue');
    set(gca, 'YAxisLocation', 'origin');
    grid on
    axis equal
    axis([-200 200 -250 50 -200 0])
    view(vector)
end

