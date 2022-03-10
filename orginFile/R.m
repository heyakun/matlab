function [b] = R(axis,Theta)
switch axis
    case 'x'
       a =[1,0,0,0;
            0,cos(Theta),-sin(Theta),0;
            0,sin(Theta),cos(Theta),0;
            0,0,0,1
            ];
    case 'y'
       a = [cos(Theta),0,sin(Theta),0;
            0,1,0,0;
            -sin(Theta),0,cos(Theta),0;
            0,0,0,1
            ];
    case 'z'
        a = [cos(Theta),-sin(Theta),0,0;
            sin(Theta),cos(Theta),0,0;
            0,0,1,0;
            0,0,0,1
        ];
end
b = vpa(a);
end

