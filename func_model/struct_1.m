function [O3,B4,B4M,angle_23,angle_34] = struct_1(prev_M,angle_23,angle_34,a,n)
OM = prev_M*T('z',a)*R('x',pi);
A3M = OM*R('x',pi/2);

Q23 =  R('z',-angle_23)*R('x',pi/4);
O3M = A3M*Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';
O3_vpa = vpa(O3);

f = matlabFunction(O3_vpa(1));
angle_23 = fsolve(f,1.57);

Q23 =  R('z',-angle_23)*R('x',pi/4);
O3M = A3M*Q23;
O3 = O3M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q34 = R('z',angle_34)*R('x',pi/4);
B4M = O3M*Q34;
B4 = B4M*[0 0 2*a 1]';

B4_vpa = vpa(B4);
f =matlabFunction(B4_vpa(3)*tan(pi/n)-B4_vpa(1));
angle_34 = fsolve(f,1.57);

Q34 = R('z',angle_34)*R('x',pi/4);
B4M = O3M*Q34;
B4 = B4M*[0 0 2*a 1]';
end

