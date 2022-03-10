function [V_arr_C] = getEachV(state)
%GETEACHV 此处显示有关此函数的摘要
%   此处显示详细说明
%% 包络容积
frames = length(state.O);
V_arr = zeros(1,frames);
P_Oset = cell(1,length(state.O{1}));
for num=1:frames
    for cur_pos = 1:length(state.O{1})
        P_Oset{cur_pos} = state.O{num}{cur_pos}{1};
    end
    x = zeros(1,length(state.O{num}));
    y = zeros(1,length(state.O{num}));
    for j = 1:length(state.O{1})
        x(j) = double(norm([P_Oset{j}(1),P_Oset{j}(3)]));
        y(j) = double(P_Oset{j}(2));
    end
    
    V = 0;
    for k=1:length(y)-1
        v = 1/3*pi*abs(y(k)-y(k+1))*(x(k)^2+x(k+1)^2+x(k)*x(k+1));
        V = V+v;
    end
    V_arr(num)=V;
end
a= 20;
% t = linspace(0,1,frames);
% useLine(cta_in,V_arr)
V_arr_C =(   V_arr/a^3  )';
end

