%%
%起始点
%dev05实现patch绘图功能
%dev06 收集全部O_s点，绘制包络线
%dev07 将每个方程的解（折痕转角收集起来）
digits(5)
p = 15;
a = 20;
n = 16;
frames = 20;

Corner = cell(1,frames);

for index=1:frames
syms Cin pi x
Cin = linspace(0.9*pi/2,0.1*pi/2,frames);
Cta = Cin(index) + pi/2;


%求O0 (与p直接相关)
O0M = R('y', pi / n) * T('z', p);
O0 = O0M(1:4,4);    


%求F1(与输入直接相关)
H_B1M = O0M * R('x', Cta) * T('z', -a);
B1 = H_B1M*[0 0 0 1]';
%求A1
syms H_Cta_12 H_Cta_23 H_Cta_34
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_B1M * H_Q12;
A1 = A1M*[0 0 a 1]';

f = matlabFunction(A1(1));
H_Cta_12 = fsolve(f,1.57);
Corner{index}(1) = H_Cta_12;
%%%%%%%%%%%%%%%%%%%%%%
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_B1M * H_Q12;
A1 = A1M*[0 0 a 1]';

H_Q23 = R('z',-H_Cta_23)*R('x',pi/4);
O1M = A1M*H_Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';

O1_vpa = vpa(O1);
f =matlabFunction(O1_vpa(1));
H_Cta_23 = fsolve(f,1.58);
Corner{index}(2) = H_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_Q23 = R('z',-H_Cta_23)*R('x',pi/4);
O1M = A1M*H_Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%

H_Q34 = R('z',H_Cta_34)*R('x',pi/4);
B2M = O1M*H_Q34;
B2 = B2M*[0 0 2*a 1]';

