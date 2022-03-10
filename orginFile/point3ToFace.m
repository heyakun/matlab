function [] = point3ToFace(A1,B1,O1,col)
    arr = [A1;B1;O1];
    f = 1:3;
    patch('Faces',f,'Vertices',arr,'FaceColor',col)
end

