function [] = face_array_start(O1_s,B1_s,A1_s,n,col)
    O1_arr = double(vpa(O1_s)');
    B1_arr = double(vpa(B1_s)');
    A1_arr = double(vpa(A1_s)');
for i=1:n
    point3ToFace(O1_arr(i,:),A1_arr(i,:),B1_arr(i,:),col)
if(i == 1)
    point3ToFace(O1_arr(i,:),A1_arr(i,:),B1_arr(n,:),col)
else
    point3ToFace(O1_arr(i,:),A1_arr(i,:),B1_arr(i-1,:),col)
end
end
end

