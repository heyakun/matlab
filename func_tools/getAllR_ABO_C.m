function [RadiusC] = getAllR_ABO_C(state)
%GETALLR_ABO_C �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
m = length(state.A{1})-1;
n = length(state.A{1}{1});
[~,RadiusC.O] = getEachR(state);
RadiusC.A = getEachR_Ai(state);
RadiusC.B = getEachR_Bi(state);

end

