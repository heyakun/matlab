function [] = face_array_end(O0_s,A1_s,B1_s,n,col)
    A1_arr = double(vpa(A1_s)');
    O0_arr = double(vpa(O0_s)');
    B1_arr = double(vpa(B1_s)');
for i=1:n
    point3ToFace(O0_arr(i,:),A1_arr(i,:),B1_arr(i,:),col)
if(i == n)
    point3ToFace(O0_arr(i,:),A1_arr(1,:),B1_arr(i,:),col)
else
    point3ToFace(O0_arr(i,:),A1_arr(i+1,:),B1_arr(i,:),col)
end
end
end

