% Comparsion on the criterion of "Sum of Absolute values of Difference
% (SAD)" for the second IIR identification form, Example II (Case 1) 
% with other related reseach
clc
clear all
close all
%%

b0 = 0.1084 ;
b1 = 0.5419 ;
b2 = 1.0837 ;
b3 = 1.0837 ;
b4 = 0.5419 ;
b5 = 0.1084 ;
a1 = 0.9853 ;
a2 = 0.9738 ;
a3 = 0.3864 ;
a4 = 0.1112 ;
a5 = 0.0113 ;

bb0 = +0.1084 ;
bb1 = +0.5419 ;
bb2 = +1.0837 ;
bb3 = +1.0837 ;
bb4 = +0.5419 ;
bb5 = +0.1084 ;
aa1 = -0.9853 ;
aa2 = -0.9738 ;
aa3 = -0.3864 ;
aa4 = -0.1112 ;
aa5 = -0.0113 ;

C = [0.1141     0.31998   -0.026119    -0.94999        -1.2    -0.50626        -1.2     -0.5724        -1.2      -0.241   -0.069224
     0.10918     0.45475     0.66622      0.3257   -0.095346    -0.10893     0.16296     0.41359    -0.19718   -0.015632   -0.019597
     0.10908     0.45801     0.69091     0.37747   -0.029498   -0.076846     0.18642     0.50088    -0.16581    0.027351   -0.022799
     0.10346     0.52631       1.011     0.94647     0.41389    0.057029     0.85865     0.84731     0.28509    0.075438    0.011812] ; % IPO; MIPO; SIPO; and IIPO coefficients, respectively

 CC = [0.1081 0.4830 0.8115 0.6048 0.1547 -0.0139 -0.4395 -0.6550 -0.0104 -0.0546 -0.0128] ; % SHO coefficients
 
[k j] = size(C)
F = zeros(k,1);

[kk jj] = size(CC);
FF = zeros(kk,1);
%%

for i=1:k
    
     F(i,1) = (abs(b0 - C(i,1)) + abs(b1 - C(i,2))+ abs(b2 - C(i,3))+ abs(b3 - C(i,4))+ abs(b4 - C(i,5))+ abs(b5 - C(i,6))+ abs(a1 - C(i,7))+ abs(a2 - C(i,8))+ abs(a3 - C(i,9))+ abs(a4 - C(i,10))+ abs(a5 - C(i,11)))
     
end

 F_sorted = sort(F)
 
%%

for ii=1:kk
    
     FF(ii,1) = (abs(bb0 - CC(ii,1)) + abs(bb1 - CC(ii,2))+ abs(bb2 - CC(ii,3))+ abs(bb3 - CC(ii,4))+ abs(bb4 - CC(ii,5))+ abs(bb5 - CC(ii,6))+ abs(aa1 - CC(ii,7))+ abs(aa2 - CC(ii,8))+ abs(aa3 - CC(ii,9))+ abs(aa4 - CC(ii,10))+ abs(aa5 - CC(ii,11)))
     
end

 F_sorted = sort(F)