function [] = drawAllCorner(cta_in,CornerCell)
%DRAWALLCORNER 此处显示有关此函数的摘要
%   此处显示详细说明
figure(2)
clf
    for h = 1: length(CornerCell) 
        drawCorner(cta_in,180-CornerCell{h})
        hold on 
    end
end

