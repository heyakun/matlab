function [] = drawAllCorner(cta_in,CornerCell)
%DRAWALLCORNER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
figure(2)
clf
    for h = 1: length(CornerCell) 
        drawCorner(cta_in,180-CornerCell{h})
        hold on 
    end
end

