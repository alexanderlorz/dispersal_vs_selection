%calculates the temperature in each of the 3 vessels
function [t0_,tem_]=temperatur(T)
global t_delay opts r_pipe l_pipe speed_pump
t_delay = r_pipe^2*l_pipe*pi/speed_pump;
sol = dde23(@temp,[t_delay],@temphist,[0 T],opts);
t0_ = sol.x; tem_ = sol.y';




function dydt = temp(t,y,Z)
global tem1 tem2 tem3 speed_pump heat_transfer heat_transfer_pipe r_pipe t_delay
ylag = Z(:,1);
m=.036 - floor(t/(60*30))*1e-3;% in kg  %1ml=1e-3kg less every 30 minutes
r = .0145; %radius of the vessel
h_con =.016; %height of the cone

%height of the cylinder depending on the mass in the vessel
h_cyl = (m/1000-(1/3)*pi*r^2*h_con)/(pi*r^2);%1000 density of water
A=pi*r^2*h_cyl+pi*r*sqrt(r^2+h_con^2);
C_p = 4185.5; %heat capacity of water
density=1e3; % in kg/m^3
f_tube = heat_transfer*A/(m*C_p);

A_pipe = 2*pi*(r_pipe*1);  %surface area; length normalized to 1m

m_per_pipe = pi*r_pipe^2*1* density; %length normalized to 1m
f_pipe = heat_transfer_pipe*A_pipe/(m_per_pipe * C_p);


f_exp = exp(-f_pipe*t_delay);
t_a = 25; %ambient temperature


dydt = f_tube.*[tem1-y(1); tem2-y(2);  tem3-y(3)]... %heat exchange
    +(t_delay<t)*(speed_pump*density/m)*([t_a;t_a;t_a]+...
    [ylag(3)-t_a;ylag(1)-t_a;ylag(2)-t_a]*f_exp-[y(1);y(2);y(3)]); %mixing






%temperature history
function s = temphist(t)
% Constant history function for DDEX1.
global tem1 tem2 tem3
s = [tem1; tem2;  tem3];