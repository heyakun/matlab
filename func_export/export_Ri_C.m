function [] = export_Ri_C(filename,RadiusC,cta_in)
%EXPORT_R_I �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
export(['model',filename,'�����뾶'],'RiO',RadiusC.O,cta_in,'ROi')
export(['model',filename,'�����뾶'],'RiA',RadiusC.A,cta_in,'RAi')
export(['model',filename,'�����뾶'],'RiB',RadiusC.B,cta_in,'RBi')
end

