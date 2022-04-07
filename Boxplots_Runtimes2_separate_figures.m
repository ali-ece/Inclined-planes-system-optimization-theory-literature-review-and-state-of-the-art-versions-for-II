% The Runtime_boxplots of both two modeling forms all examples and cases based on
% 100 independent trials for all algorithms (IPO, MIPO, SIPO, and IIPO)

clc; clear all; close all;
% figure ;
XX = zeros(100,4) ;

%%
%% The first IIR identification form, Example I, Case 1 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case1_O=2\IPO\range -1.2 to +1.2\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case1_O=2\MIPO\range -1.2 to +1.2\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case1_O=2\SIPO\range -1.2 to +1.2\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case1_O=2\IIPO\range -1.2 to +1.2\2.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,1);
figure(1);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The first IIR identification form, Example I, Case 1');


%%
%% The second IIR identification form, Example I, Case 1 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case1_O=2\IPO\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case1_O=2\MIPO\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case1_O=2\SIPO\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case1_O=2\IIPO\1.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,2);
figure(2);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The second IIR identification form, Example I, Case 1');


%%
%% The first IIR identification form, Example I, Case 2 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case1_O=1\IPO\range -1.2 to +1.2\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case1_O=1\MIPO\range -1.2 to +1.2\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case1_O=1\SIPO\range -1.2 to +1.2\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case1_O=1\IIPO\range -1.2 to +1.2\1.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,3);
figure(3);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The first IIR identification form, Example I, Case 2');


%%
%% The second IIR identification form, Example I, Case 2 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case1_O=1\IPO\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case1_O=1\MIPO\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case1_O=1\SIPO\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case1_O=1\IIPO\1.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,4);
figure(4);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The second IIR identification form, Example I, Case 2');


%%
%% The first IIR identification form, Example II, Case 1 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case3_O=5\IPO\range_1.2to1.2\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case3_O=5\MIPO\range_1.2to1.2\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case3_O=5\SIPO\range -1.2 to +1.2\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Equal Order\Case3_O=5\IIPO\range_1.2to1.2\3.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,5);
figure(5);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The first IIR identification form, Example II, Case 1');


%%
%% The second IIR identification form, Example II, Case 1 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case3_O=5\IPO\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case3_O=5\MIPO\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case3_O=5\SIPO\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Equal\Case3_O=5\IIPO\1.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,6);
figure(6);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The second IIR identification form, Example II, Case 1');


%%
%% The first IIR identification form, Example II, Case 2 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case3_O=4\IPO\range -1.2 to +1.2\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case3_O=4\MIPO\range -1.2 to +1.2\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case3_O=4\SIPO\range -1.2 to +1.2\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\Without Additive Noise\Reduced Order\Case3_O=4\IIPO\range -1.2 to +1.2\2.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,7);
figure(7);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The first IIR identification form, Example II, Case 2');


%%
%% The second IIR identification form, Example II, Case 2 for IPO, MIPO, SIPO, and proposed IIPO, respectively.

clc; clear all;
XX = zeros(100,4) ;
%%

load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case3_O=4\IPO\1.mat')
index
XX(:,1) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case3_O=4\MIPO\1.mat')
index
XX(:,2) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case3_O=4\SIPO\1.mat')
index
XX(:,3) = RunTime' ;
clearvars -except XX
load('C:\Users\Am-ece\Documents\MATLAB\Optimal design of digital IIR filters by using SIPO\MIPO_Paper\With Additive Noise\Reduced\Case3_O=4\IIPO\1.mat')
index
XX(:,4) = RunTime' ;
clearvars -except XX

%% Boxplots 
% subplot(4,2,8);
figure(8);
boxplot(XX,'notch','on','labels',{'IPO','MIPO','SIPO','proposed IIPO'},'whisker',1);xlabel('Algorithms'); ylabel('Time (s)');title('The second IIR identification form, Example II, Case 2');


