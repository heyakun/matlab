function [] = useCycle(recovery_func,dur_rec,constriction_func,dur_con,t)
period = dur_rec + dur_con;
total_func_value = zeros(1,length(t));
for i=1:length(t)
    cur_T_count =floor(t(i)/period); 
    cur_t = t(i)-cur_T_count*period;
    if  cur_t <= dur_rec
       total_func_value(i) = recovery_func(cur_t);
    else
        total_func_value(i) = constriction_func(cur_t);
    end
end
grid on
hold on 
plot(t,total_func_value,'-o');
end


