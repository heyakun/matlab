function [Volume_constriction_func_sym,Volume_constriction_func] = getVolume_constriction_Func(constriction_duration,V_arr,recover_duration)
[~,Volume_recovery_func]= getVolume_recovery_Func(constriction_duration,V_arr);

% Volume_constriction_func = Volume_recovery_func(2*X0-t_constriction);
syms x 
Volume_constriction_func_sym = Volume_recovery_func(2*constriction_duration-x+abs(constriction_duration-recover_duration));
Volume_constriction_func = matlabFunction(Volume_constriction_func_sym);
end

