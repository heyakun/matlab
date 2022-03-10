function [] = usePeriod_func(recovery_func,t_recovery,constriction_func,t_constriction)
recovery_func_value = recovery_func(t_recovery);
constriction_func_value = constriction_func(t_constriction);
grid on
hold on 
plot(t_recovery,recovery_func_value,'-o');
hold on 
plot(t_constriction,constriction_func_value,'-o');
end

