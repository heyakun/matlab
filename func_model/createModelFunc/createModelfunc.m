function [model3] = createModelfunc()
%CREATEMODELFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
frames=10;

for p = 5:5:25
    for nn=10:15
        [model3.state{3}{nn}{20}{p},model3.corner{3}{nn}{20}{p}] = createModel(3,nn,20,p,frames);
    end
end
            

% for pp = 5:5:25
%    drawModel(model3.state{3}{9}{20}{pp})%
% end

end

