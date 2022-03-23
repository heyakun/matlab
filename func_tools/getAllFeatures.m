function [Feature] = getAllFeatures(state)
%GETALLFEATURES 此处显示有关此函数的摘要
%   此处显示详细说明
%% 获取全部体积，特征体积，容积比计算
[Vi,Vi_C,Vi_ratio] = getEachV_2(state);
%% 获取全部特征半径
RadiusC=getAllR_ABO_C(state);
%% 获取全部特征高度
maxH = getMaxH(state);

Feature.Vi = Vi;
Feature.Vi_C = Vi_C;
Feature.Vi_ratio = Vi_ratio;
Feature.RadiusC = RadiusC;
Feature.maxH = maxH;

end

