function [res_cata_vpa] = get2PlaneCorner(v1,v2,A)
%GET2PLANEANGLE 此处显示有关此函数的摘要
% 此处显示详细说明
%参数 v1 v2 分别是两个面的法向量
%参数 A 是 旋转轴
%函数handle_v1Byv2Rotate 得到的是一个方程，temp_v是列向量？
%如果是列向量与v2相减会
syms cta

temp_v = handle_v1Byv2Rotate(v1,A,cta);
f =matlabFunction(temp_v-v2);
options = optimoptions('fsolve','Algorithm','levenberg-marquardt');
res_cta = fsolve(f,1.57,options);
res_cata_vpa = vpa(rad2deg(res_cta),5);
end

