function [] = exportAllFeatures(filename,Feature,cta_in)
%EXPORTALLFEATURES �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

export(['model',filename,'����'],'RiO',Feature.RadiusC.O,cta_in,'ROi')
export(['model',filename,'����'],'RiA',Feature.RadiusC.A,cta_in,'RAi')
export(['model',filename,'����'],'RiB',Feature.RadiusC.B,cta_in,'RBi')
export(['model',filename,'����'],'V',{Feature.Vi},cta_in,'Vi')
export(['model',filename,'����'],'����V',{Feature.Vi_C},cta_in,'����V')
export(['model',filename,'����'],'�ݻ���',{Feature.Vi_ratio},cta_in,'�ݻ���')
export(['model',filename,'����'],'maxH',{Feature.maxH},cta_in,'����H/a')
end

