function dydt = odefcn(t,x,Config)
%���� �⹹  
T1f = Config.T1f ;
  T2f = Config.T2f ;
  Dc1f = Config.Db1f ;
  Dc2f = Config.Db2f ;
  Ac1f = Config.Ab1f ;
  Ac2f = Config.Ab2f ;
  t_r = Config.t_r;
  t_c = Config.t_c;
  %��������
    m = 200;%��λg
    g = 9.8*1000;%��λmm/s^2
    G = 0*g;%��λg  ,������������
    
    T = t_r+t_c;
    %flag��ʱ�����t ȡ�������ں�����if�ж�����
    flag = floor(t/T);
    % D�е�c_bellֵȡ�����ٶ�x(2)�Ƿ����0
    if(x(2)<0)
        c_bell = 0.42;
    else
        c_bell = 1.17;
    end
  %odefunc
  
  dydt = zeros(2,1);
  if t-flag*T <= t_r
        T1 = T1f(t - flag*T);
        Dc1 = Dc1f(t - flag*T);
        Ac1 = Ac1f(t - flag*T);
  
        dydt(1) = x(2);
        dydt(2) = (T1-Dc1*c_bell*x(2)*x(1)/t-G)/(Ac1+m);
        
  else
        T2 = T2f(t-flag*T);
        Dc2 = Dc2f(t-flag*T);
        Ac2 = Ac2f(t-flag*T);
        
        dydt(1) = x(2);         
        dydt(2) = (T2-Dc2*c_bell*x(2)*x(1)/t-G)/(Ac2+m);
  end
end

