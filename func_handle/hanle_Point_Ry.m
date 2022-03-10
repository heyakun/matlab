function [res_point] = hanle_Point_Ry(point,n)
angle = -pi/n;
Ry = [cos(angle),0,sin(angle);
     0  1 0;
     -sin(angle),0,cos(angle)];
 res_point = Ry*point;
 
end

