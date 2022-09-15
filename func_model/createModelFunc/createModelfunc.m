function [model3] = createModelfunc(model3)
%CREATEMODELFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
frames=10;

for p = 5:5:30
    for nn=12:2:28
        for mm = 7: 7
%            if(p == 0.25)
%                if(mm==5)
%                    if(nn>=14)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                elseif(mm==6)
%                    if(nn>=18)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                end
%            elseif(p==0.5)
%                if(mm==5)
%                    if(nn>=16)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                elseif(mm==6)
%                    if(nn>=20)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                end
%             elseif(p==0.75)
%                if(mm==5)
%                    if(nn>=16)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                elseif(mm==6)
%                    if(nn>=22)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                end
%             elseif(p==1.0)
%                if(mm==5)
%                    if(nn>=16)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                elseif(mm==6)
%                    if(nn>=22)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                end
%              elseif(p==1.25)
%                if(mm==5)
%                    if(nn>=16)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                elseif(mm==6)
%                    if(nn>=22)
%                        [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
%                    end
%                end
%            end
            
            [model3.state{mm}{nn}{20}{p},model3.corner{mm}{nn}{20}{p}] = createModel(mm,nn,20,p,frames);
        end
    end
end

% 补充模型：发生干涉
%%
drawModel(model3.state{7}{22}{20}{5})
%%
% m6_16 = createModel(6,12,20,15,frames);
[modelEx.state{6}{10}{15},modelEx.corner{6}{10}{15}] = createModel(6,10,20,15,frames);
[modelEx.state{6}{10}{5},modelEx.corner{6}{10}{5}] = createModel(6,10,20,5,frames);
drawModel(m6_16)
% 
%% 阿斯蒂芬
% for pp = 25:-5:5
%    drawModel(model3.state{6}{18}{20}{5})
% end
%%
[modelEx.state{6}{10}{5},modelEx.corner{6}{10}{5}] = createModel(6,10,20,5,frames);
[Angle.Sphere{6}{10}{5},Angle.Adjacent{6}{10}{5}] = getSphereAngleCell(modelEx.state{6}{10}{5},modelEx.corner{6}{10}{5});
export_AllSphere('EX6_10_5',Angle.Sphere{6}{10}{5},cta_in)
exprot_AllAdjacent('EX6_10_5',Angle.Adjacent{6}{10}{5},cta_in)
%%
ex_n = 10;
ex_p = 15;
[modelEx.state{6}{ex_n}{ex_p},modelEx.corner{6}{ex_n}{ex_p }] = createModel(6,ex_n,20,ex_p ,frames);
[Angle.Sphere{6}{ex_n}{ex_p},Angle.Adjacent{6}{ex_n}{ex_p }] = getSphereAngleCell(modelEx.state{6}{ex_n}{ex_p },modelEx.corner{6}{ex_n}{ex_p });
export_AllSphere(['EX6_',num2str(ex_n),'_',num2str(ex_p)],Angle.Sphere{6}{ex_n}{ex_p },cta_in)
exprot_AllAdjacent(['EX6_',num2str(ex_n),'_',num2str(ex_p)],Angle.Adjacent{6}{ex_n}{ex_p },cta_in)
%%
ex_n = 12;
ex_p = 25;
[Angle.Sphere{6}{ex_n}{ex_p},Angle.Adjacent{6}{ex_n}{ex_p}] = getSphereAngleCell(model3.state{6}{ex_n}{20}{ex_p},model3.corner{6}{ex_n}{20}{ex_p});
export_AllSphere(['EX6_',num2str(ex_n),'_',num2str(ex_p)],Angle.Sphere{6}{ex_n}{ex_p},cta_in)
exprot_AllAdjacent(['EX6_',num2str(ex_n),'_',num2str(ex_p)],Angle.Adjacent{6}{ex_n}{ex_p},cta_in)

%% 碰撞1
ex_n = 10;
ex_p = 15;
RadiusC{6}{ex_n}{ex_p}=getAllR_ABO_C(modelEx.state{6}{ex_n}{ex_p});
export_Ri_C(['EX6_',num2str(ex_n),'_',num2str(ex_p)],RadiusC{6}{ex_n}{ex_p},cta_in)
%% 碰撞2
ex_n = 10;
ex_p = 5;
RadiusC{6}{ex_n}{ex_p}=getAllR_ABO_C(modelEx.state{6}{ex_n}{ex_p});
export_Ri_C(['EX6_',num2str(ex_n),'_',num2str(ex_p)],RadiusC{6}{ex_n}{ex_p},cta_in)
end

