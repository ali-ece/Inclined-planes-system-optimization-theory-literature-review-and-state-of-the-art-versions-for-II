%% Iteration-baed SIPO algorithm for IIR filter design

clc       ;
clear all ;
close all ;
format shortg

prompt   = {'Please enter the number of run:'}       ;
title    = 'SIPO Algorithm'                          ;
dims     = [1 45]                                    ;
nline    = 1                                         ;
definput = {'1','a'}                                 ;
answer   = inputdlg(prompt,title,dims,definput)      ;
Run_Num  = answer(1,:)                               ;
Run_Num  = str2num(Run_Num{:})                       ;

prompt   = {'maxt','npop' ,'F','Beta','c','m_Ratio'}  ;
title    = 'SIPO parameters'                          ;
nline    = 1                                          ;
dims     = [1 45]                                     ;
definput = {'200','50','1','0.8','2','0.2','a'}       ; 
answer   = inputdlg(prompt,title,dims,definput)       ;
maxt     = answer(1,:); maxt    = str2num(maxt{:})    ;
npop     = answer(2,:); npop    = str2num(npop{:})    ;
F        = answer(3,:); F       = str2num(F{:})       ;
Beta     = answer(4,:); Beta    = str2num(Beta{:})    ;
c        = answer(5,:); c       = str2num(c{:})       ;
m_Ratio  = answer(6,:); m_Ratio = str2num(m_Ratio{:}) ;


n         = 0                         ;
Bests     = zeros(1       , Run_Num ) ; 
BestsPop  = zeros(Run_Num , 2       ) ; %varaible number
BestsCnvg = zeros(Run_Num , 200     ) ; % numofruns
RunTime   = zeros(1       , Run_Num ) ;
NoU_index = zeros(Run_Num , 1       ) ;
Stable    = 0                         ;
NoU       = 0                         ; % Number of Unstable filters

for n = 1:Run_Num
tic
n

%% IIR Filter Fitness

[Hfilt Wfilt] = IIR_main();

%%
% Function_name               = 'F8'
% [lb,ub,dim,fobj]            = Get_Functions_details(Function_name);
% costfunction                = fobj;     

nvar    = 2        ; % Exp. 1_1:2, Exp. 1_2:4;  Exp. 2_1:4, Exp. 2_2:6;  Exp. 3_1:9; Exp. 3_2=11;
varsize = [1 nvar] ;
varmin  = -1.2     ;
varmax  = +1.2     ;

%%
N       = rand(size(Hfilt,1),1);

%%

%% SIPO parameters
% npop    = 50;
% maxt    = 200;
%%
empty_ball.position     =[];
empty_ball.cost         =[];
empty_ball.velocity     =[];
empty_ball.acceleration =[];

ball             = repmat(empty_ball,npop,1);
globalbest.cost  = inf;

for i = 1:npop
  
    
    ball(i).position       = unifrnd(varmin,varmax,varsize);
    ball(i).velocity       = zeros(varsize);
    ball(i).Acceleration   = zeros(varsize);
    ball(i).sbetter        = zeros(varsize);
    ball(i).mean           = zeros(varsize);
    ball(i).cost           = Fitness(ball(i).position,Hfilt,Wfilt,N);
    if ball(i).cost < globalbest.cost
       globalbest.position = ball(i).position;
       globalbest.cost     = ball(i).cost;    
   end
end

bests = zeros(maxt,1);
T     = m_Ratio.*maxt;  
%% 
for t = 1:maxt
     
    sumcost = 0;
    s       = 1;
    for i= 1:npop
        ball(i).sbetter = ball(i).position;
            for j= 1:npop
            df = ball(j).cost - ball(i).cost;
            if df < 0
               ball(i).sbetter = ball(i).sbetter + ball(j).position;
               s               = s+1;
            end
        end
        ball(i).mean         = ((ball(i).sbetter) ./ s);
       
        
        P_MEAN = F.*(maxt./t);          
        k1     = (1./t)^(Beta) ;             
        k2     = c ./ (1 + exp( - (t-T)));   
        
        ball(i).velocity    = globalbest.position-ball(i).position;      
        ball(i).Acceleration = P_MEAN .* ball(i).mean - ball(i).position; 
           
        ball(i).position = ball(i).position + ...
                          k1 .* (ball(i).Acceleration) .* rand(varsize)+...
                          k2 .* ball(i).velocity .* rand(varsize); 
        
        ball(i).position = min(max(ball(i).position,varmin),varmax);
        ball(i).cost     = Fitness(ball(i).position,Hfilt,Wfilt,N);
      
        if ball(i).cost < globalbest.cost
           globalbest.position  = ball(i).position;
           globalbest.cost      = ball(i).cost; 
        end
       bests(t) = globalbest.cost; 
       sumcost   = sumcost+ball(i).cost;
    end
    
disp(['Iteration' num2str(t) ':bestcost=' num2str(bests(t))]);
meanfits(t) = sumcost/npop;

end

BestsCnvg(n,:)      = bests                         ;
Bests(n)            = bests(t-1)                    ; 
BestsPop(n,:)       = globalbest.position           ;
RunTime(n)          = toc                           ;
[Bsoa Asoa Z_f P_f] = Matching(globalbest.position) ;
Stable              = abs(P_f)                      ;
if any(Stable > 1)
    NoU          = NoU + 1 ;
    NoU_index(n) = n       ;
end


end
%         disp([' ']);
        disp([' ']);
        disp(['                   SIPO                         ']);
        disp(['-----------------------------------------------']);
        disp(['Number of run     = ' num2str(Run_Num)]);
        disp([' ']);
        disp([' ']);
        disp(['****************    Statistical indexes : Time    ****************']);
        disp(['------------------------------------------------']);
        disp(['Per run            = ' num2str(RunTime)]);
        disp(['Average            = ' num2str(mean(RunTime))]);
        disp(['Standard deviation = ' num2str(std(RunTime))]);
        disp(['Maximum            = ' num2str(max(RunTime))]);
        disp(['Minimum            = ' num2str(min(RunTime))]);
        
   
%         disp([' ']);
        disp([' ']);
        disp(['*****************   Statistical indexes : Fitness    ****************']);
        disp(['-----------------------------------------------']);
        disp(['Number of run      = ' num2str(Run_Num)]);
        disp(['Best cost per run  = ' num2str(Bests)]);
        disp(['Average            = ' num2str(mean(Bests))]);
        disp(['Standard deviation = ' num2str(std(Bests))]);
        disp(['Maximum            = ' num2str(max(Bests))]);
        disp(['Minimum            = ' num2str(min(Bests))]);
        
        
%         disp([' ']);
        disp([' ']);
        disp(['*****************  Instability ****************']);
        disp(['-----------------------------------------------']);
        disp(['Nomber of Unstable Filters      = ' num2str(NoU)]);
        disp([' ']);
        
%% Implementation of IIR SIPO *******************************

[minimum index] = min(Bests);

disp([ ' Best Solution = '  num2str(BestsPop(index,:))])
[Bsoa Asoa Z_f P_f] = Matching(BestsPop(index,:))
IIR_main();

figure(1);
plot(BestsCnvg(index,:),'.b','LineWidth',1);
legend('Bests')
xlabel('Iteration')
ylabel('Fitness')

figure(2);
zplane(Z_f,P_f); %%% Displays the poles and zeros of discrete-time systems.
legend('Zero','Pole');
xlabel('Real Part');
ylabel('Imaginary Plot');
% title('Pole-Zero Plot in SIPO');

figure(3);
H = abs(Hfilt);
Hdb=20*log10(H);
plot(Wfilt/512,Hdb);grid