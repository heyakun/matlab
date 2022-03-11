function [Vi,Vi_C] = getEachV_2(state)
%GETEACHV 此处显示有关此函数的摘要
%   此处显示详细说明
a= 20;
ri_cell = getEachR(state);
Hi_cell = getEachH(state);
m = length(state.O{1})-2;
frames = length(state.O);
Vi = zeros(1,frames);
for fra_num =1 : frames
    vi = 0;
    for mm = 1:m 
        r_up = ri_cell{mm}(fra_num);
        r_down = ri_cell{mm+1}(fra_num);
        h(1) = Hi_cell{mm}(fra_num);
        vi =vi+ 1/3 * pi*h(1)*(r_up^2+r_down^2+r_up*r_down);
    end 
    Vi(fra_num) = vpa(vi,5);
    
end
Vi_C = Vi/a^3;

end

