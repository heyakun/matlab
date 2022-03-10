function [S_bell_constriction_sym,S_bell_constriction_func] = getSbell_constriction(duration_recovery,S_bell_points,duration_constriction)
[~,s_bell_func] = getSbell_recovery(duration_constriction,S_bell_points);

syms x 
S_bell_constriction_sym = s_bell_func(2*duration_constriction-x+abs(duration_constriction-duration_recovery));
S_bell_constriction_func = matlabFunction(S_bell_constriction_sym);
end

