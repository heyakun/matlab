function [] = mydraw(O,A,B,C,D,E,F)
%MYDRAW 此处显示有关此函数的摘要
%   此处显示详细说明
    
p2p_connect(O,A)
p2p_connect(O,B)
p2p_connect(O,C)
p2p_connect(O,D)
p2p_connect(O,E)
p2p_connect(O,F)
p2p_connect(A,B)
p2p_connect(B,C)
p2p_connect(C,D)
p2p_connect(D,E)
p2p_connect(E,F)
p2p_connect(F,A)
end

