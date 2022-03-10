function [] = drawModel(state)
frames = length(state.A);
n = length(state.A{1}{1});
m = length(state.A{1})-1;
for fra_num = 1 : frames
    Aset = state.A{fra_num};
    Bset = state.B{fra_num};
    Oset = state.O{fra_num};
    A1_s = Aset{1};
    O0_s = Oset{1};
    B1_s = Bset{1};
    A1_arr = double(vpa(A1_s)');
    O0_arr = double(vpa(O0_s)');
    pause(0.1)
    figure(1)
    clf
arr =double(vpa(O0_s)');
F = 1:n;
%��ʱ����-���������
patch('Faces',F,'Vertices',arr,'FaceColor',[0.3010 0.7450 0.9330])
colorbar
useAxios([0 0 1])
    
    col_1=[0.9290 0.6940 0.1250];
%     ��ʱ����-����������
    for i =1:n
        if(i == 1)
            point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(n,:),col_1)
        else
            point3ToFace(A1_arr(i,:),O0_arr(i,:),O0_arr(i-1,:),col_1)
        end
    end
    col = [0.8500 0.3250 0.0980];%��ɫ
    %��ʱ��ɫ--������㵥Ԫ
    col = [1 1 1];
    face_array_end(O0_s,A1_s,B1_s,n,col)
    %%%%%%%%%%%%%%%%%%%%%������Ԫ
    B2_s = Bset{2};
    O1_s = Oset{2};
 
    col=[0.3010 0.7450 0.9330];%��ɫ
    %��ʱ��ɫ
%     col = [1 1 1];
    face_array_start(O1_s,B1_s,A1_s,n,col)
    face_array_end(B2_s,O1_s,B1_s,n,col)
    
    %%%%%%%%%%%%%%%%%%%�ӵ�һ�㵽��m�㵥Ԫ
    prev_B_s = B2_s;
    prev_O_s = O1_s;
    cur_pos = 2;
    for index = 1:m
        if(mod(index,2) == 0)
             %�ռ��㼯
             pA3_s = state.A{fra_num}{cur_pos};
             pB3_s = state.B{fra_num}{cur_pos};
             pO3_s = state.O{fra_num}{cur_pos+1};
             pB4_s = state.B{fra_num}{cur_pos+1};
              %����ͼ��
              face_array_start(pA3_s,pO2_s,pA2_s,n,col)
              face_array_end(pB3_s,pA3_s,pO2_s,n,col)
              col=[0.3010 0.7450 0.9330];%��ɫ
                  %��ʱ��ɫ
%     col = [1 1 1];
              if (index ~= m)
                 face_array_start(pO3_s,pB3_s,pA3_s,n,col)
                 face_array_end(pB4_s,pO3_s,pB3_s,n,col)
              end

              
              prev_B_s = pB4_s;
              prev_O_s = pO3_s;
              cur_pos = cur_pos +1;
        else
           %�ռ��㼯
           pA2_s = state.A{fra_num}{cur_pos};
           pO2_s = state.O{fra_num}{cur_pos+1};
           %��ͼ
           face_array_start(pA2_s,prev_B_s,prev_O_s,n,col)
           col = [0.9290 0.6940 0.1250];%��ɫ
               %��ʱ��ɫ
%     col = [1 1 1];
           if (index ~= m)
               face_array_end(pO2_s,pA2_s,prev_B_s,n,col)
           end
           cur_pos = cur_pos+1;
        end
    end
end

