% Comparison on the criterion of "Sum of Absolute values of Difference (SAD)" for the
% second IIR identification form, Example I (Case 1) with other related
% research

clc
clear all
close all

b0 = +0.0500 ;
b1 = -0.4000 ;
a1 = -1.1314 ;
a2 = +0.2500 ;

bb0 = +0.0500 ;
bb1 = -0.4000 ;
aa1 = +1.1314 ;
aa2 = -0.2500 ;

C = [0.025507    -0.15812     -1.1317     0.54568
     0.049313    -0.85622    -0.57483    -0.22072
     0.04893    -0.40104     -1.1356     0.25536
     0.047027    -0.39966     -1.1298     0.24874] ; % IPO; MIPO; SIPO; and IIPO coefficients, respectively
 
CC = [0.0565 -0.4071 1.1303 -0.2492
      0.0500 -0.4000 1.1314 -0.2500] ; % RWOA and CSHO coefficients, respectively

[k j] = size(C);
F = zeros(k,1);

[kk jj] = size(CC);
FF = zeros(kk,1);
%%

for i=1:k
    
     F(i,1) = (abs(b0 - C(i,1)) + abs(b1 - C(i,2)) + abs(a1 - C(i,3)) + abs(a2 - C(i,4)));
     
end

F
 F_sorted = sort(F)
 
%%

for ii=1:kk
    
     FF(ii,1) = (abs(bb0 - CC(ii,1)) + abs(bb1 - CC(ii,2)) + abs(aa1 - CC(ii,3)) + abs(aa2 - CC(ii,4)));
     
end

FF
 FF_sorted = sort(FF)