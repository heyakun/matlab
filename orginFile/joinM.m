function [out] = joinM(point)
IM = eye(3);
bottom = zeros(1,3);
out = [IM,point;bottom,1];
end

