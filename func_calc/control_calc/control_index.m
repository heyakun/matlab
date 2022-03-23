%%% 拟合细度比 中的r 和 H
maxH = getMaxH(state);
ROi = getEachR(state);
H_o5 = getH_IndexOf(state,5);
[~,func_maxH_sym] = getFitFunc2(cta_in2,maxH,2);
func_ROi_sym = cell(6,1);
%% 拟合六条r
for roi = 1:6
    [~,func_ROi_sym{roi}] = getFitFunc2(cta_in2',ROi{roi},2);
end
%%
[~,func_ROi_6_sym] = getFitFunc2(cta_in2',ROi{6},2);
[~,func_H_o5_sym] =   getFitFunc2(cta_in2',H_o5,2);