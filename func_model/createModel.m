function [state,newCorner] = createModel(m,n,a,p,frames)
% global a p n m frames
% p = 15;
% a = 20;
% n = 16;
% m = 5;
% frames = 20;
digits(5)
Corner = cell(1,frames);
for fra_num=1:frames
syms Cin  x
Cin = linspace(0.9*pi/2,0.1*pi/2,frames);
Cta = Cin(fra_num) + pi/2;
%��O0 (��pֱ�����)
O0M = R('y', pi/n) * T('z', p);
O0 = O0M(1:4,4);
O0_s = point_by_axiosY_array(O0,n);
% clf
% arr =double(vpa(O0_s)');
% F = 1:n;
% patch('Faces',F,'Vertices',arr,'FaceColor',[0.3010 0.7450 0.9330])
% colorbar
% useAxios([0 0 1])
%��F1(������ֱ�����)
H_B1M = O0M * R('x', Cta) * T('z', -a);
B1 = H_B1M*[0 0 0 1]';
B1_s = point_by_axiosY_array(B1,n);
%��A1
syms H_Cta_12 H_Cta_23 H_Cta_34
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_B1M * H_Q12;
A1 = A1M*[0 0 a 1]';
f =matlabFunction(A1(1));
H_Cta_12 = fsolve(f,1.57);
%H_Cta_12Ϊ����ֵ ת�ɽǶ�
H_Cta_12_deg =vpa(rad2deg(H_Cta_12),5);

temp_angle= [];
Corner{fra_num} = [temp_angle,H_Cta_12_deg];
temp_angle= Corner{fra_num};
%%%%%%%%%%%%%%%%%%%%%%
H_Q12 = R('z', -H_Cta_12) * R('x', pi/2);
A1M = H_B1M * H_Q12;
A1 = A1M*[0 0 a 1]';

A1_s = point_by_axiosY_array(A1,n);

% A1_arr = double(vpa(A1_s)');
% O0_arr = double(vpa(O0_s)');
% col_1=[0.9290 0.6940 0.1250];
% for i =1:n
%     if(i == 1)
%         point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(n,:),col_1)
%     else
%         point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(i-1,:),col_1)
%     end
% end
% col = [0.8500 0.3250 0.0980];%��ɫ
% face_array_end(O0_s,A1_s,B1_s,n,col)
state.O{fra_num}{1} = O0_s;
state.B{fra_num}{1} = B1_s;
state.A{fra_num}{1} = A1_s;


%%%%%%%%%%%%%%%%%%%%%%%���Դ��� �Ӷ�������һ�㵥Ԫ
[O1,B2,B2M,angle0,anglex] = struct_0(A1M,H_Cta_23,H_Cta_34,a,n);
Corner{fra_num} = [temp_angle,vpa(rad2deg([angle0,anglex]))];
temp_angle= Corner{fra_num};

O1_s = point_by_axiosY_array(O1,n);
% col=[0.3010 0.7450 0.9330];%��ɫ
% face_array_start(O1_s,B1_s,A1_s,n,col)
B2_s = point_by_axiosY_array(B2,n);
% face_array_end(B2_s,O1_s,B1_s,n,col)
%
state.O{fra_num}{2} = O1_s;
state.B{fra_num}{2} = B2_s;
%%%%%%%%%%%%%%%%%%%%%%%���Դ���:�ӵ�һ�㵽m�㵥Ԫ- 
mm = m;
prev_M = B2M;
% prev_B_s = B2_s;
% prev_O_s = O1_s;
cur_pos = 2;
angle_sum = 0;

for index =1:mm
   if(mod(index,2) == 0)%ż����
      syms angle_1 angle_2 angle_3 angle_4
      [pA3,pB3,pB3M,angle_1,angle_2] = struct_3(prev_M,angle_1,angle_2,a,n); 
      [pO3,pB4,pB4M,angle_3,angle_4 ] = struct_1(pB3M,angle_3,angle_4,a,n);
      pA3_s = point_by_axiosY_array(pA3,n);
      pB3_s = point_by_axiosY_array(pB3,n);
      pO3_s = point_by_axiosY_array(pO3,n);
      pB4_s = point_by_axiosY_array(pB4,n);
      %�ռ��㼯
      state.A{fra_num}{cur_pos} = pA3_s;
      state.B{fra_num}{cur_pos} = pB3_s;
      state.O{fra_num}{cur_pos+1} = pO3_s;
      state.B{fra_num}{cur_pos+1} = pB4_s;
      %�ռ�ת��
      
      Corner{fra_num} = [temp_angle,vpa(rad2deg([angle_1 angle_2 angle_3 angle_4]),5)];
      temp_angle = Corner{fra_num};
      angle_sum = angle_sum+4;
      %����ͼ��
%       face_array_start(pA3_s,pO2_s,pA2_s,n,col)
%       face_array_end(pB3_s,pA3_s,pO2_s,n,col)
%       col=[0.3010 0.7450 0.9330];%��ɫ
%       face_array_start(pO3_s,pB3_s,pA3_s,n,col)
%       face_array_end(pB4_s,pO3_s,pB3_s,n,col)
      
      prev_M = pB4M;
%       prev_B_s = pB4_s;
%       prev_O_s = pO3_s;
      cur_pos = cur_pos +1;
   else 
       syms angle_5 angle_6
       [pA2,pO2,pO2M,angle_5,angle_6] = struct_2(prev_M,angle_5,angle_6,a,n);
       pA2_s = point_by_axiosY_array(pA2,n);
       pO2_s = point_by_axiosY_array(pO2,n);
       
       %�ռ��㼯
       state.A{fra_num}{cur_pos} = pA2_s;
       state.O{fra_num}{cur_pos+1} = pO2_s;
       %�ռ�ת��
       Corner{fra_num} = [temp_angle,vpa(rad2deg([angle_5 angle_6]),5)];
       temp_angle = Corner{fra_num};
       angle_sum = angle_sum+2;
       %��ͼ
%        face_array_start(pA2_s,prev_B_s,prev_O_s,n,col)
%        col = [0.9290 0.6940 0.1250];%��ɫ
%        face_array_end(pO2_s,pA2_s,prev_B_s,n,col)       
       prev_M = pO2M;
       cur_pos = cur_pos+1;
   end
end
%%%%%%%%%%%%%%%%%%%%%%%--���Գɹ�
end
%%%%%%%%%%%%
newCorner = cell(1,angle_sum+3);
    for fraNum = 1:frames
        for angle_num = 1: angle_sum+3
            newCorner{angle_num}(fraNum) =  Corner{fraNum}(angle_num);
        end
    end
%%%%%%%%%%%%%
end

