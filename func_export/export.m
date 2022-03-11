function [] = export(filename,sheet,Cell,cta_in,Ylabel)
%EXPORT 此处显示有关此函数的摘要
%   此处显示详细说明
% filename = "r_i";

% 要导出的数据 是Cell类型
frames = length(Cell{1});
max_range = frames+1; 
col_count = length(Cell);
xls_arr=['B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

in_var = {'cta_in'};
cta_in_deg = (rad2deg(cta_in))';
cta_in_range = "A2:A"+num2str(max_range);
xlswrite(filename,in_var,sheet,"A1:A1");
xlswrite(filename,cta_in_deg,sheet,cta_in_range);
for col = 1:col_count
    
    
    label_pos = xls_arr(col)+"1"+":"+xls_arr(col)+"1";
    label = {[Ylabel,'_',num2str(col)]};
    xlswrite(filename,label,sheet,label_pos);
    
    
    arr =double((Cell{col})');
    data_range = xls_arr(col)+"2"+":"+xls_arr(col)+num2str(max_range);
    xlswrite(filename,arr,sheet,data_range)
     
end
end

