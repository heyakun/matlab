function [A2,O2,O2M,angle_23,angle_34] = struct_2(prev_M,angle_23,angle_34,a,n)
B2M =  prev_M*T('z',2*a)*R('x',pi);
O1M = B2M*R('x',pi/4);

Q23 = R('z',angle_23)*R('x',pi/4);
A2M = O1M*Q23;
A2 = A2M*[0 0 a 1]';

A2_vpa = vpa(A2);
%旧：采用fsolve求解方式
f =matlabFunction(A2_vpa(1));
angle_23 = fsolve(f,1.57);
%新：采用vpasovle求解方式



Q23 = R('z',angle_23)*R('x',pi/4);
A2M = O1M*Q23;
A2 = A2M*[0 0 a 1]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q34 = R('z',-angle_34)*R('x',pi/2);
O2M = A2M*Q34;
O2 = O2M*[0 0 a 1]';

O2_vpa = vpa(O2);
f = matlabFunction(O2_vpa(3)*tan(pi/n)-O2_vpa(1));
angle_34 = fsolve(f,1.57);

Q34 = R('z',-angle_34)*R('x',pi/2);
O2M = A2M*Q34;
O2 = O2M*[0 0 a 1]';
end

