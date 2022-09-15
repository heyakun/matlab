addpath(genpath('func_tools'))
addpath(genpath('public_tools'))
addpath(genpath('func_model'))
addpath('func_draw')
addpath('func_handle')
addpath('func_export')
addpath(genpath('func_calc'))
addpath(genpath('func_solveEq'))
addpath(genpath('Dynamic'))
addpath(genpath('func_auto'))
global a p n m frames
m = 5;
n = 16;
a = 20;
p = 15;
frames = 10;
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
cta_in = 9/20*pi-0.4*pi*t;
%cta_in2 用于将Cta_in弧度制转角度
cta_in2 = rad2deg(cta_in');
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
[model.state{7}{12},model.corner{7}{12}] = createModel(7,12,a,p,frames);
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
%% 拟合细度比
fineness = [2.67607
1.8591
1.43589
1.16696
0.97264
0.81915
0.69014
0.57709
0.47537
0.38236]; 
theta_in =[81
73
65
57
49
41
33
25
17
9];
% [~,func_finess_sym] =   getFitFunc2(theta_in,fineness,2);
% func_finess_sym = 0.00048935*x^2 - 0.016612*x + 0.60369;
[FR_by_thetaIn_func,func_finess_sym] =   getFitFunc2(theta_in,fineness,4);
%% 拟合特征体积
V_a3 = [16.00275
25.263875
35.169375
44.8375
53.586
60.92775
66.554125
70.2985
72.094375
71.9235
];
theta_in =[81
73
65
57
49
41
33
25
17
9];
[~,func_finess_sym] =   getFitFunc2(theta_in,V_a3,3);
% 三次拟合
% 0.00011298*x^3 - 0.025635*x^2 + 0.69725*x + 67.387 
%% 绘制 折痕转角
drawAllCorner(cta_in,model.corner{4}{11})
%转角 180-处理
res_cell = hanle_pi_corner(model.corner{5}{16});
%导出
export('test','model7_14',res_cell,cta_in,'sovleCorner5_16')
%% 绘制 模型
drawModel(model.state{7}{12});
drawModel(model.state{7}{14});
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
%% 解方程
syms x
f_fit = 5.5354e-9*x^5 - 9.8595e-7*x^4 + 0.000067717*x^3 - 0.0020577*x^2 + 0.039223*x + 0.15106;
f1 = f_fit-1.54;
f1 = matlabFunction(f1);
res1 = fsolve(f1,45);
res1
%% 20帧序列
xx = [  89.100000000000009
  84.457894736842121
  79.815789473684220
  75.173684210526318
  70.531578947368416
  65.889473684210529
  61.247368421052634
  56.605263157894733
  51.963157894736845
  47.321052631578944
  42.678947368421049
  38.036842105263155
  33.394736842105260
  28.752631578947362
  24.110526315789471
  19.468421052631577
  14.826315789473686
  10.184210526315780
   5.542105263157888
   0.900000000000000]
%% 阶段1 收集θp的值：执行部件的转角范围(待抽离成函数)
%收集A（1,0）的变化的全部集合
%向量1：O(1,0)和O(1,n)的中点到0,0,0的向量(使用y[0,1,0]作为Y1)
%向量2：O(1,0)和O(1,n)的中点到A(1,0)的向量
%旋转轴：（1,0,0）
%求解公式
%Y2=  Y1*cosθ+(A×Y1)sinθ+A(A?Y2)(1-cosθ)

%获取O中点和向量1
O_1_0 = state.O{1}{1}{1};
O_1_n = state.O{1}{1}{n};
O_c = [0;0;O_1_0(3)];
%Y1 = -O_c/norm(O_c);
Y1 = [0;1;0];
%旋转轴
Axis = [1;0;0]; 
%获取A系列的点和向量2:Y2_i
A_out = cell(1,frames);
Y2_i = cell(1,frames);
res_p = zeros(frames,1);
for Ai=1:frames
    A_out{Ai} = state.A{Ai}{1}{1};
    Y2_i{Ai} = (A_out{Ai}-O_c)/norm(A_out{Ai}-O_c);
end
%% 阶段二：求θp并且拟合θp关于θin的表达式，
Ai=1;
theta_p=zeros(frames,1);
for Ai=1:frames
    theta_p(Ai)= get2PlaneCorner(Y1,Y2_i{Ai},Axis);
end
[theta_p_func,theta_p_sym] =getFitFunc2(cta_in2,theta_p,1);
%% 阶段三：确定L和h,和θp的范围，确定线长的范围
%对于oblate型：θp范围[93.98 -> 48.58]
%Slen_o的实例结果[65.813 , 37.024]
theta_p_o_b =  theta_p_func(49);
theta_p_o_e =  theta_p_func(9);
%S^2 = L^2+ h^2+2*L*h*cosd(θp)
L = 45;
h = 45;
S_o_b = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_b));
S_o_e = sqrt(L^2+ h^2-2*L*h*cosd(theta_p_o_e));
Slen_o = [S_o_b,S_o_e];
%% 阶段三： 已知tr ,tc 计算 kr, kc ，拿到线长S在0~tr tr~ T序列
t_r = 2.4;
t_c = 1.6;
% 序列写在函数外
tr = (0:0.1:t_r)';
tc = (t_r:0.1:t_r+t_c)';

[S_t_r,S_t_c] = calc_S_by_t(Slen_o,t_r,t_c);

%% 阶段四： 已知线长S(t)的序列,反解θp序列->θin->FR
[theta_p_r] = solve_St_to_thetaP(S_t_r,L,h);
[theta_p_c] = solve_St_to_thetaP(S_t_c,L,h);

%得到θp 反解θin
[theta_in_r] = solve_ThetaP_to_in(theta_p_r,theta_p_sym);
[theta_in_c] = solve_ThetaP_to_in(theta_p_c,theta_p_sym);
% θin 对 t 二次拟合一次 得到θin 对 t sym表达式
[ ~,theta_in_by_tr_sym] = getFitFunc2(tr,theta_in_r,2);
[ ~,theta_in_by_tc_sym] = getFitFunc2(tc,theta_in_c,2);

%得到θin 反解FR
[res_FR_r] = solve_ThetaIn_to_FR(theta_in_r,FR_by_thetaIn_func);
[res_FR_c] = solve_ThetaIn_to_FR(theta_in_c,FR_by_thetaIn_func);
%% 阶段5： 可以绘制 FR 在 一个周期的变化曲线


