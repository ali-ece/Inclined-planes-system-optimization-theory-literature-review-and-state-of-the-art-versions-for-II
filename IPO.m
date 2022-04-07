clc           ;
clear all     ;
close all     ;
format shortg ;

prompt   = {'Please enter the number of run:'}  ;
title    = 'IPO Algorithm'                      ;
dims     = [1 45]                               ;
nline    = 1                                    ;
definput = {'1','a'}                            ;
answer   = inputdlg(prompt,title,dims,definput) ;
Run_Num  = answer(1,:)                          ;
Run_Num  = str2num(Run_Num{:})                  ;

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

% glocal = 0: Global search, 1: Local search
% localdist: maximum distance used for choosing local balls within it
stallgenlimit = 200 ;
TolFun = inf       ;
% Na = 'testfunc'   ;
localnum = 3        ;
glocal = 0          ;
% cont = num2str(1) ;
% fitnessfunc = [Na, cont] ;
plots = 1        ;
numofruns  = 200 ;
numofdims  = 2  ;       % Exp. 1_1:2, Exp. 1_2:4;  Exp. 2_1:4, Exp. 2_2:6;  Exp. 3_1:9; Exp. 3_2=11;
numofballs = 50  ;

% Exp.  2
        c1     = 0.2  ;
        c2     = 1.7  ;
        shift1 = 1    ;
        shift2 = 80   ;
        scale1 = 0.1  ;
        scale2 = 0.73 ; 

% Exp.  1
%         c1= 0.7184       ;
%         c2= 2.7613       ;
%         shift1= 72.46841 ;
%         shift2= 188.5077 ; 
%         scale1= 0.035    ;
%         scale2= 0824511  ;
        
Xmininit = repmat(-1.2, 1, numofdims) ;     %Exp. 1:-2; Exp. 2:-2; Exp. 3:0;
Xmaxinit = repmat(+1.2, 1, numofdims) ;     %Exp. 1:2; Exp. 2:2; Exp. 3:1;    
% Xmininit = [0.1084 0.5419 1.0837 1.0837 0.5419 0.1084 -0.9853 -0.9738 -0.3864 -0.1112 -0.0113]; 
% Xmaxinit = [0.1084 0.5419 1.0837 1.0837 0.5419 0.1084 -0.9853 -0.9738 -0.3864 -0.1112 -0.0113]; 
%% Loop Main

% fitnessfunc = str2func(Fitfilter);
bestfit = Inf; % stores previous total best
Neval   = 0; % number of evaluating fitness function% 
% expanding Xmin, Xmax to cover all balls
Xmin = repmat(Xmininit, numofballs, 1);
Xmax = repmat(Xmaxinit, numofballs, 1);

% generating initial balls
% an option to generate custom initial balls can be added later
X = Xmin + (Xmax - Xmin) .* rand(numofballs, numofdims);

% initializing balls acceleration
A = zeros(numofballs, numofdims);

% initializes some variables for displaying the results
meanfits = zeros(numofruns, 1);
bests    = zeros(numofruns, 1);
worsts   = zeros(numofruns, 1);

%%%**********************************************************************
N       = rand(size(Hfilt,1),1)    ;     % Between [0 1]
heights = Fitness(X,Hfilt,Wfilt,N) ;
%%%***********************************************************************

Neval = Neval + numofballs;
[tmpbestfit, tmpbestfitidx] = min(heights);
bestfit = tmpbestfit;
bestpop = X(tmpbestfitidx, :);
stallgenctrl = 0;
t = 1;

