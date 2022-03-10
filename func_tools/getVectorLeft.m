function [res,res_b] = getVectorLeft(node_left,node_middle,node_down)
a = node_left-node_middle;
b = node_down-node_middle;
c= cross(a,b);

res_b = b/norm(b);

norm_handle = sqrt(c(1)^2+c(2)^2+c(3)^2);
x = c(1)/norm_handle;
y = c(2)/norm_handle;
z = c(3)/norm_handle;

res = [x,y,z];
end

