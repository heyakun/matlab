function [] = export_r_i(cta_in,P_Oset_radius)
%EXPORT_R_I 此处显示有关此函数的摘要
%   此处显示详细说明


filename = "r_i";
frames = length(P_Oset_radius{1});
max_range = frames+1; 
col_count = length(P_Oset_radius);
xls_arr=["B","C","D","E","F","G","H","I"];
index = ["1","2","3","4","5","6","7","8","9","10"];

cta_in_deg = (rad2deg(cta_in))';
cta_in_range = "A2:A"+num2str(max_range);
xlswrite(filename,"cta_in","sheet1","A1:A1");
xlswrite(filename,cta_in_deg,"sheet1",cta_in_range);
for col = 1:col_count
    
    label_pos = xls_arr(col)+"1"+":"+xls_arr(col)+"1";
    label = ("R"+index(col));
    xlswrite(filename,label,"sheet1",label_pos);
    
    
    arr =double(   (P_Oset_radius{col})'  );
    data_range = xls_arr(col)+"2"+":"+xls_arr(col)+num2str(max_range);
    xlswrite(filename,arr,"sheet1",data_range)
     
end
    


end