% if plots
%     hold on;
% end
%% Main loop
while ((t <= numofruns) && (stallgenctrl <= stallgenlimit))
    % calculating the acceleration for each ball
    A(:, :) = 0;
    
    % Choosing global or local algorithm
    % glocal = 0: Global search, 1: Local search
    
    if glocal
        % local version
        for i = 1:numofballs
            dists = dist(X(i, :), X');
            [~, localind] = sort(dists);
            localind = localind(2:localnum + 1);
            
            for j = 1:localnum
                dheight = heights(localind(j)) - heights(i);
                
                % uses better balls to estimate the slope and calculate the
                % acceleration. In addition, it ensures (X(i, :) - X(j, :)) > 0
                % for all dimensions.
                if dheight < 0
                    A(i, :) = A(i, :) + sin(atan(dheight ./ (X(i, :) - X(localind(j), :))));
%                     A(i, :) = A(i, :) + sin(abs(dheight)./(sqrt(((dheight).^2)+((X(i, :) - X(j, :)).^2))));
                end
            end
        end
    else
        % global version
        for i = 1:numofballs
            for j = 1:numofballs
                dheight = heights(j) - heights(i);
                
                % uses better balls to estimate the slope and calculate the
                % acceleration. In addition, it ensures (X(i, :) - X(j, :)) > 0
                % for all dimensions.
                if dheight < 0
                    A(i, :) = A(i, :) + sin(atan(dheight ./ (X(i, :) - X(j, :))));
%                     A(i, :) = A(i, :) + sin(abs(dheight)./(sqrt(((dheight).^2)+((X(i, :) - X(j, :)).^2))));
                end
            end
        end
    end
    
    % sigmoid method for changing coefficient:
    % higher c1: faster convergence in first steps, worst local search
    % lower c1: slower convergence and better global search in first steps,
    % better local search
    % c2 results to better local search
    k1 = c1 ./ (1 + exp((t - shift1) .* scale1));
    k2 = c2 ./ (1 + exp(-(t - shift2) .* scale2));

    % updating balls
    besttoX = repmat(bestpop, numofballs, 1) - X;
    X = X + k1 .* rand(numofballs, numofdims) .* A + ...
        k2 .* rand(numofballs, numofdims) .* besttoX;

    % ensures that all balls lie in the problem's boundaries
    tmpmaxchk = X > Xmax;
    tmpminchk = X < Xmin;
    X = X .* ~(tmpmaxchk | tmpminchk) + Xmax .* tmpmaxchk + Xmin .* tmpminchk;
    
    % evaluates fitness of each ball
    
    %%%*******************************************************************
    heights = Fitness(X,Hfilt,Wfilt,N);
    %%%**********************************************************************
    
    Neval = Neval + numofballs;

    % finding and storing the global best ball and its fitness
    [tmpbestfit, tmpbestfitidx] = min(heights);
    
    if abs(tmpbestfit - bestfit) < TolFun
        stallgenctrl = stallgenctrl + 1;
    else
        stallgenctrl = 0;
    end
    
    if tmpbestfit < bestfit
        bestfit = tmpbestfit;
        bestpop = X(tmpbestfitidx, :);
    end

    % updating variables for displaying the results
    meanfits(t) = mean(heights);
    bests(t) = bestfit;
    worsts(t) = max(heights);
     
    %%
    if plots
        disp(['Iteration ' num2str(t) '  :BestCost= ' num2str(bests(t))]);
%         t
%         plot(t, bests(t), '.r','LineWidth',1);
% %       legend('bests - ipo')
%         xlabel('Iteration')
%         ylabel('Fitness')
%         plot(t, meanfits(t), '.b','LineWidth',4);
%         legend('best','mean')
%         xlabel('Iteration')
%         ylabel('Fitness')
% %         plot(t, worsts(t), '.r');
%         figure(gcf);
%         hold on
    end
    t = t+1;
end

BestsCnvg(n,:)      = bests             ;
Bests(n)            = bests(t-1)        ; 
BestsPop(n,:)       = bestpop           ;
RunTime(n)          = toc               ;
[Bsoa Asoa Z_f P_f] = Matching(bestpop) ;
Stable              = abs(P_f)          ;
if any(Stable > 1)
    NoU          = NoU + 1 ;
    NoU_index(n) = n       ;
end

end
%         disp([' ']);
        disp([' ']);
        disp(['                   IPO                         ']);
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
        
%% Implementation of IIR IPO *******************************

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
legend('Zero','Pole'); xlabel('Real Part'); ylabel('Imaginary Plot');
% title('Pole-Zero Plot in IPO');

figure(3);
H = abs(Hfilt);
Hdb=20*log10(H);
plot(Wfilt/512,Hdb);grid
