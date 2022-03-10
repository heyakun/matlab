%起始点
p = 15;
a = 20;
syms Cin pi x
Cin = pi/3;
Cta = Cin + pi/2;
% Cta = 0.8*pi / 2;

%求O0 (与p直接相关)
O0M = R('y', pi / 8) * T('z', p);
O0 = O0M(1:4,4);
O0_s = point_by_axiosY_array(O0,8);
clf
for i=1:8
    if(i == 8)
        p2p_connect(O0_s{i},O0_s{1})
    else
        p2p_connect(O0_s{i},O0_s{i+1})
    end   
end
useAxios()

%求F1(与输入直接相关)
H_F1M = O0M * R('x', Cta) * T('z', -a);
F1 = H_F1M*[0 0 0 1]';
F1_s = point_by_axiosY_array(F1,8);
for j=1:8
    p2p_connect(O0_s{j},F1_s{j})
end


%求A1
syms H_Cta_12 H_Cta_23 H_Cta_34
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_F1M * H_Q12;
A1 = A1M*[0 0 a 1]';

f =matlabFunction(A1(1));
H_Cta_12 = fsolve(f,1.57);

%%%%%%%%%%%%%%%%%%%%%%
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_F1M * H_Q12;
A1 = A1M*[0 0 a 1]';

A1_s = point_by_axiosY_array(A1,8);
for j=1:8
    if(j == 1)
        p2p_connect(A1_s{j},F1_s{8})
        p2p_connect(A1_s{j},F1_s{j})
        p2p_connect(A1_s{j},O0_s{8})
        p2p_connect(A1_s{j},O0_s{j})
    else
         p2p_connect(A1_s{j},F1_s{j})
         p2p_connect(A1_s{j},F1_s{j-1})
         p2p_connect(A1_s{j},O0_s{j})
         p2p_connect(A1_s{j},O0_s{j-1})
    end  
end
%%%%%%%%%%%%%%%%%%%%%


H_Q23 = R('z',-H_Cta_23)*R('x',pi/4);
O1M = A1M*H_Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';

%
f =matlabFunction(O1(1));
H_Cta_23 = fsolve(f,1.58);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_Q23 = R('z',-H_Cta_23)*R('x',pi/4);
O1M = A1M*H_Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%
O1_s = point_by_axiosY_array(O1,8);
p2p_connect(A1_s{1},O1_s{1})
special_start(O1_s,F1_s,A1_s)
% for j=1:8
%     if(j == 1)
%         p2p_connect(O1_s{j},F1_s{8})
%         p2p_connect(O1_s{j},F1_s{j})
%         p2p_connect(O0_s{j},A1_s{j})
%     else
%          p2p_connect(O1_s{j},F1_s{j})
%          p2p_connect(O1_s{j},F1_s{j-1})
%          p2p_connect(O1_s{j},A1_s{j})
%  
%     end  
% end


H_Q34 = R('z',H_Cta_34)*R('x',pi/4);
E1M = O1M*H_Q34;
E1 = E1M*[0 0 2*a 1]';

