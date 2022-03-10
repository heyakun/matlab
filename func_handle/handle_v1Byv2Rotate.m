function [res_P] = handle_v1Byv2Rotate(P,A,cta)
%V1BYV2ROTATE 此处显示有关此函数的摘要
%   此处显示详细说明

% 假定向量P绕单位向量A旋转角度θ，得到新的向量P'，则：
% P'=P * cosθ + (A×P)sinθ +A(A·P)(1 - cosθ)
% 其中A为单位向量，旋转角度θ为逆时针方向旋转的角度。
% 假定向量P的坐标为（px，py，pz），向量A的坐标为（ax，by，cz）
% 且：
%  AXP = [ay * pz- az * py, ax * pz- az * px , ax * py- ay * px];
%  A·P = ax * px + ay * py + az * pz
res_P = P*cos(cta)+cross(A,P)*sin(cta)+A*(dot(A,P)*(1-cos(cta)));



end

