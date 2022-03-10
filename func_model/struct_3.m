function [A3,B3,B3M,angle_23,angle_34] = struct_3(prev_M,angle_23,angle_34,a,n)
O2M = prev_M*T('z',a)*R('x',pi);
A2M = O2M*R('x',pi/4);

Q23 = R('z',angle_23)*R('x',pi/2);
A3M = A2M*Q23;
A3 = A3M*[0 0 sqrt(2)*a 1]';

A3_vpa = vpa(A3);
f = matlabFunction(A3_vpa(1));
angle_23 = fsolve(f,1.57);
%%%%%%%%%%%%%%%%%%%%%%%%
Q23 = R('z',angle_23)*R('x',pi/2);
A3M = A2M*Q23;
A3 = A3M*[0 0 sqrt(2)*a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%
Q34 = R('z',angle_34)*R('x',pi/4);
B3M = A3M*Q34;
B3 = B3M*[0 0 a 1]';

B3_vpa = vpa(B3);
f = matlabFunction(B3_vpa(3)*tan(pi/n)-B3_vpa(1));
angle_34 = fsolve(f,1.57);

Q34 = R('z',angle_34)*R('x',pi/4);
B3M = A3M*Q34;
B3 = B3M*[0 0 a 1]';
% face_array_end(B3_s,A3_s,O2_s,n,col)
end

