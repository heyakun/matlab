global a p n m
p = 15;
a = 20;
n = 16;
m = 5;
syms Cin pi x
Cin = pi/3;
Cta = Cin + pi/2;
% Cta = 0.8*pi / 2;

%求O0 (与p直接相关)
O0M = R('y', pi / n) * T('z', p);
O0 = O0M(1:4,4);
O0_s = point_by_axiosY_array(O0,n);
clf

arr =double(vpa(O0_s)');
F = 1:n;
patch('Faces',F,'Vertices',arr,'FaceColor',[0.3010 0.7450 0.9330])
colorbar
useAxios([0 0 1])

%求F1(与输入直接相关)
H_B1M = O0M * R('x', Cta) * T('z', -a);
B1 = H_B1M*[0 0 0 1]';
B1_s = point_by_axiosY_array(B1,n);
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

A1_s = point_by_axiosY_array(A1,n);

col = [0.8500 0.3250 0.0980];

A1_arr = double(vpa(A1_s)');
O0_arr = double(vpa(O0_s)');
col_1=[0.9290 0.6940 0.1250];
for i=1:n
    if(i == 1)
        point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(n,:),col_1)
    else
         point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(i-1,:),col_1)
    end
end
face_array_end(O0_s,A1_s,B1_s,n,col)

%%%%%%%%%%%%%%%%%%%%%


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
O1_s = point_by_axiosY_array(O1,n);
col=[0.3010 0.7450 0.9330];
face_array_start(O1_s,B1_s,A1_s,n,col)
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
B2_s = point_by_axiosY_array(B2,n);
face_array_end(B2_s,O1_s,B1_s,n,col)

syms I_Cta_23 I_Cta_34 
[A2, O2,O2M] = struct_2(B2M,I_Cta_23,I_Cta_34,a,n);
%%%%%%%%%%%%%第二层%%%%%%%%%%%%%%%
syms J_Cta_23 J_Cta_34
[A3,B3,B3M] = struct_3(O2M,J_Cta_23,J_Cta_34,a,n);
syms  K_Cta_23 K_Cta_34
[O3,B4,B4M] = struct_1(B3M,K_Cta_23,K_Cta_34,a,n);
%%%%%%%%%%%%第三层%%%%%%%%%%%%%%%
syms L_Cta_23 L_Cta_34 
[A4,O4,O4M] = struct_2(B4M,L_Cta_23,L_Cta_34,a,n);
%%%%%%%%%%%%第四层%%%%%%%%%%%%%%%
syms N_Cta_23 N_Cta_34
[A5,B5,B5M] = struct_3(O4M,N_Cta_23,N_Cta_34,a,n);
syms  P_Cta_23 P_Cta_34
[O5,B6,B6M] = struct_1(B5M,P_Cta_23,P_Cta_34,a,n);
%%%%%%%%%%%%第5层%%%%%%%%%%%%%%%
syms S_Cta_23 S_Cta_34 
[A6,O6,O6M] = struct_2(B6M,S_Cta_23,S_Cta_34,a,n);
%%%%%%%%%%绘图


A2_s = point_by_axiosY_array(A2,n);
face_array_start(A2_s,B2_s,O1_s,n,col)
%%%%%%%%%%%%绘制第2层%%%%%%%%%%%%%%%
O2_s = point_by_axiosY_array(O2,n);
col = [0.9290 0.6940 0.1250];
face_array_end(O2_s,A2_s,B2_s,n,col)

A3_s = point_by_axiosY_array(A3,n);
face_array_start(A3_s,O2_s,A2_s,n,col)
B3_s = point_by_axiosY_array(B3,n);
face_array_end(B3_s,A3_s,O2_s,n,col)
%%%%%%%%%%%%绘制第3层%%%%%%%%%%%%%%%
O3_s = point_by_axiosY_array(O3,n);
col=[0.3010 0.7450 0.9330];%蓝色
face_array_start(O3_s,B3_s,A3_s,n,col)
B4_s = point_by_axiosY_array(B4,n);
face_array_end(B4_s,O3_s,B3_s,n,col)

A4_s = point_by_axiosY_array(A4,n);
face_array_start(A4_s,B4_s,O3_s,n,col)
%%%%%%%%%%%%绘制第4层%%%%%%%%%%%%%%%
O4_s = point_by_axiosY_array(O4,n);
col=[0.9290 0.6940 0.1250];%%橙色
face_array_end(O4_s,A4_s,B4_s,n,col)

A5_s = point_by_axiosY_array(A5,n);
face_array_start(A5_s,O4_s,A4_s,n,col)
B5_s = point_by_axiosY_array(B5,n);
face_array_end(B5_s,A5_s,O4_s,n,col)
%%%%%%%%%%%%绘制第5层%%%%%%%%%%%%%%%
O5_s = point_by_axiosY_array(O5,n);
col=[0.3010 0.7450 0.9330];%蓝色
face_array_start(O5_s,B5_s,A5_s,n,col)
B6_s = point_by_axiosY_array(B6,n);
face_array_end(B6_s,O5_s,B5_s,n,col)

A6_s = point_by_axiosY_array(A6,n);
face_array_start(A6_s,B6_s,O5_s,n,col)
%%%%%%%%%%%%绘制第6层%%%%%%%%%%%%%%%
O6_s = point_by_axiosY_array(O6,n);
face_array_end(O6_s,A6_s,B6_s,n,col)