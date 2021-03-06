addpath('func_tools')
addpath('public_tools')
addpath('func_model')
addpath('func_draw')
addpath('func_handle')
addpath('func_export')
addpath('func_calc')
global a p n m frames
m = 5;
n = 16;
a = 20;
p = 15;
frames = 10;
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 用于将Cta_in弧度制转角度
cta_in2 = rad2deg( cta_in');
load('data_0221')
state = model.state{5}{16};
%% 创建三因子模型
[model3.state{3}{8}{20}{15},model3.corner{3}{8}{20}{15}] = createModel(3,8,20,15,frames);
[model3.state{3}{8}{20}{15},model3.corner{3}{8}{20}{15}] = createModel(3,8,20,15,frames);

modelState = model3.state{3}{8}{20}{15};
model3 = drawModel(modelState);

%% 创建模型
[state,CornerCell] = createModel(m,n,a,p,frames);
[model.state{3}{9},model.corner{3}{9}] = createModel(3,9,a,p,frames);
[model.state{4}{12},model.corner{4}{12}] = createModel(4,12,a,p,frames);
[model.state{5}{12},model.corner{5}{12}] = createModel(5,12,a,p,frames);
[model.state{6}{13},model.corner{6}{13}] = createModel(6,13,a,p,frames);
[model.state{7}{14},model.corner{7}{14}] = createModel(7,14,a,p,frames);
[model.state{8}{17},model.corner{8}{17}] = createModel(8,17,a,p,frames);

%主要模型（可折展模型）
for m_num = 3: 6
    for n_num = 13:20
        [model.state{m_num}{n_num},model.corner{m_num}{n_num}] = createModel(m_num,n_num,a,p,frames);
    end
end
%补充模型
[model.state{4}{12},model.corner{4}{12}] = createModel(4,12,a,p,frames);
[model.state{4}{11},model.corner{4}{11}] = createModel(4,11,a,p,frames);
[model.state{7}{14},model.corner{7}{14}] = createModel(7,14,a,p,frames);
[model.state{7}{12},model.corner{7}{12}] = createModel(7,12,a,p,frames);
%为探究m一定后，n增加到一定程度，折展性能不会有提高而补充的模型
for n_add=21 :30
    [model.state{5}{n_add},model.corner{5}{n_add}] = createModel(5,n_add,a,p,frames);
end


%发生干涉问题的模型
[model.state{3}{6},model.corner{3}{6}] = createModel(3,6,a,18,frames);
[model.state{3}{8},model.corner{3}{8}] = createModel(3,8,a,p,frames);
[model.state{4}{9},model.corner{4}{9}] = createModel(4,9,a,p,frames);
[model.state{6}{12},model.corner{6}{12}] = createModel(6,12,a,p,frames);
[model.state{7}{12},model.corner{7}{12}] = createModel(7,12,a,p,frames);
[model.state{7}{13},model.corner{7}{13}] = createModel(7,13,a,p,frames);

% 更改参数 p/a 的大小的模型
[model.para{5}{16}{20}{12}] =  createModel(5,16,a,12,frames);
[model.para{5}{16}{20}{13}] =  createModel(5,16,a,13,frames);
[model.para{5}{16}{20}{14}] =  createModel(5,16,a,14,frames);

[model.para{5}{16}{20}{16}] =  createModel(5,16,a,16,frames);
[model.para{5}{16}{20}{17}] =  createModel(5,16,a,17,frames);
[model.para{5}{16}{20}{18}] =  createModel(5,16,a,18,frames);
% 存在真实模型
[realModelState,realModelCorner] = createModel(5,16,40,30,10);
%% 获取全部折痕角
[Angle.Sphere{5}{16},Angle.Adjacent{5}{16}] = getSphereAngleCell(model.state{5}{16},model.corner{5}{16});
[Angle.Sphere{7}{12},Angle.Adjacent{7}{12}] = getSphereAngleCell(model.state{7}{12},model.corner{7}{12});
[Angle.Sphere{7}{14},Angle.Adjacent{7}{14}] = getSphereAngleCell(model.state{7}{14},model.corner{7}{14});
% 示例
export('test','ASpB1712',Angle.Sphere{7}{12}.Bi{1},cta_in,'sovleCorner5_16')
export('test','ASpO1',Angle.Sphere{7}{12}.Oi{2},cta_in,'sovleCorner5_16')

export_AllSphere('712',Angle.Sphere{7}{12},cta_in)
exprot_AllAdjacent('712',Angle.Adjacent{7}{12},cta_in)

export_AllSphere('714',Angle.Sphere{7}{14},cta_in)
exprot_AllAdjacent('714',Angle.Adjacent{7}{14},cta_in)
%% 获取全部体积，特征体积，容积比计算
[Vi,Vi_C,Vi_ratio] = getEachV_2(state);
%导出
export_array('test','Vi',Vi,cta_in,'Vi')
%% 获取全部特征半径
RadiusC{5}{16}=getAllR_ABO_C(state);
%并导出
export_Ri_C('516',RadiusC{5}{16},cta_in)
%% 获取全部特征高度
maxH{5}{16} = getMaxH(state);
export('model516特征高度','sheet1',{maxH{5}{16}},cta_in,'H/a')

%% 获取全部特征
for n_ii = 13:30
    Feature{5}{n_ii} = getAllFeatures(model.state{5}{n_ii}) ;
    exportAllFeatures(['5',num2str(n_ii)],Feature{5}{n_ii},cta_in)
end
% Feature{5}{16} = getAllFeatures(state) ;
% exportAllFeatures('516',Feature{5}{16},cta_in)

%% 多机构 容积比 比较
unfoldRatio = zeros(6,16);
for m_num = 3: 7
    for n_num = 13:16
        [~,~,unfoldRatio(m_num,n_num)]= getEachV_2(model.state{m_num}{n_num});
    end
end
unfoldRatio2 = zeros(18,1);

unfoldRatio_model5 = zeros(1,30);
for x = 13:30
    [~,~,unfoldRatio_model5(x)]= getEachV_2(model.state{5}{x});
end
xlswrite('./exportData/机构-容积比',unfoldRatio_model5(13:30)','sheet1')
%% 获取细度比
FRatio{5}{16} = getFRatioArr(state);
export_array('516细度比','516',FRatio{5}{16},cta_in,'FRatio')

%% 计算线长 变化
S = calcLineLength(realModelState);


%% 拟合细度比 中的r 和 H
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




%% 绘制 折痕转角
drawAllCorner(cta_in,model.corner{4}{11})
%转角 180-处理
res_cell = hanle_pi_corner(model.corner{5}{16});
%导出
export('test','model7_14',res_cell,cta_in,'sovleCorner5_16')
%% 绘制 模型
drawModel(state);
drawModel(model.para{5}{16}{20}{18});
%% 绘制 H/a
[H_a]=draw_each_H(model.state{5}{16},cta_in,'-s');
%% 绘制r_i/a
draw_each_r(state,cta_in,'-*')
P_Oset_radius = draw_each_r(model.state{7}{12},cta_in,'-*');



%% 绘制 V/a^3
V_a3=getEachV(model.state{5}{16});




%% 得到相邻列之间的折痕转角
[res_corner,res_corner_C] =get2PlaneAngleCell(model.state{4}{11});
[res_corner,res_corner_C] =get2PlaneAngleCell(model.state{7}{14});
% 绘制相邻单元转角
drawAllCorner(cta_in,res_corner_C)

%% 得到折展比
unfoldRatio = zeros(6,16);
for m_num = 3: 6
    for n_num = 13:16
        [~,unfoldRatio(m_num,n_num)]= drawVolume(model.state{m_num}{n_num},cta_in,'-^');
    end
end
unfoldRatio2 = zeros(18,1);
for para = 12:18
    if (para==15) 
        continue 
    end
    [~,unfoldRatio2(para)] = drawVolume(model.para{5}{16}{20}{para},cta_in,'-^');
end

%% 导出数据
export_r_i(cta_in,P_Oset_radius)
export("r_i","model7_14_rBi_a",P_Bset_radius_C{7}{14},cta_in,"BRi")
export("r_A_i","model7_14_r_a",P_Aset_radius_C{7}{14},cta_in,"Ari")
export("r_i","model7_12_r_a",P_Oset_radius,cta_in,"Ri")
export("r_i","model7_14_r_a",P_Oset_radius_C,cta_in,"Ri")

export("Corner","sheet1",res_corner_C,cta_in,"Corner712")
export("solveCorner","model712",res_cell,cta_in,"sovleCorner712")

export("test","resAngle4",resAngle4,cta_in,"g")
%% 画轮廓



%% 画细度比
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
cta_in = 9/20*pi-0.4*pi*t;
fineness_v1 = drawFineness(state,cta_in,6,'-o');%O_5
fineness_v2 = drawFineness(state,cta_in,5,'-s');%O_4
fineness_v3 = drawFineness(state,cta_in,4,'-d');%O_3
legend('m=5','m=4','m=3','Location','North')%n = 16
%% 
drawFineness(state,cta_in,6,'-o');
drawFineness(state1,cta_in,6,'-^');
drawFineness(state2,cta_in,6,'-d');
drawFineness(state3,cta_in,6,'-s');
drawFineness(state4,cta_in,6,'-p');
legend('n=16','n=15','n=14','n=13','n=12','Location','North')%n = 16
drawFineness(state4,cta_in,6,'-o');
drawFineness(state4,cta_in,5,'-d');
drawFineness(state4,cta_in,4,'-s');
legend('m=5','m=4','m=3','Location','North')%n = 16

%% 画体积
vol = drawVolume(state,cta_in,'-s');
vol1 = drawVolume(state1,cta_in,'-d');
vol2 = drawVolume(state2,cta_in,'-p');
vol3 = drawVolume(state3,cta_in,'-^');
vol4 = drawVolume(state4,cta_in,'-o');
legend('n=16','n=15','n=14','n=13','n=12')

vol5 = drawVolume(state5,cta_in,'-d');
vol = drawVolume(state,cta_in,'-s');
vol6 = drawVolume(state6,cta_in,'-p');
vol7 = drawVolume(state7,cta_in,'-^');
legend('m=6','m=5','m=4','m=3')
% 折展比
vol_ratio = getUnfoldRatio(vol);
vol_ratio1 = getUnfoldRatio(vol1);
vol_ratio2 = getUnfoldRatio(vol2);
vol_ratio3 = getUnfoldRatio(vol3);
vol_ratio4 = getUnfoldRatio(vol4);
drawUnfoldRatio([vol_ratio4,vol_ratio3,vol_ratio2,vol_ratio1,vol_ratio],[12 13 14 15 16],'n')

vol_ratio5 = getUnfoldRatio(vol5);
vol_ratio6 = getUnfoldRatio(vol6);
vol_ratio7 = getUnfoldRatio(vol7);
drawUnfoldRatio([vol_ratio7,vol_ratio6,vol_ratio,vol_ratio5],[3 4 5 6],'m')

vol9 = drawVolume(state9,cta_in,'-o');
vol_3_12 = drawVolume(state_3_12,cta_in,'-^');

vol_ratio9 = getUnfoldRatio(vol9);
vol_ratio_3_12 = getUnfoldRatio(vol_3_12);
drawUnfoldRatio([vol_ratio4,vol_ratio9,vol_ratio_3_12],[3 4 5])
%% 画 孔口面积
[s_hole,rhole]=drawShole(state,cta_in);
[s_hole1,rhole1]=drawShole(state1,cta_in);
[s_hole2,rhole2]=drawShole(state2,cta_in);
[s_hole3,rhole3]=drawShole(state3,cta_in);
[s_hole4,rhole4]=drawShole(state4,cta_in);

[s_hole9] = drawShole(state9,cta_in);
[s_hole_3_12] = drawShole(state_3_12,cta_in);
%% 确定最大半径的索引 和 值
[m_i,r_arr] = getMaxR(state);
[m_i1,r_arr1] = getMaxR(state1);
[m_i2,r_arr2] = getMaxR(state2);
[m_i3,r_arr3] = getMaxR(state3);
[m_i4,r_arr4] = getMaxR(state4);
plot(r_arr)
hold on
plot(r_arr1)
hold on 

%%  画膜孔比
for k = 1:4
    plot([16 15 14 13 12],[s_hole(k)/s_hole(end-k+1),s_hole1(k)/s_hole1(end-k+1),s_hole2(k)/s_hole2(end-k+1),s_hole3(k)/s_hole3(end-k+1),s_hole4(k)/s_hole4(end-k+1)],'-s')
    hold on 
end
for k = 1:4
    plot([16 15 14 13 12],[s_hole(3)/s_hole(end-k+1),s_hole1(3)/s_hole1(end-k+1),s_hole2(3)/s_hole2(end-k+1),s_hole3(3)/s_hole3(end-k+1),s_hole4(3)/s_hole4(end-k+1)],'-s')
    hold on 
end
xlabel('n')
xlim([12 16])
xticks([12 13 14  15 16])
ylabel('Rv')
legend('100%','80%','70%','60%','Location','North')
for k = 1:4
    plot([5 4 3],[s_hole(k)/s_hole(end-k+1),s_hole9(k)/s_hole9(end-k+1),s_hole_3_12(k)/s_hole_3_12(end-k+1)],'-s')
    hold on 
end
xlabel('m')
xlim([3 5])
xticks([3 4 5])
ylabel('Rv')
legend('100%','80%','70%','60%','Location','North')
