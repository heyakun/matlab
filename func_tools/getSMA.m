function [outputArg1,outputArg2] = getSMA(x1,x2,s1,n)
syms n 
s1 = 2.5;
r = 0.4;
x2 = 21;
angle = 15*pi/16;

f1 =matlabFunction(n*(s1*2+angle*r)-x2 ); 
n_res=fsolve(f1,1);
n = ceil(n_res);
x1=2*r*sin(angle/2)+2*n*((s1*cos(angle/2)+r*sin(angle/2)));

angle_start = angle/2;
x2_res = n*(s1*2+angle*r);
len= x2_res-x1;

syms angle
x2 = 21;
f2 =matlabFunction(n*(s1*2+angle*r)-x2 ); 
angle_res=fsolve(f1,0);
angle_out = rad2deg(angle_res);
end

