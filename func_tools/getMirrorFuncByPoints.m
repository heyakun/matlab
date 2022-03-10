function [current_sym,current_func] = getMirrorFuncByPoints(duration_recovery,points,duration_constriction)
[~,current_func] = getFuncByPoints(duration_constriction,points);

syms x 
current_sym = current_func(2*duration_constriction-x+abs(duration_constriction-duration_recovery));
current_func = matlabFunction(current_sym);
end

