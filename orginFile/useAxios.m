function [] = useAxios(vector)
hold on
axis_x = quiver3(0, 0, 0, 0, 0, 0, 'linewidth', 1, 'color', 'red');
axis_y = quiver3(0, 0, 0, 0, 1, 0, 'linewidth', 1, 'color', 'green');
axis_z = quiver3(0, 0, 0, 0, 0, 0, 'linewidth', 1, 'color', 'blue');
set(gca, 'YAxisLocation', 'origin');
% grid on
axis equal
axis([-100 100 -150 50 -100 100])
view(vector)
end

