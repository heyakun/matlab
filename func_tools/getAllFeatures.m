function [Feature] = getAllFeatures(state)
%GETALLFEATURES �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%% ��ȡȫ�����������������ݻ��ȼ���
[Vi,Vi_C,Vi_ratio] = getEachV_2(state);
%% ��ȡȫ�������뾶
RadiusC=getAllR_ABO_C(state);
%% ��ȡȫ�������߶�
maxH = getMaxH(state);

Feature.Vi = Vi;
Feature.Vi_C = Vi_C;
Feature.Vi_ratio = Vi_ratio;
Feature.RadiusC = RadiusC;
Feature.maxH = maxH;

end

