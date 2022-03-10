function [max_index_arr,res_X] = getMaxR(state)
frames = length(state.O);
% V_arr = zeros(1,frames);
P_Oset = cell(1,length(state.O{1}));
max_x_arr = zeros(1,frames);
max_index_arr = zeros(1,length(state.O{1}));
X = zeros(length(state.O{1}),frames);
for num=1:frames
    for cur_pos = 1:length(state.O{1})
        P_Oset{cur_pos} = state.O{num}{cur_pos}{1};
    end
    x = zeros(1,length(state.O{num}));
%     y = zeros(1,length(state.O{num}));
    for j = 1:length(state.O{1})
        x(j) = double(norm([P_Oset{j}(1),P_Oset{j}(3)]));
        X(j,num)=x(j);
%         y(j) = double(P_Oset{j}(2));
    end
    
%     V = 0;
%     for k=1:6
%         v = 1/3*pi*abs(y(k)-y(k+1))*(x(k)^2+x(k+1)^2+x(k)*x(k+1));
%         V = V+v;
%     end
%     V_arr(num)=V;
    max_x_arr(num) = max(x);
    for i = 1:length(x)
        if x(i) == max(x)
            max_index_arr(num) = i;
            break
        end
    end  
end
res_X =  X(max_index_arr(end),:);

% max_x = max(x);
% for i = 1:length(x)
%     if x(i) == max_x
%         max_index = i;
%         break
%     end
% end
        

% t = linspace(0,1,frames);
% useLine(cta_in,V_arr)
% hold on 
% [V_func] = getFitFunc([0 2],V_arr);
% t = linspace(0,2,frames);
% plot(t,V_func(t))
% xlim([0 pi/2]);
% xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
% xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
% xlabel('\theta_{in}')
% ylabel('volume')
% ax = gca;
% ax.FontSize = 14;
end

