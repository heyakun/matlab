function [v] = calcVolume(h,r,R)
v = 1/3*pi*h*(r^2+R^2+r*R);
end

