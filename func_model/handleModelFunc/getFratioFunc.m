function [model3Fratio,F_B] = getFratioFunc(model3)
%GETFRATIOFUNC 此处显示有关此函数的摘要
%   此处显示详细说明

%% m=4
i=1;
for pp = 25:-5:5
    for  mm = 4:4
        for nn= 12:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m4_1max(i)=max(FRatio);
          m4_1min(i)=min(FRatio);
          i=i+1;
        end
    end
end

%% m=5
i =1;
for pp = 25:-5:25
    for  mm = 5:5
        for nn= 18:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_1max(i)=max(FRatio);
          m5_1min(i)=min(FRatio);
          i=i+1;
        end
    end
end
%%
i=1;
for pp = 20:-5:10
    for  mm = 5:5
        for nn= 16:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_2max(i)=max(FRatio);
          m5_2min(i)=min(FRatio);
          i=i+1;
        end
    end
end
%%
i=1;
for pp = 5:-5:5
    for  mm = 5:5
        for nn= 14:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_3max(i)=max(FRatio);
          m5_3min(i)=min(FRatio);
          i=i+1;
        end
    end
end
%% m=6
i=1;
for pp = 25:-5:15
    for  mm = 6:6
        for nn= 22:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_1max(i)=max(FRatio);
          m6_1min(i)=min(FRatio);
          i=i+1;
        end
    end
end
i=1;
for pp = 10:-5:10
    for  mm = 6:6
        for nn= 20:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_2max(i)=max(FRatio);
          m6_2min(i)=min(FRatio);
          i=i+1;
        end
    end
end
i=1;
for pp = 5:-5:5
    for  mm = 6:6
        for nn= 18:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_3max(i)=max(FRatio);
          m6_3min(i)=min(FRatio);
          i=i+1;
        end
    end
end
%% m=7
i=1;
for pp = 25:-5:15
    for  mm = 7:7
        for nn= 24:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m7_1max(i)=max(FRatio);
          m7_1min(i)=min(FRatio);
          i=i+1;
        end
    end
end
i=1;
for pp = 10:-5:5
    for  mm = 7:7
        for nn= 22:2:28
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m7_2max(i)=max(FRatio);
          m7_2min(i)=min(FRatio);
          i=i+1;
        end
    end
end
abc=1;
%%
m4_max = [m4_1max];
m4_min = [m4_1min];
m5_max = [m5_1max,m5_2max,m5_3max];
m5_min = [m5_1min,m5_2min,m5_3min];
m6_max = [m6_1max,m6_2max,m6_3max];
m6_min = [m6_1min,m6_2min,m6_3min];
m7_max = [m7_1max,m7_2max];
m7_min = [m7_1min,m7_2min];
F_B.m4=[m4_max;m4_min];
F_B.m5=[m5_max;m5_min];
F_B.m6=[m6_max;m6_min];
F_B.m7 = [m7_max;m7_min];
end

