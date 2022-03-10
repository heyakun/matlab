function [B] = point_by_axiosY_array(point,number)
A =cell(1,number);
B =cell(1,number);
A{1}=(point);
for i=2:number
    A{i} =  vpa(r_array(A{i-1},2*pi/number));
end

for i=1:number
    B{i} = A{i}(1:3);
end
