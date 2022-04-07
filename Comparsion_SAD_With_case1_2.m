% Comparsion on the criterion of "Sum of Absolute values of Difference
% (SAD)" for the second IIR identification form, Example I (Case 2) 
% with other related reseach
%%

clc
clear all
close all

b0 = -0.311 ;
a1 = -0.906 ;

bb0 = -0.311 ;
aa1 = +0.906 ;

C = [-0.22845    -0.83272
     -0.33195    -0.86763
     -0.26724    -0.91242
     -0.32202     -0.9029] ; % IPO; MIPO; SIPO; and IIPO coefficients, respectively

CC = [-0.2927 0.9033] ; % CSHO coefficients.

[k j] = size(C);
F = zeros(k,1);

[kk jj] = size(CC);
FF = zeros(kk,1);
%%

for i=1:k
    
     F(i,1) = (abs(b0 - C(i,1)) + abs(a1 - C(i,2)));
     
end

F
F_sorted = sort(F)
%%
 
for ii=1:kk
    
     FF(ii,1) = (abs(bb0 - CC(ii,1)) + abs(aa1 - CC(ii,2)));
     
end

FF
FF_sorted = sort(FF)