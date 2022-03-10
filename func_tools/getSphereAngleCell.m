function [Sphere,Adjacent] = getSphereAngleCell(modelState,modelCorner)
%GETSPHEREANGLECELL �˴���ʾ�йش˺�����ժҪ
% �����е��ۺ۽Ƕ��Ž���һ����
%   �˴���ʾ��ϸ˵��
% ���������Ƕ��� 180- �������
 [~,all_angle1_cell]= get2PlaneAngleCell_angle1(modelState);
 [~,all_angle4_cell]= get2PlaneAngleCell_angle4(modelState);
 [~,all_angle_adj_cell]= get2PlaneAngleCell(modelState);
 
 %%%Sphere.Bi{1}{1} ��������
 m = length(modelState.O{1})-2;
 i= 1;
 for mm=1:m
     if(mod(mm,2)==1)
         %����
         Sphere.Bi{mm}{1} = all_angle4_cell{mm};
         i=i+1;
         Sphere.Bi{mm}{2} = modelCorner{i};
         i=i+1;
         Sphere.Bi{mm}{3} = modelCorner{i};
         Sphere.Bi{mm}{4} = all_angle_adj_cell{mm};
         if(mm == m)
             %��������Ҫ����󲹳�һ��4-1=3����
             Sphere.Bi{mm+1}{1} = all_angle_adj_cell{mm};
             i=i+1;
             Sphere.Bi{mm+1}{2} = modelCorner{i};
             i=i+1;
             Sphere.Bi{mm+1}{3} = modelCorner{i};
             Sphere.Bi{mm+1}{4} = all_angle4_cell{mm+1};
         end
         Adjacent.Bi{mm} = all_angle1_cell{mm};
     else
         %ż��
         Sphere.Bi{mm}{1} = all_angle_adj_cell{mm-1};
         i = i+1;
         Sphere.Bi{mm}{2} = modelCorner{i};
         i = i+1;
         Sphere.Bi{mm}{3} = modelCorner{i};
         Sphere.Bi{mm}{4} = all_angle1_cell{mm};
         %---------------------------------
         Sphere.Oi{mm}{1} = all_angle1_cell{mm};
         i = i+1;
         Sphere.Oi{mm}{2} = modelCorner{i};
         i = i+1;
         Sphere.Oi{mm}{3} = modelCorner{i};
         Sphere.Oi{mm}{4} = all_angle4_cell{mm+1};
         
         %���ڽ�
         Adjacent.Bi{mm} = all_angle4_cell{mm};
         Adjacent.Oi{mm} = all_angle_adj_cell{mm};
     end
 end
end
 %---------------------------------
 %����ݸ�
%С��
% j=1  2j-1=1                        j=2                     j=3
% B{1}{1}=?                    B{3}{1}= get4{2}        B{5}{1}= get4{4} 
% B{1}{4}= adj{1}              B{3}{4}= adj{3}
% 
% B{2}{1}= adj{1}              B{4}{1}= adj{3}
% B{2}{4}= get1{2}             B{4}{4}= get1{4}
% 
% O{2}{1} = get1{2}            O{4}{1} = get1{4}
% O{2}{4} = get4{2}            O{4}{4} = get4{4}