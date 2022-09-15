function [model3V] = getVfunc(model3)
%GETVFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
%% m=4
i=1;
for pp = 25:-5:5
    for  mm = 4:4
        for nn= 12:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m4_1(i)=Vi_ratio;
          i=i+1;
        end
    end
end

% i = 1;
% for pp = 5:-5:5
%     for  mm = 4:4
%         for nn= 10:2:28
%           [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
%           model3V{mm}{nn}{20}{pp}=Vi_ratio;
%           m4_2(i)=Vi_ratio;
%           i=i+1;
%         end
%     end
% end
%% m=5
i =1;
for pp = 25:-5:25
    for  mm = 5:5
        for nn= 18:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m5_1(i)= Vi_ratio;
           i=i+1;
        end
    end
end

i=1;
for pp = 20:-5:10
    for  mm = 5:5
        for nn= 16:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m5_2(i)= Vi_ratio;
           i=i+1;
        end
    end
end
i=1;
for pp = 5:-5:5
    for  mm = 5:5
        for nn= 14:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
           m5_3(i)= Vi_ratio;
            i=i+1;
        end
    end
end
%%  m=6
i=1;
for pp = 25:-5:15
    for  mm = 6:6
        for nn= 22:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m6_1(i)= Vi_ratio;
            i=i+1;
        end
    end
end
i=1;
for pp = 10:-5:10
    for  mm = 6:6
        for nn= 20:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m6_2(i)= Vi_ratio;
            i=i+1;
        end
    end
end
i=1;
for pp = 5:-5:5
    for  mm = 6:6
        for nn= 18:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m6_3(i)= Vi_ratio;
            i=i+1;
        end
    end
end
%% m=7
i=1;
for pp = 25:-5:15
    for  mm = 7:7
        for nn= 24:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m7_1(i)= Vi_ratio;
            i=i+1;
        end
    end
end
i=1;
for pp = 10:-5:5
    for  mm = 7:7
        for nn= 22:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m7_2(i)= Vi_ratio;
            i=i+1;
        end
    end
end


%%
m4 = [m4_1,m4_2];
m5 = [m5_1,m5_2,m5_3];
m6 = [m6_1,m6_2,m6_3];


%% 赋值-
% i= 1;
% for mm = 7:7
%     for nn= 10:2:28
%         for pp = 5:5:25
%            xx(i) = model3V{mm}{nn}{20}{pp};
%            i = i+1;
%         end
%     end
% end
end
