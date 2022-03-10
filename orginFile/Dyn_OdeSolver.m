% 得到全部数据点getAllstate
%根据全部数据点 得到T Dco Aco 全部函数

% state = getAllstate();
dur_rec = 2;
dur_con = 1;
storeFunc = getAllFunc(state,dur_rec,dur_con);

Vol_rec_func=storeFunc.Vol_rec_func;
Vol_con_func=storeFunc.Vol_con_func;
T1f =  storeFunc.T_rec_func ;
T2f = storeFunc.T_con_func  ;
Dc1f = storeFunc.D_co_rec_func; 
Dc2f = storeFunc.D_co_con_func ;
Ac1f = storeFunc.A_co_rec_func ;
Ac2f = storeFunc.A_co_con_func ;

t_recovery = linspace(0,dur_rec,20);
t_constriction = linspace(dur_rec,dur_rec+dur_con,20);
%验证函数是否正确
figure(1)
subplot(2,2,1)
% useVerify_func(Vol_rec_fun,t_recovery,Vol_con_func,t_constriction)
t_total = 0.1:0.1:9;
useCycle(Vol_rec_func,dur_rec,Vol_con_func,dur_con,t_total)
xlabel('time(s)')
ylabel('Volume')
ax = gca;
ax.FontSize = 18;
subplot(2,2,2)
useCycle(T1f,dur_rec,T2f,dur_con,t_total)
% useVerify_func(T1f,t_recovery,T2f,t_constriction)
xlabel('time(s)')
ylabel('T')
ax = gca;
ax.FontSize = 18;
subplot(2,2,3)
% useVerify_func(Dc1f,t_recovery,Dc2f,t_constriction)
useCycle(Dc1f,dur_rec,Dc2f,dur_con,t_total)
xlabel('time(s)')
ylabel('Dco')
ax = gca;
ax.FontSize = 18;
subplot(2,2,4)
% useVerify_func(Ac1f,t_recovery,Ac2f,t_constriction)
useCycle(Ac1f,dur_rec,Ac2f,dur_con,t_total)
xlabel('time(s)')
ylabel('Aco')
ax = gca;
ax.FontSize = 18;

%ode算法求解
[ode_t,ode_x] = ode113(@(t,x) Dyn_odefunc_01(t,x,T1f,T2f,Dc1f,Dc2f,Ac1f,Ac2f,dur_rec,dur_con),[0.001 30],[0 0]);

figure(2)
grid on
plot(ode_t,ode_x(:,1));
hold on 
plot(ode_t,ode_x(:,2));
xlabel("Time t")
ax = gca;
ax.FontSize = 18;
% T = dur_rec+dur_con;
% %flag对时间变量t 取整，用于后续的if判断条件
% D_value = zeros(length(ode_t),1);
% A_value = zeros(length(ode_t),1);
% for i = 1:length(ode_t)
%     flag = floor(ode_t(i)/T);
% if t(i)-flag*T <= dur_rec
%     D_value(i) = Dc1f(ode_t(i)).*ode_x(:,1).*ode_x(:,2);
%     A_value(i) = Ac1f(ode_t(i)).*ode_x(:,2).*ode_x(:,2);
% else
%     D_value(i) = Dc2f(ode_t(i)).*ode_x(:,1).*ode_x(:,2);
% 
% end
% end



