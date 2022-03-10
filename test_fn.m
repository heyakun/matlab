function [] = test_fn()
% v1 = [100,0,0 ];
% v2 = [-2,-2,0];
% a = [0,0,1];
% 
% syms cta
% 
% v = handle_v1Byv2Rotate(v1,a,cta);
% f =matlabFunction(v-v2);
% res_cta = fsolve(f,1.57);
% res_cata_vpa = vpa(rad2deg(res_cta),5);
% res_cata_vpa

syms xxz


xxz =vpasolve(sin(xxz)-0.5,xxz,[1,3.14]);
disp(xxz)
res = double(xxz) ;
end

