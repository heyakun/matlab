function [] = export_Ri_C(filename,RadiusC,cta_in)
%EXPORT_R_I 此处显示有关此函数的摘要
%   此处显示详细说明
export(['model',filename,'特征半径'],'RiO',RadiusC.O,cta_in,'ROi')
export(['model',filename,'特征半径'],'RiA',RadiusC.A,cta_in,'RAi')
export(['model',filename,'特征半径'],'RiB',RadiusC.B,cta_in,'RBi')
end

