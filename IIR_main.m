function [h w] = IIR_main()

const = 100          ;
% b = [0.05 -0.4]      ;      % -0.311                   %for Exp. 1                  
% a = [1 -1.1314 0.25] ;      % -0.906                   %for Exp. 1
% b = [-0.3 0.4 -0.5];                                 %for Exp. 2
% a = [1 -1.2 0.5 -0.1];                               %for Exp. 2
b = [0.1084 0.5419 1.0837 1.0837 0.5419 0.1084];     %for Exp. 3
a = [1 0.9853 0.9738 0.3864 0.1112 0.0113];          %for Exp. 3

[h, w] = freqz(b,a,const) ;
% *******************************************************************
h      = awgn(h,30)       ; %40 dB    for IIR
% h = abs(h) + randn(const,1)        % output with measurement noise
% var = 0.001;
% A_N = sqrt(var) * randn(const,1)   % Generating of measurement noise_Normally distributed random numbers
% h = h + A_N                        % output with measurement noise 
% *******************************************************************

%%
% Zero_filter = roots(b);
% Pole_filter = roots(a);
% zplane(Zero_filter,Pole_filter)

end

