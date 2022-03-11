function [] = export_AllSphere(tag,Sphere,cta_in)
%EXPORT_ALLSPHERE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
m = length(Sphere.Bi);
model_m = m-1;

for mm = 1: m
    export(['Sphere',tag],['ASp',tag,'Bi',num2str(mm)],Sphere.Bi{mm},cta_in,'Bi')
    if(mod(mm,2)==0 && mm < m)
        export(['Sphere',tag],['ASp',tag,'Oi',num2str(mm)],Sphere.Oi{mm},cta_in,'Oi')
    end
end

end

