
% main code that loops over all dispersal speeds and calculates growth
% over migration


function []=main()
close all
% declares global variables that are used in the subfunctions
global t0 tem i arr KK X0 tem1 tem2 tem3 tem4 tem5 tem6  speed_pump ttt heat_transfer heat_transfer_pipe r_pipe l_pipe t_delay opts


heat_transfer = 342.6975
heat_transfer_pipe = 82.3414



% actual temperatures % nominal temperatures
tem1 = 25.2;  %25
tem2 = 36;  %37
tem3 = 40;%42
tem4 = 26.5;  %28
tem5 = 31;  %34
tem6 = 37; %40

%length of the pipes
l_pipe =  (2.325 +2.195 + 2.005)/3;% = 2.175  %small diameter pipes
r_pipe = .4e-3;

%options for the ODE solver
opts = odeset('AbsTol',1e-8,'RelTol',1e-8);

T = 4*60*60; %total length of the experiments in seconds



arr=[4 3 1];



t30_including0 = (0:8)*30*60;









% flag to switch plotting on (plotflag = 1) and off (plotflag = 0)
plotflag = 1;




% KKtosave(1:5,1:3,1:6) = 0;
% X0tosave(1:5,1:3,1:6) = 0;
% loads KKtosave and X0tosave
% both are an array with size 5,3,6: 5 pump speeds, 3 strains, 6
% temperatures to interpolate between
load('KKX0.mat')


%array of pump speeds in m^3/s
speed_pump_arr =[0. 1.75e-9 5e-9 12e-9 71.5e-9];
%--------------------------------------------
mean_growth_over_immi_diff_speed_pump = [];
sp_pu = [];
col_n123 = [];

%large
upper = speed_pump_arr(5);
lower = speed_pump_arr(5)/25;
stepsize=upper/50;

% small
upper = speed_pump_arr(5)/25;
lower = 0;
stepsize=upper/50;

% medium
upper = 3.85e-9;
lower = 3.25e-9;
stepsize=.3e-9;

for speed_pump = lower:stepsize:upper
    %calculates the temperature on the time interval [0,T]
    [t0,tem]=temperatur(T);
    
    
    
    
    % KKtosave(1:5,1:3,1:6)
    for j = 1:6
        KK_col(1:5,1:3) = KKtosave(1:5,1:3,j);
        KK(1:3,j) = interp1(speed_pump_arr,KK_col,speed_pump,'pchip');
        X0_col(1:5,1:3) = X0tosave(1:5,1:3,j);
        X0(1:3,j) = interp1(speed_pump_arr,X0_col,speed_pump,'pchip');
    end
    
    
    
    
    
    
    
    ttt = [];
    sum_growth_over_immi_fixed_speed_pump = [];
    %------------- %-------------
    i =1
    [t1,n1] = ode45(@cells,[0 T],150*ones(1,3),opts);
    sum_growth_over_immi_fixed_speed_pump= [sum_growth_over_immi_fixed_speed_pump sum_grow_over_immi(t1,n1)];
    
    
    
    
    if plotflag
        plottin(t1,n1);
        title('B42')
    end
    %  %------------- %-------------
    
    i =2
    
    [t2,n2] = ode45(@cells,[0 T],150*ones(1,3),opts);
    sum_growth_over_immi_fixed_speed_pump= [sum_growth_over_immi_fixed_speed_pump sum_grow_over_immi(t2,n2)];
    
    if plotflag
        plottin(t2,n2);
        title('E310')
    end
    
    %  %------------- %-------------
    
    i =3
    
    [t3,n3] = ode45(@cells,[0 T],150*ones(1,3),opts);
    sum_growth_over_immi_fixed_speed_pump= [sum_growth_over_immi_fixed_speed_pump sum_grow_over_immi(t3,n3)];
    if plotflag
        plottin(t3,n3);
        title('E111')
    end
    
    
    mean_growth_over_immi_diff_speed_pump = [mean_growth_over_immi_diff_speed_pump mean(sum_growth_over_immi_fixed_speed_pump)/19];
    sp_pu =  [sp_pu speed_pump];
    
    
    
    n1_t30= interp1(t1,n1,t30_including0);
    n2_t30= interp1(t2,n2,t30_including0);
    n3_t30= interp1(t3,n3,t30_including0);
    
    
    col_n123 = [col_n123, [speed_pump;n1_t30(2:9,1);n1_t30(2:9,2);n1_t30(2:9,3);n2_t30(2:9,1);n2_t30(2:9,2);n2_t30(2:9,3);n3_t30(2:9,1);n3_t30(2:9,2);n3_t30(2:9,3)]];
    
end






temppp = [sp_pu;mean_growth_over_immi_diff_speed_pump];


filename = ['_speed_pump__',num2str(lower/1e-9),'to',num2str(upper/1e-9),'ul_per_s.'];
dlmwrite(['growth_over_immigration',filename,'csv'],temppp,',')

dlmwrite(['nnn',filename,'csv'],col_n123,',')



figure; plot(sp_pu,mean_growth_over_immi_diff_speed_pump,'LineWidth',2);
title('growth / immigration');
saveas(gcf,['growth_over_immigration',filename,'jpg']);