f =matlabFunction(E1(3)*tan(pi/8)-E1(1));
H_Cta_34 = fsolve(f,1.57);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H_Q34 = R('z',H_Cta_34)*R('x',pi/4);
E1M = O1M*H_Q34;
E1 = E1M*[0 0 2*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E1_s = point_by_axiosY_array(E1,8);
special_end(E1_s,O1_s,F1_s)
% for k=1:8
%      if(k == 8)
%          p2p_connect(E1_s{k},O1_s{1})
%          p2p_connect(E1_s{k},F1_s{k})
%          p2p_connect(E1_s{k},O1_s{k})
%      else
%         p2p_connect(E1_s{k},O1_s{k})
%         p2p_connect(E1_s{k},O1_s{k+1})
%         p2p_connect(E1_s{k},F1_s{k})
%      end
% end

syms I_Cta_23 I_Cta_34 
I_E1M = E1M*T('z',2*a)*R('x',pi);
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
D1_s = point_by_axiosY_array(D1,8);
special_start(D1_s,E1_s,O1_s)
% for j=1:8
%     if(j == 1)
%         p2p_connect(D1_s{j},E1_s{8})
%         p2p_connect(D1_s{j},O1_s{j})
%         p2p_connect(D1_s{j},E1_s{j})
%     else
%          p2p_connect(D1_s{j},E1_s{j})
%          p2p_connect(D1_s{j},E1_s{j-1})
%          p2p_connect(D1_s{j},O1_s{j})
%     end  
% end

I_Q34 = R('z',-I_Cta_34)*R('x',pi/2);
O2M = D1M*I_Q34;
O2 = O2M*[0 0 a 1]';

f = matlabFunction(O2(3)*tan(pi/8)-O2(1));
I_Cta_34 = fsolve(f,1.57);
%%%%%%%%%%%%%%%%%%%%%%%%%%
I_Q34 = R('z',-I_Cta_34)*R('x',pi/2);
O2M = D1M*I_Q34;
O2 = O2M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%
O2_s = point_by_axiosY_array(O2,8);
special_end(O2_s,D1_s,E1_s)
% for k=1:8
%      if(k == 8)
%          p2p_connect(O2_s{k},D1_s{1})
%          p2p_connect(O2_s{k},E1_s{k})
%          p2p_connect(O2_s{k},D1_s{k})
%      else
%         p2p_connect(O2_s{k},D1_s{k})
%         p2p_connect(O2_s{k},D1_s{k+1})
%         p2p_connect(O2_s{k},E1_s{k})
%      end
% end


syms K_Cta_23 K_Cta_34
K_O2M = O2M*T('z',a)*R('x',pi);
K_B2M = K_O2M*R('x',pi/4);

K_Q23 = R('z',K_Cta_23)*R('x',pi/2);
C2M = K_B2M*K_Q23;
C2 = C2M*[0 0 sqrt(2)*a 1]';

f = matlabFunction(C2(1));
K_Cta_23 = fsolve(f,1.57);
%%%%%%%%%%%%%%%%%%%%%%%%
K_Q23 = R('z',K_Cta_23)*R('x',pi/2);
C2M = K_B2M*K_Q23;
C2 = C2M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%
C2_s = point_by_axiosY_array(C2,8);
special_start(C2_s,O2_s,D1_s)




K_Q34 = R('z',K_Cta_34)*R('x',pi/4);
D2M = C2M*K_Q34;
D2 = D2M*[0 0 a 1]';

f = matlabFunction(D2(3)*tan(pi/8)-D2(1));
K_Cta_34 = fsolve(f,1.17);

K_Q34 = R('z',K_Cta_34)*R('x',pi/4);
D2M = C2M*K_Q34;
D2 = D2M*[0 0 a 1]';

D2_s = point_by_axiosY_array(D2,8);
special_end(D2_s,C2_s,O2_s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms  S_Cta_23 S_Cta_34
S_F3M = D2M*T('z',a)*R('x',pi);
S_A3M = S_F3M*R('x',pi/2);

S_Q23 =  R('z',-S_Cta_23)*R('x',pi/4);
O3M = S_A3M*S_Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';
O3_vpa = vpa(O3);

f = matlabFunction(O3_vpa(1));
S_Cta_23 = fsolve(f,1.57);

S_Q23 =  R('z',-S_Cta_23)*R('x',pi/4);
O3M = S_A3M*S_Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';

O3_s = point_by_axiosY_array(O3,8);
special_start(O3_s,D2_s,C2_s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


S_Q34 = R('z',S_Cta_34)*R('x',pi/4);
E3M = O3M*S_Q34;
E3 = E3M*[0 0 2*a 1]';

E3_vpa = vpa(E3);

f =matlabFunction(E3_vpa(3)*tan(pi/8)-E3_vpa(1));
S_Cta_34 = fsolve(f,1.57);

S_Q34 = R('z',S_Cta_34)*R('x',pi/4);
E3M = O3M*S_Q34;
E3 = E3M*[0 0 2*a 1]';

E3_s = point_by_axiosY_array(E3,8);
special_end(E3_s,O3_s,D2_s)

%符号解法
% eq1 = A1(1) == 0;
% eqns = [eq1,];
% vars = H_Cta_12;
% so_H_Cta_12 = solve(eqns, vars);

%数值解法











% 
% Cta2 = min(so_angle_1(1), so_angle_1(2));
% A1M = (top_F1M * R('y', Cta2) * T('x', -a));
% A1 = A1M(1:3, 4);
% %求O1
% syms Bta
% O1M = A1M*R('x',Bta)*T('y',-a);
% O1 = O1M(1:3,4);
% eq2 = O1(1) == 0;
% eqns = [eq2, ];
% vars = Bta;
% so_Bta = solve(eqns, vars);
% if length(so_Bta) == 2
%    for i=1:2
%        if(real(vpa(so_Bta(i)))<0)
%            h_Bta = so_Bta(i);
%        end
%    end
% else
%     h_Bta = so_Bta;
% end
% O1M = A1M*R('x',h_Bta)*T('y',-a);
% O1 = O1M(1:3,4);