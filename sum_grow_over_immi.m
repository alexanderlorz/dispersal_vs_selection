% sums growth over immigration
function summ = sum_grow_over_immi(tt,nn)
t10min = (0:10:4*60)*60;
growth_t =[];
influx_t =[];
for j = 1:length(tt)
    growth_t = [growth_t; growth_r(tt(j)).*nn(j,1:3)];
    influx_t = [influx_t; frac_s(tt(j))*[nn(j,3) nn(j,1) nn(j,2)]];
end 
summ = sum(interp1(tt,growth_t./influx_t,t10min));