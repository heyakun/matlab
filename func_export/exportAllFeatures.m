function [] = exportAllFeatures(filename,Feature,cta_in)
%EXPORTALLFEATURES 此处显示有关此函数的摘要
%   此处显示详细说明

export(['model',filename,'特征'],'RiO',Feature.RadiusC.O,cta_in,'ROi')
export(['model',filename,'特征'],'RiA',Feature.RadiusC.A,cta_in,'RAi')
export(['model',filename,'特征'],'RiB',Feature.RadiusC.B,cta_in,'RBi')
export(['model',filename,'特征'],'V',{Feature.Vi},cta_in,'Vi')
export(['model',filename,'特征'],'特征V',{Feature.Vi_C},cta_in,'特征V')
export(['model',filename,'特征'],'容积比',{Feature.Vi_ratio},cta_in,'容积比')
export(['model',filename,'特征'],'maxH',{Feature.maxH},cta_in,'特征H/a')
end

