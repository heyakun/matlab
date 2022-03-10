function [res_angle] = getVectorAngle(v1,v2)
  res_rad = acos( dot(v1,v2) / ( norm(v1) * norm(v2)));
  res_angle =  rad2deg(res_rad);
end

