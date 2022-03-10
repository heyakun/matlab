function [] = special_end(B2_s,O1_s,B1_s,n)
digits(5)
B1_s = vpa(B1_s);
O1_s = vpa(O1_s);
B2_s = vpa(B2_s);
for k=1:n
     if(k == n)
         p2p_connect(B2_s(:,k),O1_s(:,1))
         p2p_connect(B2_s(:,k),O1_s(:,k))
         p2p_connect(B2_s(:,k),B1_s(:,k))
     else
        p2p_connect(B2_s(:,k),O1_s(:,k))
        p2p_connect(B2_s(:,k),O1_s(:,k+1))
        p2p_connect(B2_s(:,k),B1_s(:,k))
     end
      
end
end

