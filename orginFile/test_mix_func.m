function [output] = test_mix_func(t_arr,T)
syms test_x
test_rec_func_sym = 2*test_x+1;
test_con_func_sym = -test_x+4;

test_rec_func = matlabFunction(test_rec_func_sym);
test_con_func = matlabFunction(test_con_func_sym);
output = zeros(1,length(t_arr));
for i=1:length(t_arr)
    t = t_arr(i);
    flag = floor(t/T);
    if t - flag*T <1
        output(i) =test_rec_func(t-flag*T);
    else
       output(i) = test_con_func(t-flag*T);
    end
end
end