function [res_D,res_T,res_A] = calc_DTA(res_t,res_y,Config)
%CALC_D 此处显示有关此函数的摘要
%   此处显示详细说明
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
%     m = 100;%单位g
%     g = 9.8*1000;%单位mm/s^2
%     G = 0*g;%单位g
    v_Arr = res_y(:,2);
    x_Arr = res_y(:,1);
    %求加速度 dv/dt :采用差分法，求解后会dv 长度比v_Arr原来少一个值，
    dvdt = diff(v_Arr)./diff(res_t);
    %因此补一个值
    dvdt = [dvdt(1);dvdt];
    
    
    T = t_r + t_c;
    len = length(res_t);
    res_D = zeros(len,1);
    res_T = zeros(len,1);
    res_A = zeros(len,1);
    for index =1:len
      t = res_t(index);
      x(1) = x_Arr(index);
      x(2) = v_Arr(index);
      x(3) = dvdt(index);
        %flag对时间变量t 取整，用于后续的if判断条件
        flag = floor(t/T);
        % D中的c_bell值取决于速度x(2)是否大于0
        if(x(2)<0)
            c_bell = 0.42;
        else
            c_bell = 1.17;
        end

      if t-flag*T <= t_r
            val_T = -T1f(t - flag*T);
            Dc1 = Dc1f(t - flag*T);
            Ac1 = Ac1f(t - flag*T);
            val_A =  Ac1*x(3);
            val_D = Dc1*c_bell*x(2)*x(1)/t;
      else
            val_T = T2f(t-flag*T);
            Dc2 = Dc2f(t-flag*T);
            Ac2 = Ac2f(t-flag*T);
            val_D = Dc2*c_bell*x(2)*x(1)/t;
      end
%       D始终与速度方向相反，返回值添加负
      res_D(index) = -val_D;
      res_T(index) = val_T;
      res_A(index) = val_A;
    end
end

