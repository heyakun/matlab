function [res,res_b] = getVectorRight(node_right,node_up,node_down)
%GETRIGHTVECTOR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
a = node_right-node_up;
b = node_down-node_up;
c= cross(b,a);

res_b = b/norm(b);

norm_handle = sqrt(c(1)^2+c(2)^2+c(3)^2);
x = c(1)/norm_handle;
y = c(2)/norm_handle;
z = c(3)/norm_handle;

res = [x,y,z];
end

