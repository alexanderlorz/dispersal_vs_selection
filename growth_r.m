function growth_rates = growth_r(t)
global t0 tem i KK X0 tem1 tem2 tem3 tem4 tem5 tem6 
%growth rate at the different temperatures
growth_ratesNoPump = KK(i,1:6).* (t > X0(i,1:6));  

 

for j = 1:3
    %obtains the temperature at time t by interpolation
    tem_now(j) = interp1(t0,tem(:,j),t); 
    %obtains the growth rate at that temperature by interpolation
    growth_rates(j) = interp1([tem1 tem2 tem3 tem4 tem5 tem6],growth_ratesNoPump,tem_now(j),'pchip');
end
