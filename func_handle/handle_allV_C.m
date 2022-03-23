function [] = handle_allV_C(state,cta_in)
    for i=13:30
        [~,Vi_C,~] = getEachV_2(state{5}{i});
        %µ¼³ö
%         export_array('model5x',['Vi',num2str(i)],Vi,cta_in,'Vi')
        export_array('model5x',['Vi_C',num2str(i)],Vi_C,cta_in,'Vi')
%         export_array('model5x',['Vi_cta_in',num2str(i)],Vi_ratio,cta_in,'Vi')
    end
end

