function [state] = getAllstate()
%%
%起始点
%dev05实现patch绘图功能
%dev06 收集全部O_s点，绘制包络线
digits(5)
p = 15;
a = 20;
n = 16;
frames = 20;

for index=1:frames
syms Cin  x
Cin = linspace(0.99*pi/2,0.01*pi/2,frames);
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

f =matlabFunction(A1(1));
H_Cta_12 = fsolve(f,1.57);

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

end

