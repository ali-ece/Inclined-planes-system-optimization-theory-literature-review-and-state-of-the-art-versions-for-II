clear all
close all
clc

const   = 200;
F       = 1;
% Beta    = 1;
% c       = 0.5;
Beta    = [0 1 2 0 2 1 0.5 0.5 2 1 0.5 0];
c       = [2 0 0 1 0.5 0.5 2 1 2 1 0.5 0];
m_Ratio = 0;

T       = m_Ratio.*const;

for i = 1:12
    
    for t = 1:const
    P_MEAN = F.*(const./t);
    k1(t)  = (1./t)^(Beta(i));              
    k2(t)  = c(i) ./ (1 + exp( - (t-T)));
    end
    
subplot(3,4,i);
plot(1:const,k1,'r:','LineWidth',6);
hold on
plot(1:const,k2,'b--','LineWidth',6);
title(['\color{red} \it \beta:  ',num2str(Beta(i)),'\color{blue} \it c:  ',num2str(c(i))]);
hold off
end
legend('k_1','k_2');
xlabel('Iterations');
ylabel('Value');
% plot(1:const,k1,'k');
% hold on
% plot(1:const,k2,'b');
% hold off
    