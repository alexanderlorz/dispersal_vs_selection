function frac_speed = frac_s(t)
global speed_pump
m=.036  - floor(t/(60*30))*1e-3;% 1ml less every 30 minutes
  
density=1e3; % in kg/m^3
frac_speed = speed_pump*density/m;