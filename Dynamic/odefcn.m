function dydt = odefcn(t,x,Config)
%配置 解构  
T1f = Config.T1f ;
  T2f = Config.T2f ;
  Dc1f = Config.Db1f ;
  Dc2f = Config.Db2f ;
  Ac1f = Config.Ab1f ;
  Ac2f = Config.Ab2f ;
  t_r = Config.t_r;
  t_c = Config.t_c;
  %基本数据
    m = 100;%单位g
    g = 9.8*1000;%单位mm/s^2
    G = 0*g;%单位g
    
    T = t_r+t_c;
    %flag对时间变量t 取整，用于后续的if判断条件
    flag = floor(t/T);
  %odefunc
  
  dydt = zeros(2,1);
  if t-flag*T <= t_r
        T1 = T1f(t - flag*T);
        Dc1 = Dc1f(t - flag*T);
        Ac1 = Ac1f(t - flag*T);
  
        dydt(1) = x(2);
        dydt(2) = (T1-Dc1*x(2)*x(1)/t-G)/(Ac1+m);
  else
        T2 = T2f(t-flag*T);
        Dc2 = Dc2f(t-flag*T);
        Ac2 = Ac2f(t-flag*T);
        
        dydt(1) = x(2);         
        dydt(2) = (T2-Dc2*x(2)*x(1)/t-G)/(Ac2+m);
  end
end

