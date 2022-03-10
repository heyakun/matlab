function [] = drawOutline(state)
P_Oset=cell(1,length(state.O{1}));
frames = length(state.O);
for num = 1:frames
    for cur_pos = 1:length(state.O{1})
        P_Oset{cur_pos} = state.O{num}{cur_pos}{1};
    end
x = zeros(1,length(state.O{num}));
y = zeros(1,length(state.O{num}));
for i = 1:length(state.O{1})
    x(i) = double(norm([P_Oset{i}(1),P_Oset{i}(3)]));
    y(i) = double(P_Oset{i}(2));
end
clf
useAxios([0,-0,1])
axis([-100 100 -150 50 -100 100])
useLine(x,y);
useLine(-x,y);
for j=1:length(state.O{1})
  useCircle(x(j),y(j))
end
pause(0.1)
end
end

