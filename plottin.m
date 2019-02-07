function [] = plottin(t2,n2)
t2 = t2 / 60;  %convert time from seconds to minutes

figure;
plot(t2,n2(:,1),'b',t2,n2(:,2),'c',t2,n2(:,3),'r','LineWidth',2)
 
legend('25','37','42','Location','northwest');
        
        
        
