%% PSO for IIR filter design
clc;
clear all;
close all;
format shortg

prompt   = {'Please enter the number of run:'};
title    = 'PSO Algorithm';
dims     = [1 45];
nline    = 1;
definput = {'1','a'};
answer   = inputdlg(prompt,title,dims,definput)
Run_Num  = answer(1,:);Run_Num=str2num(Run_Num{:});

n  = 0;
for n = 1:Run_Num
tic
n

%% IIR Filter Fitness

[Hfilt Wfilt] = IIR_main();

npop = 50;
nvar = 11;
w    = 1;

maxit = 200;
wdamp = 0.99;
c1    = 2;
c2    = 2;

xmin  = -2 ;
xmax  = +2 ;
dx    =xmax-xmin ;
vmax  =0.1*dx    ;
empty_particle.position  =[] ;
empty_particle.velocity  =[] ;
empty_particle.cost      =[] ;
empty_particle.pbest     =[] ;
empty_particle.pbestcost =[] ;

particle  = repmat(empty_particle,npop,1) ;
N         = rand(size(Hfilt,1),1)         ;
gbest     = zeros(maxit,nvar)             ;
gbestcost = zeros(maxit,1)                ;
for it = 1:maxit
    if it == 1
        gbestcost(1) = inf;
        for i = 1:npop
            particle(i).velocity = zeros(1,nvar)                  ;
            particle(i).position = xmin+(xmax-xmin).*rand(1,nvar) ;
            %%%%%%%%%%%%%%%%%%%%
           particle(i).cost = Fitness(particle(i).position,Hfilt,Wfilt,N) ;
            %%%%%%%%%%%%%%%%%%%%
            particle(i).pbest     = particle(i).position ;
            particle(i).pbestcost = particle(i).cost     ;
            
            if particle(i).pbestcost<gbestcost(it)
                gbest(it,:)   = particle(i).pbest     ;
                gbestcost(it) = particle(i).pbestcost ;
            end
        end
    else
        gbest(it,:)   = gbest(it-1,:)   ;
        gbestcost(it) = gbestcost(it-1) ;
        for i = 1:npop
            particle(i).velocity = w*particle(i).velocity...
                                +c1*rand*(particle(i).pbest-particle(i).position)...
                                +c2*rand*(gbest(it,:)-particle(i).position)  ;
                            
            particle(i).velocity = min(max(particle(i).velocity,-vmax),vmax) ;
            
            particle(i).position = particle(i).position+particle(i).velocity ;
            
            particle(i).position = min(max(particle(i).position,xmin),xmax)  ;
          %%%%%%%%%%%%%%%%%%% 
          particle(i).cost = Fitness(particle(i).position,Hfilt,Wfilt,N)  ;
          %%%%%%%%%%%%%%%%%%%
            if particle(i).cost<particle(i).pbestcost
                particle(i).pbest     = particle(i).position ;
                particle(i).pbestcost = particle(i).cost     ;

                if particle(i).pbestcost<gbestcost(it)
                    gbest(it,:)   = particle(i).pbest     ;
                    gbestcost(it) = particle(i).pbestcost ;
                end
            end
        end
    end
  
    disp(['Iter= ' num2str(it) ' // Best Cost = ' num2str(gbestcost(it))]);
    
    
    w = w*wdamp ;
end

Bests(n)   = gbestcost(it) ;
RunTime(n) = toc           ;
end

        disp([' ']);
        disp([' ']);
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
        
   
        disp([' ']);
        disp([' ']);
        disp(['*****************   Statistical indexes : Fitness    ****************']);
        disp(['-----------------------------------------------']);
        disp(['Number of run      = ' num2str(Run_Num)]);
        disp(['Best cost per run  = ' num2str(Bests)]);
        disp(['Average            = ' num2str(mean(Bests))]);
        disp(['Standard deviation = ' num2str(std(Bests))]);
        disp(['Maximum            = ' num2str(max(Bests))]);
        disp(['Minimum            = ' num2str(min(Bests))]);

%% Implementation of IIR IIPO *******************************
disp([ ' Best Solution = '  num2str(gbest(it,:))])
[Bsoa Asoa Z_f P_f] = Matching(gbest(it,:))
IIR_main();

figure(1);
plot(gbestcost,'.b','LineWidth',1);
legend('Bests')
xlabel('Iteration')
ylabel('Fitness')

figure(2);
zplane(Z_f,P_f); %%% Displays the poles and zeros of discrete-time systems.
legend('Zero','Pole');
xlabel('Real Part');
ylabel('Imaginary Plot');
% title('Pole-Zero Plot in IPO');

figure(3);
H = abs(Hfilt);
Hdb=20*log10(H);
plot(Wfilt/512,Hdb);grid
% title('Magnitude response of a chebyshev I bandpass filter');
