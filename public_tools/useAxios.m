function [] = useAxios(vector)
    hold on
%     ��ʱ����
%     axis_x = quiver3(0, 0, 0, 30, 0, 0, 'linewidth', 2, 'color', 'red');
%     axis_y = quiver3(0, 0, 0, 0, 30, 0, 'linewidth', 2, 'color', 'green');
%     axis_z = quiver3(0, 0, 0, 0, 0, 30, 'linewidth', 2, 'color', 'blue');
    set(gca, 'YAxisLocation', 'origin');
%     grid on
    axis equal
%   ��ʾ��Χ [x_min x_max y_min y_max z_min z_max]

    axis([-200 200 -250 250 -200 0])%��ʾ����ͼ
%     axis([-200 200 -250 250 -200 200])%��ʾ������ͼ
    view(vector)
end