f =matlabFunction(B2(3)*tan(pi/n)-B2(1));
H_Cta_34 = fsolve(f,1.57);
Corner{index}(3) = H_Cta_34;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_Q34 = R('z',H_Cta_34)*R('x',pi/4);
B2M = O1M*H_Q34;
B2 = B2M*[0 0 2*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms I_Cta_23 I_Cta_34 
I_E1M = B2M*T('z',2*a)*R('x',pi);
I_O1M = I_E1M*R('x',pi/4);

I_Q23 = R('z',I_Cta_23)*R('x',pi/4);
D1M = I_O1M*I_Q23;
D1 = D1M*[0 0 a 1]';

f =matlabFunction(D1(1));
I_Cta_23 = fsolve(f,1.57);
Corner{index}(4) = I_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I_Q23 = R('z',I_Cta_23)*R('x',pi/4);
D1M = I_O1M*I_Q23;
D1 = D1M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%

I_Q34 = R('z',-I_Cta_34)*R('x',pi/2);
O2M = D1M*I_Q34;
O2 = O2M*[0 0 a 1]';

f = matlabFunction(O2(3)*tan(pi/n)-O2(1));
I_Cta_34 = fsolve(f,1.57);
Corner{index}(5) = I_Cta_34;
%%%%%%%%%%%%%%%%%%%%%%%%%%
I_Q34 = R('z',-I_Cta_34)*R('x',pi/2);
O2M = D1M*I_Q34;
O2 = O2M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%

syms J_Cta_23 J_Cta_34
J_O2M = O2M*T('z',a)*R('x',pi);
J_B2M = J_O2M*R('x',pi/4);

J_Q23 = R('z',J_Cta_23)*R('x',pi/2);
C2M = J_B2M*J_Q23;
C2 = C2M*[0 0 sqrt(2)*a 1]';

f = matlabFunction(C2(1));
J_Cta_23 = fsolve(f,1.57);
Corner{index}(6) = J_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%
J_Q23 = R('z',J_Cta_23)*R('x',pi/2);
C2M = J_B2M*J_Q23;
C2 = C2M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J_Q34 = R('z',J_Cta_34)*R('x',pi/4);
D2M = C2M*J_Q34;
D2 = D2M*[0 0 a 1]';

f = matlabFunction(D2(3)*tan(pi/n)-D2(1));
J_Cta_34 = fsolve(f,1.57);
Corner{index}(7) = J_Cta_34;
J_Q34 = R('z',J_Cta_34)*R('x',pi/4);
D2M = C2M*J_Q34;
D2 = D2M*[0 0 a 1]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms  K_Cta_23 K_Cta_34
K_F3M = D2M*T('z',a)*R('x',pi);
K_A3M = K_F3M*R('x',pi/2);

K_Q23 =  R('z',-K_Cta_23)*R('x',pi/4);
O3M = K_A3M*K_Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';
O3_vpa = vpa(O3);

f = matlabFunction(O3_vpa(1));
K_Cta_23 = fsolve(f,1.57);
Corner{index}(8) = K_Cta_23;
K_Q23 =  R('z',-K_Cta_23)*R('x',pi/4);
O3M = K_A3M*K_Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K_Q34 = R('z',K_Cta_34)*R('x',pi/4);
E3M = O3M*K_Q34;
E3 = E3M*[0 0 2*a 1]';

E3_vpa = vpa(E3);

f =matlabFunction(E3_vpa(3)*tan(pi/n)-E3_vpa(1));
K_Cta_34 = fsolve(f,1.57);
Corner{index}(9) = K_Cta_34;
K_Q34 = R('z',K_Cta_34)*R('x',pi/4);
E3M = O3M*K_Q34;
E3 = E3M*[0 0 2*a 1]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms L_Cta_23 L_Cta_34 
L_E3M = E3M*T('z',2*a)*R('x',pi);
L_O3M = L_E3M*R('x',pi/4);

L_Q23 = R('z',L_Cta_23)*R('x',pi/4);
D3M = L_O3M*L_Q23;
D3 = D3M*[0 0 a 1]';
D3_vpa = vpa(D3);
f =matlabFunction(D3_vpa(1));
L_Cta_23 = fsolve(f,1.57);
Corner{index}(10) = L_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_Q23 = R('z',L_Cta_23)*R('x',pi/4);
D3M = L_O3M*L_Q23;
D3 = D3M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%

L_Q34 = R('z',-L_Cta_34)*R('x',pi/2);
O3M = D3M*L_Q34;
O4 = O3M*[0 0 a 1]';
O4_vpa = vpa(O4);
f = matlabFunction(O4_vpa(3)*tan(pi/n)-O4_vpa(1));
L_Cta_34 = fsolve(f,1.57);
Corner{index}(11) = L_Cta_34;
%%%%%%%%%%%%%%%%%%%%%%%%%%
L_Q34 = R('z',-L_Cta_34)*R('x',pi/2);
O4M = D3M*L_Q34;
O4 = O4M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms N_Cta_23 N_Cta_34
N_O4M = O4M*T('z',a)*R('x',pi);
N_D3M = N_O4M*R('x',pi/4);

N_Q23 = R('z',N_Cta_23)*R('x',pi/2);
C4M = N_D3M*N_Q23;
C4 = C4M*[0 0 sqrt(2)*a 1]';
C4_vpa = vpa(C4);
f = matlabFunction(C4_vpa(1));
N_Cta_23 = fsolve(f,1.57);
Corner{index}(12) = N_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%
N_Q23 = R('z',N_Cta_23)*R('x',pi/2);
C4M = N_D3M*N_Q23;
C4 = C4M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%C4

N_Q34 = R('z',N_Cta_34)*R('x',pi/4);
D4M = C4M*N_Q34;
D4 = D4M*[0 0 a 1]';
D4_vpa = vpa(D4);
f = matlabFunction(D4(3)*tan(pi/n)-D4(1));
N_Cta_34 = fsolve(f,1.57);
Corner{index}(13) = N_Cta_34;
N_Q34 = R('z',N_Cta_34)*R('x',pi/4);
D4M = C4M*N_Q34;
D4 = D4M*[0 0 a 1]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms  P_Cta_23 P_Cta_34
P_F4M = D4M*T('z',a)*R('x',pi);
P_C4M = P_F4M*R('x',pi/2);

P_Q23 =  R('z',-P_Cta_23)*R('x',pi/4);
O5M = P_C4M*P_Q23;
O5 = O5M*[0 0 sqrt(2)*a 1]';

O5_vpa = vpa(O5);
f = matlabFunction(O5_vpa(1));
P_Cta_23 = fsolve(f,1.57);
Corner{index}(14) = P_Cta_23;
P_Q23 =  R('z',-P_Cta_23)*R('x',pi/4);
O5M = P_C4M*P_Q23;
O5 = O5M*[0 0 sqrt(2)*a 1]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_Q34 = R('z',P_Cta_34)*R('x',pi/4);
E5M = O5M*P_Q34;
E5 = E5M*[0 0 2*a 1]';

E5_vpa = vpa(E5);

f =matlabFunction(E5_vpa(3)*tan(pi/n)-E5_vpa(1));
P_Cta_34 = fsolve(f,1.57);
Corner{index}(15) = P_Cta_34;
P_Q34 = R('z',P_Cta_34)*R('x',pi/4);
E5M = O5M*P_Q34;
E5 = E5M*[0 0 2*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms S_Cta_23 S_Cta_34 
S_E5M = E5M*T('z',2*a)*R('x',pi);
S_O5M = S_E5M*R('x',pi/4);

S_Q23 = R('z',S_Cta_23)*R('x',pi/4);
D5M = S_O5M*S_Q23;
D5 = D5M*[0 0 a 1]';
D5_vpa = vpa(D5);
f =matlabFunction(D5_vpa(1));
S_Cta_23 = fsolve(f,1.57);
Corner{index}(16) = S_Cta_23;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S_Q23 = R('z',S_Cta_23)*R('x',pi/4);
D5M = S_O5M*S_Q23;
D5 = D5M*[0 0 a 1]';
%%%%%%%%%%%%%%5层 %%%%%%%%%%%%%%%%
S_Q34 = R('z',-S_Cta_34)*R('x',pi/2);
O6M = D5M*S_Q34;
O6 = O6M*[0 0 a 1]';
O6_vpa = vpa(O6);
f = matlabFunction(O6_vpa(3)*tan(pi/n)-O6_vpa(1));
S_Cta_34 = fsolve(f,1.57);
Corner{index}(17) = S_Cta_34;
%%%%%%%%%%%%%%%%%%%%%%%%%%
S_Q34 = R('z',-S_Cta_34)*R('x',pi/2);
O6M = D5M*S_Q34;
O6 = O6M*[0 0 a 1]';

%全部阵列
O0_s = point_by_axiosY_array(O0,n);
B1_s = point_by_axiosY_array(B1,n);
A1_s = point_by_axiosY_array(A1,n);
O1_s = point_by_axiosY_array(O1,n);
B2_s = point_by_axiosY_array(B2,n);
D1_s = point_by_axiosY_array(D1,n);
O2_s = point_by_axiosY_array(O2,n);
C2_s = point_by_axiosY_array(C2,n);
D2_s = point_by_axiosY_array(D2,n);
O3_s = point_by_axiosY_array(O3,n);
E3_s = point_by_axiosY_array(E3,n);
D3_s = point_by_axiosY_array(D3,n);
O4_s = point_by_axiosY_array(O4,n);
C4_s = point_by_axiosY_array(C4,n);
D4_s = point_by_axiosY_array(D4,n);
O5_s = point_by_axiosY_array(O5,n);
E5_s = point_by_axiosY_array(E5,n);
D5_s = point_by_axiosY_array(D5,n);
O6_s = point_by_axiosY_array(O6,n);

state.O0_s{index}=O0_s;
state.B1_s{index}=B1_s;
state.A1_s{index}=A1_s;
state.O1_s{index}=O1_s;
state.B2_s{index}=B2_s;
state.D1_s{index}=D1_s;
state.O2_s{index}=O2_s;
state.C2_s{index}=C2_s;
state.D2_s{index}=D2_s;
state.O3_s{index}=O3_s;
state.E3_s{index}=E3_s;
state.D3_s{index}=D3_s;
state.O4_s{index}=O4_s;
state.C4_s{index}=C4_s;
state.D4_s{index}=D4_s;
state.O5_s{index}=O5_s;
state.E5_s{index}=E5_s;
state.D5_s{index}=D5_s;
state.O6_s{index}=O6_s;
end

%%%%%%%%%%%%%%%%%%%%%%%%%
%符号解法
% eq1 = A1(1) == 0;
% eqns = [eq1,];
% vars = H_Cta_12;
% so_H_Cta_12 = solve(eqns, vars);
%数值解法
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
cta_in = 9/20*pi-0.4*pi*t;

newCorner = cell(1,length(CornerCell{1}));
for j = 1:length(Corner{1})
    
    for k = 1:length(Corner)
        newCorner{j}(k) = Corner{k}(j);
    end
end
% 
newCorner
%%
for h = 1: length(cornerCell5x) 
    drawCorner(cta_in,3.14-cornerCell5x{h})
    hold on 
end

for h = 1: length(CornerCell) 
    drawCorner(cta_in,3.14-CornerCell{h})
    hold on 
end
        








%%
%全部绘图
T = frames;
tr = 40;
tc = 10;
for index=1:frames
    O0_s = state.O0_s{index};
    B1_s = state.B1_s{index};
    A1_s = state.A1_s{index};
    O1_s = state.O1_s{index};
    B2_s = state.B2_s{index};
    D1_s = state.D1_s{index};
    O2_s = state.O2_s{index};
    C2_s = state.C2_s{index};
    D2_s = state.D2_s{index};
    O3_s = state.O3_s{index};
    E3_s = state.E3_s{index};
    D3_s = state.D3_s{index};
    O4_s = state.O4_s{index};
    C4_s = state.C4_s{index};
    D4_s = state.D4_s{index};
    O5_s = state.O5_s{index};
    E5_s = state.E5_s{index};
    D5_s = state.D5_s{index};
    O6_s = state.O6_s{index};
    
    
clf
useAxios([0 0 1])

arr =double(vpa(O0_s)');
F = 1:n;
patch('Faces',F,'Vertices',arr,'FaceColor',[0.3010 0.7450 0.9330])
colorbar
%%%%%%%%%%%%%%%%%%%%%%%%%%
A1_arr = double(vpa(A1_s)');
O0_arr = double(vpa(O0_s)');
col_1=[0.9290 0.6940 0.1250];
% col_1 = [173,216,230]/255;
for i=1:n
    if(i == 1)
        point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(n,:),col_1)
    else
         point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(i-1,:),col_1)
    end
    
end
%%%%%%%%%%%%顶层%%%%%%%%%%%%%
col = [0.8500 0.3250 0.0980];
% col = [173,216,230]/255;
face_array_end(O0_s,A1_s,B1_s,n,col)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%定义颜色
Blue = [0.3010 0.7450 0.9330];
Orange = [0.9290 0.6940 0.1250];
DarkGray = [169,169,169]/255;
LightGrey = [211 211 211]/255;
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%第一层%%%%%%%%%%%%%%
% col=[0.3010 0.7450 0.9330];
col = Blue;
face_array_start(O1_s,B1_s,A1_s,n,col)
face_array_end(B2_s,O1_s,B1_s,n,col)
face_array_start(D1_s,B2_s,O1_s,n,col)
%%%%%%%%%第二层%%%%%%%%%%%%%%
col = [0.9290 0.6940 0.1250];
col = Orange;
face_array_end(O2_s,D1_s,B2_s,n,col)
face_array_start(C2_s,O2_s,D1_s,n,col)
face_array_end(D2_s,C2_s,O2_s,n,col)
%%%%%%%%%第三层%%%%%%%%%%%%%%
col=[0.3010 0.7450 0.9330];%蓝色
col = Blue;
face_array_start(O3_s,D2_s,C2_s,n,col)
face_array_end(E3_s,O3_s,D2_s,n,col)
face_array_start(D3_s,E3_s,O3_s,n,col)
%%%%%%%%%第四层%%%%%%%%%%%%%%
col=[0.9290 0.6940 0.1250];%%橙色
col = Orange;
face_array_end(O4_s,D3_s,E3_s,n,col)
face_array_start(C4_s,O4_s,D3_s,n,col)
face_array_end(D4_s,C4_s,O4_s,n,col)
%%%%%%%%%第五层%%%%%%%%%%%%%%
col=[0.3010 0.7450 0.9330];%蓝色
col = Blue;
face_array_start(O5_s,D4_s,C4_s,n,col)
face_array_end(E5_s,O5_s,D4_s,n,col)
face_array_start(D5_s,E5_s,O5_s,n,col)
%%%%%%%%%第六层%%%%%%%%%%%%%%
col=[0.9290 0.6940 0.1250];%%橙色
col = Orange;
face_array_end(O6_s,D5_s,E5_s,n,col)
pause(0.5);
end

%% 
% state = getAllstate();
x = zeros(1,7);
y = zeros(1,7);
figure
colorbar;
for i = 1:frames
P_O0 = state.O0_s{i}{1};
P_O1 = state.O1_s{i}{1};
P_O2 = state.O2_s{i}{1};
P_O3 = state.O3_s{i}{1};
P_O4 = state.O4_s{i}{1};
P_O5 = state.O5_s{i}{1};
P_O6 = state.O6_s{i}{1};


clf
useAxios([0,-0,1])
axis([-100 100 -150 50 -100 100])
% view([0,-0,1])

%画折线图
x= double([norm([P_O0(1),P_O0(3)]),norm([P_O1(1),P_O1(3)]),norm([P_O2(1),P_O2(3)]),norm([P_O3(1),P_O3(3)]),norm([P_O4(1),P_O4(3)]),norm([P_O5(1),P_O5(3)]),norm([P_O6(1),P_O6(3)])]);
y= double([P_O0(2),P_O1(2),P_O2(2),P_O3(2),P_O4(2),P_O5(2),P_O6(2)]);
useLine(x,y);
useLine(-x,y);
for j=1:7
  useCircle(x(j),y(j))
end
pause(0.1)
end
%% 画细度比图
finenessRatio = zeros(1,frames);
for i = 1:frames
P_O0 = state.O0_s{i}{1};
P_O1 = state.O1_s{i}{1};
P_O2 = state.O2_s{i}{1};
P_O3 = state.O3_s{i}{1};
P_O4 = state.O4_s{i}{1};
P_O5 = state.O5_s{i}{1};
P_O6 = state.O6_s{i}{1};

finenessRatio(i) = abs(P_O4(2)/norm([P_O4(1),P_O4(3)]))/2;
end
t = linspace(0,1,frames);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
cta_in = 0.4*pi-0.35*pi*t;
useLine(cta_in,finenessRatio)
xlim([0 pi/2]);
xticks([0 ,0.05*pi,1*pi/8, 1*pi/4,0.4*pi, 0.5*pi])
xticklabels({'0','1/20\pi','1/8\pi','1/4\pi','0.4\pi','1/2\pi'})
xlabel('\theta_{in}')
ylabel('fineness')
ax = gca;
ax.FontSize = 16;
% xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])
% xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'})
%% 计算腔内流量变化——曲线拟合
V_arr = zeros(1,frames);
for i=1:frames
    P_O0 = state.O0_s{i}{1};
    P_O1 = state.O1_s{i}{1};
    P_O2 = state.O2_s{i}{1};
    P_O3 = state.O3_s{i}{1};
    P_O4 = state.O4_s{i}{1};
    P_O5 = state.O5_s{i}{1};
    P_O6 = state.O6_s{i}{1};
    
    x= double([norm([P_O0(1),P_O0(3)]),norm([P_O1(1),P_O1(3)]),norm([P_O2(1),P_O2(3)]),norm([P_O3(1),P_O3(3)]),norm([P_O4(1),P_O4(3)]),norm([P_O5(1),P_O5(3)]),norm([P_O6(1),P_O6(3)])]);
    y= double([P_O0(2),P_O1(2),P_O2(2),P_O3(2),P_O4(2),P_O5(2),P_O6(2)]);
    
    
    V = 0;
    for j=1:6
        v = 1/3*pi*abs(y(j)-y(j+1))*(x(j)^2+x(j+1)^2+x(j)*x(j+1));
        V = V+v;
    end
    V_arr(i)=V;
end
t = linspace(0,1,frames);
useLine(t,V_arr)
% V_arr(end)=NaN;
% c = V_arr;
% patch(t,V_arr,c,'EdgeColor','interp','Marker','o','MarkerFaceColor','flat');
% grid on

%对V（Cin）进行曲线拟合-直接影响函数
hold on 
t_recovery = linspace(0,2,20);
p5 = polyfit(t_recovery,V_arr,5);
y5 = polyval(p5,t_recovery);
%p5 体积与时间t之间的函数关系 -恢复阶段
p5 = vpa(poly2sym(p5),5);
plot(t_recovery,y5)

%% S_bell孔口面积计算--曲线拟合
S_bell = zeros(1,frames);
for i=1:frames
    P_O6 = state.O6_s{i}{1};
    r_bell = norm([P_O6(1),P_O6(3)]);
    S_bell(i) = pi*r_bell^2;
end
t = linspace(0,1,frames);
useLine(t,S_bell)

%曲线拟合-直接影响函数
hold on 
t_recovery = linspace(0,1,20);
s_bell = polyfit(t_recovery,S_bell,3);
y2 = polyval(s_bell,t_recovery);
%孔口面积与时间的关系
s_bell = vpa(poly2sym(s_bell),5);
plot(t_recovery,y2)
%% 推进力T的计算公式
Ro_water = 1.0*1000;
dVdt = diff(p5);
T_jet = Ro_water/s_bell*(dVdt)^2;

fplot(T_jet,[0 1])
%% 阻力计算（系数 c_bell 经验公式计算 先求雷诺数）
%简便计算
if u<0
    c_bell = 0.42;
else
    c_bell = 1.17;
end

%
for i=1:frames
    P_O4 = state.O4_s{i}{1};
    d_max = norm([P_O4(1),P_O4(3)]);
    
%     Re_bell = abs(u*Ro_water*)
end


%%  附加质量力A 计算 (附加质量系数 added_mass_coefficient)
added_mass_coefficient = zeros(1,frames);
r_bell_max = zeros(1,frames);
for i=1:frames
    P_O4 = state.O4_s{i}{1};
    r_bell = norm([P_O4(1),P_O4(3)]);
    added_mass_coefficient(i) = abs(P_O4(2)/norm([P_O4(1),P_O4(3)]))^(-1.4);
%   A_mass_Force = added_mass_coefficient*Ro_water*V;
    r_bell_max(i) = norm([P_O4(1),P_O4(3)]);
end
t = linspace(0,1,frames);
useLine(t,added_mass_coefficient)

%% 龙格-库塔算法




