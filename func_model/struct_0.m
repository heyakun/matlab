function [O1,B2,B2M,angle_23,angle_34] = struct_0(prev_M,angle_23,angle_34,a,n)
Q23 =  R('z',-angle_23)*R('x',pi/4);
O1M = prev_M*Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';
O1_vpa = vpa(O1);

f = matlabFunction(O1_vpa(1));
angle_23 = fsolve(f,1.57);

Q23 =  R('z',-angle_23)*R('x',pi/4);
O1M = prev_M*Q23;
O1 = O1M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q34 = R('z',angle_34)*R('x',pi/4);
B2M = O1M*Q34;
B2 = B2M*[0 0 2*a 1]';

B2_vpa = vpa(B2);
f =matlabFunction(B2_vpa(3)*tan(pi/n)-B2_vpa(1));
angle_34 = fsolve(f,1.57);

Q34 = R('z',angle_34)*R('x',pi/4);
B2M = O1M*Q34;
B2 = B2M*[0 0 2*a 1]';
end

