function [] = useLine(x,y)
x = [x NaN];
y = [y 0];
y(end) = NaN;
c = y;
grid on
patch(x,y,c,'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
end

