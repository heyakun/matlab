function [] = useCircle(r,pos)
%����뾶r ��λ�� h ��Բ
% r=2; 

theta=0:pi/100:2*pi;
x=r*cos(theta);
y=r*sin(theta);
h = ones(1,length(theta))*pos;
% rho=r*sin(theta);
figure(1)
plot3(x,h,y,'--')
end

