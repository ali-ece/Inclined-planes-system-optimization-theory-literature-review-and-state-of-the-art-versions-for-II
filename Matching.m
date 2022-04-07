function [Bipo Aipo Z_f P_f] = Matching(R)

Rsiz = size(R,2);
Bipo = zeros(1, 5);      %for Exp. 3_1
Aipo = zeros(1, 5);      %for Exp. 3_1
% Bipo = zeros(1, 6);      %for Exp. 3_2
% Aipo = zeros(1, 6);      %for Exp. 3_2
% Bipo = zeros(1, Rsiz/2);   %for Exp. 1&2
% Aipo = zeros(1, Rsiz/2);   %for Exp. 1&2

Aipo(1,1)=1;
% for i = 1:Rsiz/2           %for Exp. 1&2
for i = 1:5              %for Exp. 3_1
% for i = 1:6              %for Exp. 3_2 
    Bipo(1,i) = R(i);
%    Aipo(1,i+1) = R((Rsiz/2)+i);      %for Exp. 1&2
    if (i<5) Aipo(1,i+1) = R(5+i); %for Exp. 3_1
%     if (i<6) Aipo(1,i+1) = R(6+i); %for Exp. 3_2
    end                            %for Exp. 3_1&2
end
Z_f = roots(Bipo);
P_f = roots(Aipo);

end




