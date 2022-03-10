function [output] = getVolumeCycleFunc(func_rec,dur_rec,func_con,dur_con,t_arr)

T = dur_rec+dur_con;
output = zeros(1,length(t_arr));
for i=1:length(t_arr)
    t = t_arr(i);
    flag = floor(t/T);
    if t - flag*T <dur_rec
        output(i) =func_rec(t-flag*T);
    else
       output(i) = func_con(t-flag*T);
    end
end
end

