function [] = special_start(C1_s,O1_s,D1_s,n)
digits(5)
C1_s = vpa(C1_s);
O1_s = vpa(O1_s);
D1_s = vpa(D1_s);
for j=1:n
    if(j == 1)
        p2p_connect(C1_s(:,j),D1_s(:,j))
        p2p_connect(C1_s(:,j),O1_s(:,n))
        p2p_connect(C1_s(:,j),O1_s(:,j))
    else
        p2p_connect(C1_s(:,j),D1_s(:,j))
        p2p_connect(C1_s(:,j),O1_s(:,j))
        p2p_connect(C1_s(:,j),O1_s(:,j-1))        
    end  
end
end

