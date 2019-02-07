function dndt = cells(t,n)
 
%growth rates
growth_rates = growth_r(t) ;
%volume fraction being transported
frac_speed = frac_s(t);

%ordinary differential equation as in the Supplementary Material
dndt = growth_rates'.*[n(1); n(2); n(3) ]...
    +(frac_speed)*[n(3)-n(1);n(1)-n(2);n(2)-n(3)];