% %全局坐标旋转
% digits(5)
% syms xx 
% 
% foo = matlabFunction(xx+1);
% bar = matlabFunction(xx+2);

r=2; theta=0:pi/100:2*pi;
x=r*cos(theta); y=r*sin(theta);
rho=r*sin(theta);
figure(1)
plot(x,y,'-')