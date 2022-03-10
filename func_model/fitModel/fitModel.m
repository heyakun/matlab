p = 15;
a = 20;
n = 16;
m = 5;

syms Cin  x
Cin = 0.9*pi/2;
Cta = Cin + pi/2;

O0M = R('y', pi/n) * T('z', p);
O0 = O0M(1:4,4);
O0_s = point_by_axiosY_array(O0,n);

clf
arr =double(vpa(O0_s)');
F = 1:n;
patch('Faces',F,'Vertices',arr,'FaceColor',[0.3010 0.7450 0.9330])
colorbar
useAxios([0 0 1])
H_B1M = O0M * R('x', Cta) * T('z', -a);
B1 = H_B1M*[0 0 0 1]';
B1_s = point_by_axiosY_array(B1,n);
