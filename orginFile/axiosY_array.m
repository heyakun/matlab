function [B] = axiosY_array(OriginM,number)
A =cell(1,number);
B =cell(1,number);
A{1}=(OriginM);
for i=2:number
    A{i} =  r_array(A{i-1},2*pi/number);
end

for i=1:number
    B{i} = A{i}(1:3,4);
end
