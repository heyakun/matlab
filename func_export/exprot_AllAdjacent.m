function [] = exprot_AllAdjacent(tag,Adjacent,cta_in)
%EXPORT_ALLSPHERE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
m = length(Adjacent.Bi);
model_m = m-1;

for mm = 1: m
    export_array(['Adjacent',tag],['Adj',tag,'Bi',num2str(mm)],Adjacent.Bi{mm},cta_in,'Bi')
    if(mod(mm,2)==0 && mm <= m)
        export_array(['Adjacent',tag],['Adj',tag,'Oi',num2str(mm)],Adjacent.Oi{mm},cta_in,'Oi')
    end
end

end

