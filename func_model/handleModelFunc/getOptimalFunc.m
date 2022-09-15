function [Object] = getOptimalFunc(model3)
%GETOPTIMALFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
i=1;
j=1;
for pp = 25:-5:5
    for  mm = 4:4
        for nn= 14:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m4_1max(i)=max(FRatio);
          m4_1min(i)=min(FRatio);
          
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m4_1(i)=Vi_ratio;
          
%           find = 0.33*mm*nn - Vi_ratio*(m4_1max(i)-m4_1min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
          j=j+1;
          i=i+1;
         
        end
    end
end
%% m=5
i =1;
for pp = 25:-5:25
    for  mm = 5:5
        for nn= 20:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m5_1(i)= Vi_ratio;
          
          
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_1max(i)=max(FRatio);
          m5_1min(i)=min(FRatio);
          
%           find = 0.33*mm*nn - Vi_ratio*(m5_1max(i)-m5_1min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
           j=j+1;
       
           i=i+1;
        end
    end
end

i=1;
for pp = 20:-5:10
    for  mm = 5:5
        for nn= 18:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
          m5_2(i)= Vi_ratio;
          
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_2max(i)=max(FRatio);
          m5_2min(i)=min(FRatio);
          
%           find = 0.33*mm*nn - Vi_ratio*(m5_2max(i)-m5_2min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
           j=j+1;
           
           i=i+1;
        end
    end
end
i=1;
for pp = 5:-5:5
    for  mm = 5:5
        for nn= 16:2:28
          [~,~,Vi_ratio] = getEachV_2(model3.state{mm}{nn}{20}{pp});
          model3V{mm}{nn}{20}{pp}=Vi_ratio;
           m5_3(i)= Vi_ratio;
           
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m5_3max(i)=max(FRatio);
          m5_3min(i)=min(FRatio);
          
%           find = 0.33*mm*nn - Vi_ratio*(m5_3max(i)-m5_3min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
           j=j+1;
           
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
          
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_1max(i)=max(FRatio);
          m6_1min(i)=min(FRatio);
          
%           find =0.33*mm*nn - Vi_ratio*(m6_1max(i)-m6_1min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
           j=j+1;
          
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
          
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_2max(i)=max(FRatio);
          m6_2min(i)=min(FRatio);
          
%           find = 0.33*mm*nn - Vi_ratio*(m6_2max(i)-m6_2min(i));
find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
           j=j+1;
          
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
          
          FRatio = getFRatioArr(model3.state{mm}{nn}{20}{pp});
          model3Fratio{mm}{nn}{20}{pp}=FRatio;
          m6_3max(i)=max(FRatio);
          m6_3min(i)=min(FRatio);
          
%           find = 0.33*mm*nn - Vi_ratio*(m6_3max(i)-m6_3min(i));
          find = objectFunc(mm,nn,Vi_ratio,max(FRatio),min(FRatio),i);
          Object.res{j} = [mm,nn,pp];
          Object.val(j) = find;
          j=j+1;
          
            i=i+1;
        end
    end
end
m4 = [m4_1];
m5 = [m5_1,m5_2,m5_3];
m6 = [m6_1,m6_2,m6_3];

end

