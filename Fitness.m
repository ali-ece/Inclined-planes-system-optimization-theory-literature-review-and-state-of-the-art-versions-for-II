function [Error] = Fitness(R,Hfilt,Wfilt,N)

Hfsiz = size(Hfilt,1);
% Bfsiz = size(Bf);
% Afsiz = size(Af);
Rsiz1 = size(R,1)     ;
% Rsiz2 = size(R,2)     ;  % for Exp. 1&2

Hfilt_N = zeros(Hfsiz, 1) ;
q_N     = zeros(Hfsiz, 1) ;
F       = zeros(Hfsiz, 1) ;
% Bipo    = zeros(Rsiz1, Rsiz2/2);       % for Exp. 1&2
% Aipo    = zeros(Rsiz1,1+ Rsiz2/2);     % for Exp. 1&2
Bipo  = zeros(Rsiz1, 5) ;            % for Exp. 3_1
Aipo  = zeros(Rsiz1, 5) ;            % for Exp. 3_1
% Bipo  = zeros(Rsiz1, 6) ;            % for Exp. 3_2
% Aipo  = zeros(Rsiz1, 6) ;            % for Exp. 3_2
Error   = zeros(Rsiz1, 1) ;

Aipo(:,1)=1;
% Bipo(1:Rsiz1,1:5) = R(1:Rsiz1,1:5) ;
% Aipo(1:Rsiz1,2:5) = R(1:Rsiz1,6:9) ;

for i = 1:Rsiz1
%     for j = 1:Rsiz2/2                       %for Exp. 1&2
    for j = 1:5                           %for Exp. 3_1
%     for j = 1:6                           %for Exp. 3_2
        Bipo(i,j) = R(i,j);
%         Aipo(i,1+j) = R(i,(Rsiz2/2)+j);     %for Exp. 1&2
        if (j<5) Aipo(i,1+j) = R(i,5+j);  %for Exp. 3_1
%         if (j<6) Aipo(i,1+j) = R(i,6+j);  %for Exp. 3_2
        end                               
    end
    
%%%*********************************************************
    
    [q,Q] = freqz(Bipo(i,:),Aipo(i,:),Hfsiz);
    
%%%*********************************************************

 
%%%*********************************************************

Hfilt_N = Hfilt .* N ; %%%output with input white noise
q_N     = q .* N     ; %%%output with input white noise

%%%*********************************************************
    
    for j = 1:Hfsiz
        F(j,1) = (abs(Hfilt_N(j) - q_N(j)))^ 2;
    end
    
    Error(i,1) = 20*log10((1/Hfsiz)*sum(F)) ;
    
    Hfilt_N = 0 ;
    q_N     = 0 ;
    
end
 end %for Exp. 3_1&2

