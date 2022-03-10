function dx = Dyn_odefunc_01(t,x,T1f,T2f,Dc1f,Dc2f,Ac1f,Ac2f,dur_rec,dur_con)
m = 500;%��λg
g = 9.8*1000;%��λmm/s^2
G = 5*g;%��λg
dx = zeros(2,1);
T = dur_rec+dur_con;
%flag��ʱ�����t ȡ�������ں�����if�ж�����
flag = floor(t/T);
%T(t)-Dco(t)x'(t)x(t)/t- Aco(t)x"(t)-(G-Fb)=mx"(t)

if t-flag*T <= dur_rec
        T1 = T1f(t - flag*T);
        Dc1 = Dc1f(t - flag*T);
        Ac1 = Ac1f(t - flag*T);
  
        dx(1) = x(2);
        dx(2) = (T1-Dc1*x(2)*x(1)/t-G)/(Ac1+m);  
else
        T2 = T2f(t-flag*T);
        Dc2 = Dc2f(t-flag*T);
        Ac2 = Ac2f(t-flag*T);
        
        dx(1) = x(2);         
        dx(2) = (T2-Dc2*x(2)*x(1)/t-G)/(Ac2+m);

end
